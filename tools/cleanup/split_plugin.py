"""One-off converter for the cleanup (issue #44): split Prometheus.xml into area files.

    python -I split_plugin.py <original Prometheus.xml> <pack folder>

What it does, without changing what any trigger does:
- Each trigger whose send box runs Lua gets its code moved into a named Lua
  function in lua/prometheus/triggers/<area>.lua, properly indented.
- Game text is passed in as values (wildcards[1], line) instead of being pasted
  into the code as "%1", which fixes triggers breaking on quote marks.
- The triggers themselves go into worlds/plugins/prometheus/<area>.xml, each
  naming its function with script="...". Prometheus.xml includes those files.
- Every other trigger setting (match, sequence, omit and so on) is kept as is.

Areas are chosen from the sounds each trigger plays. The test tool in
tools/trigger-test checks the result against the original.
"""
import os
import re
import sys
from collections import Counter, OrderedDict
from xml.sax.saxutils import quoteattr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "trigger-test"))
import mushtrig  # noqa: E402
import luascan  # noqa: E402

AREAS = OrderedDict([
    ("system", "Soundpack messages from the game (#$# lines), registration and keep-alives."),
    ("comms", "Channels, communicators, the ship's computer announcements and radio traffic."),
    ("starship", "Starship sounds: movement, docking, systems, sensors, mining and repairs."),
    ("combat", "Space and ground combat."),
    ("activities", "Activities: archaeology, pearl diving, shipwrecks, comets and asteroids, harvesting, star research, hatch cracking, derelicts and sifting."),
    ("devices", "Hand-held devices and equipment."),
    ("vehicles", "Vehicles."),
    ("socials", "Socials and emotes."),
    ("movement", "Footsteps and moving around."),
    ("rooms", "Room sounds and ambience."),
    ("general", "Everything else: devices, items, doors, misc messages."),
    ("gags", "Lines that are only hidden, with no sound."),
])

ATTR_ORDER = ["name", "group", "enabled", "match", "regexp", "ignore_case", "keep_evaluating",
              "match_bold", "match_inverse", "match_italic", "omit_from_output", "omit_from_log",
              "expand_variables", "lowercase_wildcard", "sequence", "send_to", "script"]


def area_of(t):
    if t.match.lstrip("^\\").startswith("#") or "#$#" in t.match.replace("\\", ""):
        return "system"
    code = t.send
    scored = Counter()
    for func, path in re.findall(r'(Play\w*Sound)\(\s*"([^"]+)"', code):
        parts = [p.lower() for p in path.split("/")]
        if func == "PlayCombatSound":
            scored["combat"] += 1
        elif func == "PlayRoomSound":
            scored["rooms"] += 1
        else:
            scored[FOLDER_AREAS.get("/".join(parts[:2]), FOLDER_AREAS.get(parts[0], "general"))] += 1
    if not scored:
        return "gags" if not code.strip() or "Play" not in code else "general"
    return scored.most_common(1)[0][0]


# Sound folder (first one or two levels, lower case) -> area.
FOLDER_AREAS = {
    "general/comm": "comms", "general/channels": "comms", "starship/comm": "comms",
    "general/devices": "devices",
    "general/archaeology": "activities", "general/pearldiving": "activities",
    "general/shipwrecks": "activities", "general/comets": "activities", "general/asteroid": "activities",
    "starship/harvesting": "activities", "starship/hatchcracking": "activities",
    "starship/starresearching": "activities", "starship/derelicts": "activities", "sift": "activities",
    "general/socials": "socials", "socials": "socials",
    "starship": "starship", "combat": "combat", "vehicle": "vehicles",
    "footsteps": "movement", "rooms": "rooms", "music": "general", "general": "general",
}


