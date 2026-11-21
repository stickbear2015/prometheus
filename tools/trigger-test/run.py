r"""Run the corpus through a plugin and record what happens, or compare two runs.

    python -I run.py record <plugin.xml> <pack folder> <corpus.txt> <results.txt>
    python -I run.py compare <old results.txt> <new results.txt>

The pack folder is the packaged MUSHclient folder (the one holding lua\ and sounds\).
"""
import os
import re
import subprocess
import sys
import tempfile

sys.path.insert(0, __import__('os').path.dirname(__import__('os').path.abspath(__file__)))
import mushtrig  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
LUAJIT = os.environ.get("LUAJIT", r"C:\Users\spopp\AppData\Local\Programs\LuaJIT\bin\luajit.exe")


def lua_str(s):
    out = ['"']
    for ch in s:
        o = ord(ch)
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif o < 32 or o > 126:
            for b in ch.encode("latin-1", "replace"):
                out.append("\\%d" % b)
        else:
            out.append(ch)
    out.append('"')
    return "".join(out)


def read_corpus(path):
    rows = []
    for raw in open(path, encoding="utf-8"):
        raw = raw.rstrip("\n")
        if not raw:
            continue
        cid, settings, line = raw.split("\t", 2)
        sets = {}
        if settings != "-":
            for kv in settings.split(","):
                k, v = kv.split("=")
                sets[k] = int(v)
        rows.append((cid, sets, line))
    return rows


def record(plugin, pack, corpus, results):
    triggers = mushtrig.load_triggers(plugin)
    order = mushtrig.ordered(triggers)
    # A test line with the setting SoundpackDebug=1 runs as if spdebug were on: the
    # debug-only triggers (group "debug"), which spdebug switches on, are checked too.
    debug_triggers = [t for t in triggers if t.group == "debug" and not t.enabled]
    for t in debug_triggers:
        t.enabled = True
    debug_order = mushtrig.ordered(triggers)
    for t in debug_triggers:
        t.enabled = False
    bad = [t for t in triggers if t.error]
    plugin_text = open(plugin, encoding="latin-1").read()
    includes = []
    for inc in re.findall(r'<include\s+name="([^"]+)"', plugin_text):
        path = os.path.join(os.path.dirname(plugin), inc)
        if inc.lower().endswith(".xml"):
            continue  # trigger files; read by mushtrig.load_triggers
        if os.path.exists(path):
            body = open(path, encoding="latin-1").read()
            m = re.search(r"<!\[CDATA\[(.*?)\]\]>", body, re.S)
            includes.append(m.group(1) if m else body)
    scripts = re.findall(r"<script>\s*<!\[CDATA\[(.*?)\]\]>\s*</script>", plugin_text, re.S)
    parts = ["return { includes = {" + ",".join(lua_str(x) for x in includes) + "},",
             "script = " + lua_str("\n".join(scripts)) + ",", "cases = {"]
    for cid, sets, line in read_corpus(corpus):
        fires = []
        for t, m in mushtrig.fire(debug_order if sets.get("SoundpackDebug") else order, line):
            label = t.label()
            omit = "true" if t.omit else "false"
            if t.script:
                wild = "{" + ",".join(lua_str(g or "") for g in m.groups()) + "}"
                fires.append("{kind=\"script\",label=%s,omit=%s,func=%s,name=%s,line=%s,wildcards=%s}" % (
                    lua_str(label), omit, lua_str(t.script), lua_str(t.name), lua_str(line), wild))
            if t.send.strip():
                code = mushtrig.substitute(t.send, m)
                kind = "send" if t.send_to in mushtrig.SCRIPT_SEND_TO else "world"
                fires.append("{kind=%s,label=%s,omit=%s,code=%s}" % (lua_str(kind), lua_str(label), omit, lua_str(code)))
            if not t.script and not t.send.strip():
                fires.append("{kind=\"none\",label=%s,omit=%s}" % (lua_str(label), omit))
        sets_lua = "{" + ",".join("%s=%d" % (k, v) for k, v in sets.items()) + "}"
        parts.append("{id=%s,settings=%s,fires={%s}}," % (lua_str(cid), sets_lua, ",".join(fires)))
    parts.append("}}")
    fd, cases = tempfile.mkstemp(suffix=".lua")
    with os.fdopen(fd, "w", encoding="latin-1", errors="replace") as fh:
        fh.write("\n".join(parts))
    try:
        proc = subprocess.run([LUAJIT, os.path.join(HERE, "harness.lua"), os.path.abspath(pack), cases],
                              capture_output=True, text=True, encoding="latin-1")
    finally:
        os.remove(cases)
    if proc.returncode != 0:
        sys.stderr.write(proc.stderr)
        sys.exit("harness failed")
    with open(results, "w", encoding="utf-8", newline="\n") as fh:
        for t in bad:
            fh.write("badtrigger\t%s\t%s\n" % (t.label(), t.error))
        fh.write(proc.stdout.replace("\r\n", "\n"))
    print("recorded to", results)


def load_results(path):
    cases, current, head = {}, None, []
    for raw in open(path, encoding="utf-8"):
        raw = raw.rstrip("\n")
        if raw.startswith("case\t"):
            current = raw.split("\t", 1)[1]
            cases[current] = []
        elif current is None:
            head.append(raw)
        elif raw.startswith("fire\t"):
            continue  # which trigger fired may change in the cleanup; what it does must not
        elif raw.startswith(("runerror\t", "compileerror\t")):
            # keep the error message, not where it happened (code moves during the cleanup)
            kind, rest = raw.split("\t", 1)
            cases[current].append(kind + "\t" + re.sub(r"^.*?:\d+: ", "", rest))
        else:
            cases[current].append(raw)
    return head, cases


def compare(old, new):
    _, a = load_results(old)
    _, b = load_results(new)
    diffs = 0
    for cid in a:
        if a[cid] != b.get(cid):
            diffs += 1
            print("case %s differs:\n  old: %s\n  new: %s" % (cid, " | ".join(a[cid]), " | ".join(b.get(cid, ["(missing)"]))))
    print("%d of %d cases differ" % (diffs, len(a)))
    return diffs


if __name__ == "__main__":
    if sys.argv[1] == "record":
        record(*sys.argv[2:6])
    elif sys.argv[1] == "compare":
        sys.exit(1 if compare(*sys.argv[2:4]) else 0)
