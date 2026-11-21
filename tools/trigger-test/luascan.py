"""Split Lua source into code, string and comment pieces (just enough for the cleanup tools)."""


def pieces(code):
    """Return a list of (kind, text) where kind is "code", "string" or "comment"."""
    out = []
    buf = []
    i, n = 0, len(code)

    def flush():
        if buf:
            out.append(("code", "".join(buf)))
            buf.clear()

    while i < n:
        c = code[i]
        if code.startswith("--[[", i):
            flush()
            j = code.find("]]", i + 4)
            j = n if j < 0 else j + 2
            out.append(("comment", code[i:j]))
            i = j
        elif code.startswith("--", i):
            flush()
            j = code.find("\n", i)
            j = n if j < 0 else j
            out.append(("comment", code[i:j]))
            i = j
        elif code.startswith("[[", i):
            flush()
            j = code.find("]]", i + 2)
            j = n if j < 0 else j + 2
            out.append(("string", code[i:j]))
            i = j
        elif c in "\"'":
            flush()
            j = i + 1
            while j < n and code[j] != c and code[j] != "\n":
                if code[j] == "\\":
                    j += 1
                j += 1
            out.append(("string", code[i:j + 1]))
            i = j + 1
        else:
            buf.append(c)
            i += 1
    flush()
    return out
