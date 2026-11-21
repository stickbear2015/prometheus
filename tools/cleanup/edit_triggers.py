"""Small helpers for hand-made cleanup edits to the split trigger files (issue #44).

Used from short one-off scripts, for example:

    from edit_triggers import Pack
    pack = Pack(r"C:\\code\\git-src\\prometheus\\prometheus")
    pack.remove_trigger("You press a button.")
    pack.set_attr("You press a button.", "sequence", "90")

Triggers are found by their exact match text. Each edit checks it found exactly one
trigger, so a mistake stops the script instead of editing the wrong thing.
"""
import glob
import os
import re
from xml.sax.saxutils import quoteattr

TRIGGER_RE = re.compile(r"<trigger\n(?:  [^\n]*\n)*?></trigger>\n\n")


class Pack:
    def __init__(self, root):
        self.root = root
        self.xml_dir = os.path.join(root, "worlds", "plugins", "prometheus")
        self.lua_dir = os.path.join(root, "lua", "prometheus", "triggers")

    def _read(self, path):
        return open(path, encoding="latin-1").read()

    def _write(self, path, text):
        open(path, "w", encoding="latin-1", newline="\n").write(text)

    def find(self, match):
        """Return (xml file, trigger block, script name) for the trigger with this match text."""
        want = "  match=" + quoteattr(match) + "\n"
        hits = []
        for path in glob.glob(os.path.join(self.xml_dir, "*.xml")):
            for block in TRIGGER_RE.findall(self._read(path)):
                if want in block:
                    m = re.search(r'  script="([^"]+)"', block)
                    hits.append((path, block, m.group(1) if m else None))
        if len(hits) != 1:
            raise SystemExit("expected one trigger matching %r, found %d" % (match, len(hits)))
        return hits[0]

    def remove_trigger(self, match):
        """Remove a trigger and its Lua function."""
        path, block, script = self.find(match)
        self._write(path, self._read(path).replace(block, "", 1))
        if script:
            self.remove_function(script)

    def remove_function(self, name):
        pat = re.compile(r"-- [^\n]*\nfunction %s\(name, line, wildcards\)\n.*?\nend\n\n" % re.escape(name), re.S)
        for path in glob.glob(os.path.join(self.lua_dir, "*.lua")):
            text = self._read(path)
            if len(pat.findall(text)) == 1:
                self._write(path, pat.sub("", text))
                return
        raise SystemExit("function %s not found exactly once" % name)

    def set_attr(self, match, attr, value):
        """Set (or add) one attribute on a trigger, such as its sequence."""
        path, block, _ = self.find(match)
        line = "  %s=%s\n" % (attr, quoteattr(value))
        if re.search(r"\n  %s=" % attr, block):
            new = re.sub(r"\n  %s=[^\n]*\n" % attr, "\n" + line, block, count=1)
        else:
            new = block.replace("\n></trigger>", "\n" + line.rstrip("\n") + "\n></trigger>", 1)
        self._write(path, self._read(path).replace(block, new, 1))

    def replace_in_function(self, name, old, new):
        """Replace text inside one Lua function's body."""
        pat = re.compile(r"(function %s\(name, line, wildcards\)\n.*?\nend\n)" % re.escape(name), re.S)
        for path in glob.glob(os.path.join(self.lua_dir, "*.lua")):
            text = self._read(path)
            m = pat.search(text)
            if m:
                body = m.group(1)
                if body.count(old) != 1:
                    raise SystemExit("%r found %d times in %s" % (old, body.count(old), name))
                self._write(path, text.replace(body, body.replace(old, new), 1))
                return
        raise SystemExit("function %s not found" % name)