def func_name(area, t, used):
    words = re.findall(r"[A-Za-z]+", t.match.replace("\\", " "))
    words = [w for w in words if len(w) > 1 or w in ("a", "A")][:6]
    base = "".join(w[:1].upper() + w[1:].lower() for w in words) or "Line"
    name = "%s_%s" % (area.capitalize(), base)
    n, final = 2, name
    while final in used:
        final = "%s%d" % (name, n)
        n += 1
    used.add(final)
    return final


VALID_ESCAPES = set("abfnrtv\\\"'\n0123456789")


def tidy_escapes(text):
    """Drop the backslash from escapes Lua doesn't know (like \\.), as Lua 5.1 itself does,
    so the code means the same but is valid in any Lua."""
    out, i = [], 0
    while i < len(text):
        c = text[i]
        if c == "\\" and i + 1 < len(text):
            d = text[i + 1]
            out.append(c + d if d in VALID_ESCAPES else d)
            i += 2
        else:
            out.append(c)
            i += 1
    return "".join(out)


def needs_brackets(pieces_list, index):
    """A joined expression like "a" .. x only needs brackets when used with #, a method
    call (:), indexing ([ or .) or arithmetic right next to it."""
    before = "".join(t for _, t in pieces_list[:index]).rstrip()
    after = "".join(t for _, t in pieces_list[index + 1:]).lstrip()
    return before.endswith(("#", "-", "+", "*", "/", "^", "%")) or after.startswith((":", "[", ".", "+", "-", "*", "/", "^", "%"))


def convert_code(t):
    """Replace %0-%9 inside string literals with values; return Lua code."""
    anchored = (not t.is_regexp) or (t.match.startswith("^") and t.match.endswith("$"))
    out = []
    all_pieces = luascan.pieces(t.send)
    for index, (kind, text) in enumerate(all_pieces):
        if kind == "string" and not text.startswith("[["):
            text = tidy_escapes(text)
        if kind != "string" or not re.search(r"%[0-9]", text):
            out.append(text)
            continue
        if text.startswith("[["):
            open_q, close_q, body = "[[", "]]", text[2:-2]
        else:
            open_q = close_q = text[0]
            body = text[1:-1]
        parts = re.split(r"%([0-9])", body)
        pieces = []
        for i, p in enumerate(parts):
            if i % 2 == 0:
                if p:
                    pieces.append(open_q + p + close_q)
            else:
                n = int(p)
                if n == 0:
                    if not anchored:
                        raise SystemExit("%%0 in an unanchored regexp trigger: " + t.label())
                    pieces.append("line")
                elif t.regex is not None and n > t.regex.groups:
                    pass  # the pattern has no such wildcard; MUSHclient pasted nothing
                else:
                    pieces.append("wildcards[%d]" % n)
        expr = " .. ".join(pieces) if pieces else '""'
        out.append("(" + expr + ")" if len(pieces) > 1 and needs_brackets(all_pieces, index) else expr)
    return "".join(out)


def reindent(code, base=1):
    lines = [ln.strip() for ln in code.replace("\r\n", "\n").split("\n")]
    while lines and not lines[0]:
        lines.pop(0)
    while lines and not lines[-1]:
        lines.pop()
    level = base
    out = []
    for ln in lines:
        if not ln:
            out.append("")
            continue
        code_only = " ".join(text for kind, text in luascan.pieces(ln) if kind == "code")
        words = re.findall(r"[A-Za-z_]+|[{}]", code_only)
        opens = sum(1 for w in words if w in ("then", "do", "function", "repeat", "{"))
        closes = sum(1 for w in words if w in ("end", "until", "}"))
        first = words[0] if words else ""
        if first in ("end", "until", "}"):
            out.append("  " * max(level - 1, 0) + ln)
            level += opens - closes
        elif first == "elseif":
            out.append("  " * max(level - 1, 0) + ln)
            level += opens - closes - 1
        elif first == "else":
            out.append("  " * max(level - 1, 0) + ln)
            level += opens - closes
        else:
            out.append("  " * level + ln)
            level += opens - closes
    return "\n".join(out)


