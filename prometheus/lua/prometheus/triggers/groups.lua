-- Following, joining and leaving groups.
-- Trigger functions for worlds/plugins/prometheus/groups.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- * indicate*to * that * wish*for * to follow *.
function Groups_IndicateToThatWishForTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupJoin.ogg")
end

-- You follow *.
function Groups_YouFollow(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupFollow.ogg")
end

-- * follow*you into the area.
function Groups_FollowYouIntoTheArea(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupFollow.ogg")
end

-- * request*that * no longer follow *.
function Groups_RequestThatNoLongerFollow(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * ha* away from * group.
function Groups_HaAwayFromGroup(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * left you behind.
function Groups_LeftYouBehind(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * start*following *.
function Groups_StartFollowing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupJoin.ogg")
end

-- * stop*following *.
function Groups_StopFollowing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * disband*group.
function Groups_DisbandGroup(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end
