"""Read MUSHclient plugin triggers and match game lines the way MUSHclient does.

Used by the trigger test tool (see README.md in this folder). Nothing here
changes the pack; it only reads plugin files.
"""
import os
import re
import xml.etree.ElementTree as ET

# MUSHclient's "send to" values that run the send text as script.
SCRIPT_SEND_TO = {"12", "14"}


class Trigger:
    def __init__(self, index, attrs, send):
        self.index = index  # position in the file
        self.attrs = attrs
        self.send = send
        self.name = attrs.get("name", "")
        self.match = attrs.get("match", "")
        self.enabled = attrs.get("enabled", "n") == "y"
        self.is_regexp = attrs.get("regexp", "n") == "y"
        self.ignore_case = attrs.get("ignore_case", "n") == "y"
        self.keep_evaluating = attrs.get("keep_evaluating", "n") == "y"
        self.omit = attrs.get("omit_from_output", "n") == "y"
        self.sequence = int(attrs.get("sequence", "100"))
        self.send_to = attrs.get("send_to", "0")
        self.script = attrs.get("script", "")
        self.group = attrs.get("group", "")
        flags = re.IGNORECASE if self.ignore_case else 0
        pattern = self.match if self.is_regexp else wildcard_to_regex(self.match)
        try:
            self.regex = re.compile(pattern, flags)
            self.error = None
        except re.error as e:
            self.regex = None
            self.error = str(e)

    def label(self):
        return self.name or "#%d %s" % (self.index, self.match)


def wildcard_to_regex(match):
    """MUSHclient: '*' is a wildcard, everything else is literal, the whole line must match."""
    parts = [re.escape(p) for p in match.split("*")]
    return "^" + "(.*?)".join(parts) + "$"


def trigger_files(path):
    """The plugin file, then any .xml files it pulls in with <include> (MUSHclient looks
    for those relative to the plugin's folder)."""
    files = [path]
    text = open(path, encoding="latin-1").read()
    for inc in re.findall(r'<include\s+name="([^"]+\.xml)"', text):
        files.append(os.path.join(os.path.dirname(path), inc))
    return files


def load_triggers(path):
    """Return the plugin's triggers, including those in included .xml files."""
    triggers = []
    for f in trigger_files(path):
        text = open(f, encoding="latin-1").read()
        # MUSHclient files are XML; parse just the <triggers> sections.
        for section in re.findall(r"<triggers>.*?</triggers>", text, re.S):
            # MUSHclient tolerates a missing space between attributes (attr="x"next="y"); XML doesn't.
            section = re.sub(r'"(?=[A-Za-z_]+=")', '" ', section)
            root = ET.fromstring(section)
            for el in root.findall("trigger"):
                send_el = el.find("send")
                send = send_el.text if send_el is not None and send_el.text else ""
                triggers.append(Trigger(len(triggers), dict(el.attrib), send))
    return triggers


def ordered(triggers):
    """Evaluation order, as MUSHclient does it: by sequence, then by match text.

    From MUSHclient's doc.cpp, CompareTrigger: "identical sequence, sort into match order",
    comparing the match strings (case-sensitive, character by character). File order and
    trigger names play no part. Triggers with the same sequence AND the same match text
    have no defined order; file order is used for those here.
    """
    return sorted((t for t in triggers if t.enabled and t.regex),
                  key=lambda t: (t.sequence, t.match.encode("latin-1", "replace"), t.index))


def substitute(send, m):
    """Expand %0-%9 and %% in send text, exactly as MUSHclient does (no escaping)."""
    def repl(x):
        ch = x.group(1)
        if ch == "%":
            return "%"
        n = int(ch)
        try:
            return m.group(n) or ""
        except IndexError:
            return ""
    return re.sub(r"%([0-9%])", repl, send)


def fire(triggers_in_order, line):
    """Return the list of (trigger, match) that fire for one line, stopping like MUSHclient."""
    fired = []
    for t in triggers_in_order:
        m = t.regex.search(line)
        if not m:
            continue
        fired.append((t, m))
        if not t.keep_evaluating:
            break
    return fired