def trigger_xml(t, script=None, keep_send=False):
    attrs = dict(t.attrs)
    if script:
        attrs.pop("send_to", None)
        attrs["script"] = script
    keys = [k for k in ATTR_ORDER if k in attrs] + sorted(k for k in attrs if k not in ATTR_ORDER)
    head = "<trigger\n" + "\n".join("  %s=%s" % (k, quoteattr(attrs[k])) for k in keys) + "\n>"
    if keep_send and t.send.strip():
        from xml.sax.saxutils import escape
        return head + "\n  <send>" + escape(t.send) + "</send>\n</trigger>"
    return head + "</trigger>"


def main():
    plugin, pack = sys.argv[1:3]
    triggers = mushtrig.load_triggers(plugin)
    used = set()
    by_area = OrderedDict((a, []) for a in AREAS)
    for t in triggers:
        area = area_of(t)
        if t.send_to in mushtrig.SCRIPT_SEND_TO and t.send.strip() and not t.script:
            fname = func_name(area, t, used)
            body = reindent(convert_code(t))
            by_area[area].append((t, fname, body))
        else:
            by_area[area].append((t, None, None))

    xml_dir = os.path.join(pack, "worlds", "plugins", "prometheus")
    lua_dir = os.path.join(pack, "lua", "prometheus", "triggers")
    os.makedirs(xml_dir, exist_ok=True)
    os.makedirs(lua_dir, exist_ok=True)
    includes = []
    for area, items in by_area.items():
        if not items:
            continue
        xml = ['<?xml version="1.0" encoding="iso-8859-1"?>', "<!DOCTYPE muclient>",
               "<!-- %s -->" % AREAS[area],
               "<!-- The Lua for these triggers is in lua/prometheus/triggers/%s.lua -->" % area,
               "<muclient>", "<triggers>", ""]
        lua = ["-- %s" % AREAS[area],
               "-- Trigger functions for worlds/plugins/prometheus/%s.xml." % area,
               "-- Each one receives the trigger's name, the whole line, and the wildcards",
               "-- (the parts of the line the trigger's * or (...) matched).", ""]
        for t, fname, body in items:
            if fname:
                xml.append(trigger_xml(t, script=fname))
                lua.append("-- %s" % t.match)
                lua.append("function %s(name, line, wildcards)" % fname)
                lua.append(body)
                lua.append("end")
                lua.append("")
            else:
                xml.append(trigger_xml(t, keep_send=True))
            xml.append("")
        xml += ["</triggers>", "</muclient>", ""]
        with open(os.path.join(xml_dir, area + ".xml"), "w", encoding="latin-1", newline="\n") as fh:
            fh.write("\n".join(xml))
        if any(f for _, f, _ in items):
            with open(os.path.join(lua_dir, area + ".lua"), "w", encoding="latin-1", newline="\n") as fh:
                fh.write("\n".join(lua))
        includes.append(area)
        print("%-9s %4d triggers" % (area, len(items)))

    # New Prometheus.xml: the original header and script, with includes instead of triggers.
    src = open(plugin, encoding="latin-1").read()
    head = src[:src.index("<triggers>")]
    rest = src[src.index("</triggers>") + len("</triggers>"):]
    inc = "\n".join('<include name="prometheus/%s.xml"/>' % a for a in includes)
    req = "\n".join('require("prometheus.triggers.%s")' % a for a in includes
                    if os.path.exists(os.path.join(lua_dir, a + ".lua")))
    rest = rest.replace('require("prometheus.util")\n', 'require("prometheus.util")\n\n-- Trigger functions, one file per area.\n' + req + "\n", 1)
    note = ("<!-- The triggers are split into one file per area, in worlds/plugins/prometheus/.\n"
            "     Their Lua is in lua/prometheus/triggers/. -->\n")
    with open(os.path.join(pack, "worlds", "plugins", "Prometheus.xml"), "w", encoding="latin-1", newline="\n") as fh:
        fh.write(head + note + inc + "\n" + rest)


if __name__ == "__main__":
    main()
