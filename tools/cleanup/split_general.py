"""One-off: split the large "general" area into areas by subject (issue #44).

    python -I split_general.py <pack folder>

Each trigger in worlds/plugins/prometheus/general.xml is sorted by the first sound its
function plays, moved with its function into the new area's files, and its function is
renamed to match (General_Wait... becomes Refusals_Wait...). Function bodies, trigger
settings and order of checking are unchanged: MUSHclient orders triggers by sequence
and match text, not by file.
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from edit_triggers import TRIGGER_RE  # noqa: E402

AREAS = [
    ("refusals", "Things you can't do (yet): wait timers, locked hatches, not enough of something."),
    ("game", "Messages from the game itself: prompts, reports, announcements, news, hosts and logging in."),
    ("household", "The ship's furnishings: shower, toilet, drink mixer, canteen, chairs, doors, paper and beeping appliances."),
    ("teleporting", "Teleporters, wormholes, and people beaming in and out."),
    ("money", "Credits: exchanging, paying and checking your balance."),
    ("groups", "Following, joining and leaving groups."),
    ("health", "Medical drones, healing and death."),
    ("items", "Belts, clips, wearing and removing things, Easter eggs."),
    ("games", "Games: winning, losing and extra points."),
]

# The first sound a function plays (its file name, without folder, number or .ogg) -> area.
SOUND_AREAS = [
    (("Cancel", "CantGo"), "refusals"),
    (("Prompt", "Submit", "Announcement", "SubAnnouncement", "LoggedOn", "LoggedOff", "News",
      "NewsFlash", "GameChange"), "game"),
    (("Shower", "Toilet", "Drink", "InsertDrinkDisk", "FillCanteen", "Pour", "OvenBeep", "Paper",
      "Door", "Chair", "Sink"), "household"),
    (("Wormhole", "Teleport", "PersonTeleports"), "teleporting"),
    (("Credits", "ViewInfo"), "money"),
    (("Group",), "groups"),
    (("Medical", "Death"), "health"),
    (("Belt", "ItemWear", "ItemUnwear", "EggItem"), "items"),
    (("YouWin", "YouLose", "ThankYou"), "games"),
]


def area_for(body):
    m = re.search(r'Play\w+Sound\(\s*"([^"]+)"', body)
    if not m:
        return "general"
    path = m.group(1)
    if path.startswith("General/Hosts/"):
        return "game"
    name = re.sub(r"[\d_].*$", "", path.split("/")[-1].replace(".ogg", ""))
    for prefixes, area in SOUND_AREAS:
        if any(name.startswith(p) for p in prefixes):
            return area
    return "general"


def main():
    pack = sys.argv[1]
    xml_dir = os.path.join(pack, "worlds", "plugins", "prometheus")
    lua_dir = os.path.join(pack, "lua", "prometheus", "triggers")
    gxml = os.path.join(xml_dir, "general.xml")
    glua = os.path.join(lua_dir, "general.lua")
    xml = open(gxml, encoding="latin-1").read()
    lua = open(glua, encoding="latin-1").read()

    # The file is: a header comment, then one section per function, separated by blank lines.
    chunks = lua.rstrip("\n").split("\n\n")
    units = {}
    for chunk in chunks:
        m = re.search(r"^function (General_\w+)\(name, line, wildcards\)$", chunk, re.M)
        if m:
            assert chunk.rstrip().endswith("end"), "section doesn't end with end: " + m.group(1)
            assert len(re.findall(r"^function ", chunk, re.M)) == 1, "two functions in one section"
            units[m.group(1)] = chunk + "\n"
        else:
            assert all(ln.startswith("--") for ln in chunk.split("\n")), "unexpected code: " + chunk[:80]

    moved = {a: {"xml": [], "lua": []} for a, _ in AREAS}
    keep_xml = xml
    for block in TRIGGER_RE.findall(xml):
        m = re.search(r'  script="(General_\w+)"', block)
        if not m:
            continue
        fn = m.group(1)
        area = area_for(units[fn])
        if area == "general":
            continue
        new_fn = area.capitalize() + fn[len("General"):]
        moved[area]["xml"].append(block.replace('script="%s"' % fn, 'script="%s"' % new_fn))
        moved[area]["lua"].append(units[fn].replace("function %s(" % fn, "function %s(" % new_fn, 1))
        units[fn] = None  # moved
        keep_xml = keep_xml.replace(block, "", 1)

    # Rebuild general.lua from the sections that stay, in their original order.
    kept = []
    for chunk in chunks:
        m = re.search(r"^function (General_\w+)\(name, line, wildcards\)$", chunk, re.M)
        if not m or units.get(m.group(1)) is not None:
            kept.append(chunk)
    open(gxml, "w", encoding="latin-1", newline="\n").write(keep_xml)
    open(glua, "w", encoding="latin-1", newline="\n").write("\n\n".join(kept) + "\n")
    plugin = os.path.join(pack, "worlds", "plugins", "Prometheus.xml")
    ptext = open(plugin, encoding="latin-1").read()
    for area, desc in AREAS:
        items = moved[area]
        if not items["xml"]:
            continue
        x = ['<?xml version="1.0" encoding="iso-8859-1"?>', "<!DOCTYPE muclient>", "<!-- %s -->" % desc,
             "<!-- The Lua for these triggers is in lua/prometheus/triggers/%s.lua -->" % area,
             "<muclient>", "<triggers>", "", "".join(items["xml"]).rstrip("\n"), "", "</triggers>", "</muclient>", ""]
        open(os.path.join(xml_dir, area + ".xml"), "w", encoding="latin-1", newline="\n").write("\n".join(x))
        l = ["-- %s" % desc, "-- Trigger functions for worlds/plugins/prometheus/%s.xml." % area,
             "-- Each one receives the trigger's name, the whole line, and the wildcards",
             "-- (the parts of the line the trigger's * or (...) matched).", "", "\n".join(items["lua"]).rstrip("\n"), ""]
        open(os.path.join(lua_dir, area + ".lua"), "w", encoding="latin-1", newline="\n").write("\n".join(l))
        ptext = ptext.replace('<include name="prometheus/general.xml"/>',
                              '<include name="prometheus/general.xml"/>\n<include name="prometheus/%s.xml"/>' % area, 1)
        ptext = ptext.replace('require("prometheus.triggers.general")',
                              'require("prometheus.triggers.general")\nrequire("prometheus.triggers.%s")' % area, 1)
        print("%-12s %3d triggers" % (area, len(items["xml"])))
    open(plugin, "w", encoding="latin-1", newline="\n").write(ptext)
    print("%-12s %3d triggers left" % ("general", len(re.findall(r"  script=\"General_", keep_xml))))


if __name__ == "__main__":
    main()
