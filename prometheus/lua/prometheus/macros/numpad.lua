-- Author: Rafael Natan
-- Description: numpad 

function NumpadInit()
  if (ConfigTable.Settings.Numpad == 1) then
    Accelerator("Numpad1", "southwest")
    Accelerator("Alt+Numpad1","swd")
    Accelerator("Ctrl+Numpad1","swu")
    Accelerator("Numpad2", "south")
    Accelerator("Alt+Numpad2","sd")
    Accelerator("Ctrl+Numpad2","su")
    Accelerator("Numpad3", "southeast")
    Accelerator("Alt+numpad3","sed")
    Accelerator("Ctrl+Numpad3","seu")
    Accelerator("Numpad4", "west")
    Accelerator("Alt+Numpad4","wd")
    Accelerator("Ctrl+Numpad4","wu")
    Accelerator("Numpad5", "look")
    Accelerator("Numpad6", "east")
    Accelerator("Alt+Numpad6","eastdown")
    Accelerator("Ctrl+Numpad6","eastup")
    Accelerator("Numpad7", "northwest")
    Accelerator("Alt+Numpad7","nwd")
    Accelerator("Ctrl+Numpad7","nwu")
    Accelerator("Numpad8", "north")
    Accelerator("Alt+Numpad8","northdown")
    Accelerator("Ctrl+Numpad8","northup")
    Accelerator("Numpad9", "northeast")
    Accelerator("Divide", "in")
    Accelerator("Alt+Divide","enter")
    Accelerator("Multiply", "out")
    Accelerator("Alt+Multiply","exit")
    Accelerator("Add", "down")
    Accelerator("Subtract", "up")
    Accelerator("Ctrl+I", "north")
    Accelerator("Alt+i","north")
    Accelerator("Alt+k", "south")
    Accelerator("Alt+l", "east")
    Accelerator("Alt+j", "west")
    Accelerator("Alt+o", "northeast")
    Accelerator("Alt+u", "northwest")
    Accelerator("Alt+,", "southeast")
    Accelerator("Alt+n", "southwest")
    Accelerator("Alt+r", "up")
    Accelerator("Alt+f", "down")
  elseif (ConfigTable.Settings.Numpad == 2) then
    Accelerator("Numpad1", "1")
    Accelerator("Alt+Numpad1","-1")
    Accelerator("Ctrl+Numpad1","+1")
    Accelerator("Numpad2", "2")
    Accelerator("Alt+Numpad2","-2")
    Accelerator("Ctrl+Numpad2","+2")
    Accelerator("Numpad3", "3")
    Accelerator("Alt+Numpad3","-3")
    Accelerator("Ctrl+Numpad3","+3")
    Accelerator("Numpad4", "4")
    Accelerator("Alt+Numpad4","-4")
    Accelerator("Ctrl+Numpad4","+4")
    Accelerator("Numpad5", "coords")
    Accelerator("Numpad6", "6")
    Accelerator("Alt+Numpad6","-6")
    Accelerator("Ctrl+Numpad6","+6")
    Accelerator("Numpad7", "7")
    Accelerator("Alt+Numpad7","-7")
    Accelerator("Ctrl+Numpad7","+7")
    Accelerator("Numpad8", "8")
Accelerator("Alt+numpad8","-8")
    Accelerator("Ctrl+Numpad8","+8")
    Accelerator("Numpad9", "9")
    Accelerator("Alt+numpad9","-9")
    Accelerator("Ctrl+Numpad9","+9")
    Accelerator("Divide", "smc")
    Accelerator("Multiply", "nst")
    Accelerator("Add", "-")
    Accelerator("Subtract", "+")
    Accelerator("Alt+I", "8")
    Accelerator("Alt+K", "2")
    Accelerator("Alt+L", "6")
    Accelerator("Alt+J", "4")
    Accelerator("Alt+O", "9")
    Accelerator("Alt+U", "7")
    Accelerator("Alt+,", "3")
    Accelerator("Alt+N", "1")
    Accelerator("Alt+R", "+")
    Accelerator("Alt+F", "-")
  end
end