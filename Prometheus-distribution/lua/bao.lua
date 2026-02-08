assert  (package.loadlib ("mushmapper.dll","luaopen_mapper")) ()
mushmapper.openmap("rooms_all.h")
mushmapper.settags("gb|wd")
print (mushmapper.getroomname(1928).."to"..mushmapper.getroomname(2310).."---->"..mushmapper.getpath(1928,2310)..)


