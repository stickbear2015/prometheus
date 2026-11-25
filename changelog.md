# Prometheus Soundpack Changes:
## development release

* adds a new updater. the soundpack checks for updates when you connect, and you can type spupdate to check any time. [#14](https://github.com/stickbear2015/prometheus/issues/14)
* makes updating the soundpack faster. [#14](https://github.com/stickbear2015/prometheus/issues/14)
* adds sounds for prospecting. [#8](https://github.com/stickbear2015/prometheus/issues/8)
* editing a plugin from mushclient now opens it in notepad, instead of failing. [#76](https://github.com/stickbear2015/prometheus/issues/76)
* adds spreport, to send a bug report or suggestion from inside the game, and spreports, to read replies to your reports and add more details. [#83](https://github.com/stickbear2015/prometheus/issues/83)

## Version 26.0.1, Kendal's first release.
This release brings almost 50 changes since the last release in february of 2025, and is now maintained by Kendal Hamilton.

* modernizes the installer. [#7](https://github.com/stickbear2015/prometheus/issues/7)
*   the auto retyping plugin no longer  loads by default, it's still available in the plugins directory, but users will have to load it themselves from the plugins dialog. [#18](https://github.com/stickbear2015/prometheus/issues/18)
* updates asteroid sound to the one used in space. [#10](https://github.com/stickbear2015/prometheus/issues/10)
* implements the proper response for the knew server side @lag feature, [#21](https://www.github.com/stickbear2015/prometheus/issues/21)
* at player request, replaces the engine sound with something hopefully more noticeable during large scale invasions and combat. [#29](https://www.github.com/stickbear2015/prometheus/issues/29)
* adds org ooc sound. [#4](https://github.com/stickbear2015/prometheus/issues/4)
* adds house  ooc sound. [#32](https://github.com/stickbear2015/prometheus/issues/32)
* drastically reduces the sounds directory size by killing all unnecessary silence at the beginning  and end of files. note: this may have caused other undesirable issues with sounds, these edge cases will be fixed in a future version. [#36](https://github.com/stickbear2015/prometheus/issues/36)
* replaces locked on you sound, for those that have announcement of enemy locks enabled. [#40](https://github.com/stickbear2015/prometheus/issues/40)
* modernizes the pack, so things are easier to find, and update. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* fixes some sounds not playing, especially when quote marks were present. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* fixes the lock and unlock sounds for vehicle doors being mixed up. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* fixes the low charge sound not playing when a mining vehicle powers down. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* fixes the planetary laser impact sounds stopping after the first sound. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* the command input blocked message is no longer hidden, and now plays a sound. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* distant weapon fire now has a sound. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* the garage, sector scan, laser supplier, and relic explosion messages now play their own sounds instead of a more general one. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* fixes several sounds that never played because the pack looked for them in the wrong place, including the second torpedo sound when your ship launches torpedoes, the stargate exit beep, the chitter when someone types code into a translator, device activation, reflector hits, space power startup, and the lift. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* fixes male sigh sounds and the second male lol sound never playing, because their sound files were misnamed. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* commpipe messages now play their sounds, which never played before: a warning when a mining vehicle's excavation stops because the equipment is damaged or a beam is locked, the low charge sound when a mining vehicle powers down or shuts down, and the detection sounds when a ship reports finding asteroids, shipwrecks, derelicts, debris and so on. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* the computer now plays the shield sound when your weapon fire is blocked by shields. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* the self destruct start sound now plays when the self destruct sequence is initiated. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* pre-recorded host messages on the ooc channel now play the announcement sound. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* the low charge sound now plays when a vehicle's computer screen says excavation can't start because the vehicle is low on charge. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* firing a low-level laser now plays its own sound as well as the pistol sound. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* adds the spdebug command, which shows the hidden soundpack messages the game sends, to help track down sound problems. type it again to hide them. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* channel messages that mention wearing, donning, strapping or removing something no longer play the clothing sound, and now play their channel sound and go into the channel history as they should. [#45](https://github.com/stickbear2015/prometheus/issues/45)
* asks and exclaims said in a room, by you or anyone else, now go into the conversations buffer like says do. [#39](https://github.com/stickbear2015/prometheus/issues/39)
* the wear and unwear sounds now only play when you or someone else actually puts something on or takes it off, not for room and item descriptions, inventories, help text, speech, or messages such as you can't wear any more on your feet. [#16](https://github.com/stickbear2015/prometheus/issues/16)
* translator announcements now put the whole message in the all buffer, not just who said it. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* channel messages that mention saying something no longer lose their channel sound and channel history. [#45](https://github.com/stickbear2015/prometheus/issues/45)
* fixes an error when first opening, connecting or disconnecting on a new copy of the soundpack, before it had saved your settings. [#44](https://github.com/stickbear2015/prometheus/issues/44)
 * Talking on a chat channel (OOC, Chatcomm, Newbie, Soundpacks, PM, ROOC, your organization and so on) no longer sets off game sounds when someone uses words like fire, is dead, input, push a button or tuck away. The message now plays its channel sound and goes into its channel history. [#45](https://github.com/stickbear2015/prometheus/issues/45)
 * Saying, asking or exclaiming something in a room no longer sets off game sounds when it contains words like push a button, open, close or fire. It goes into the Conversations buffer instead. [#45](https://github.com/stickbear2015/prometheus/issues/45)
* emotes can no longer fake a death. a room line such as name is dead! no longer plays the death sound, since it was always a player's emote. real deaths still play the death channel sound, and your own death still plays its sound. [#31](https://github.com/stickbear2015/prometheus/issues/31)
* bodily noise socials (belch, burp, cough, fart, gag, sneeze, vomit and yawn) now only play their sound in the room, not when done over a channel or comms. other socials, such as laughs, giggles and screams, still play on channels as before. [#45](https://github.com/stickbear2015/prometheus/issues/45)
* emoting that you fire a rifle, shotgun, sniper or pistol no longer plays a weapon sound, and the emote is shown as normal. real weapon fire still plays its sound as before. [#45](https://github.com/stickbear2015/prometheus/issues/45)
* emoting that you take aim at someone with a sniper, rifle, shotgun or pistol no longer plays the aiming sound, and the emote is shown as normal. real aiming still plays its sound as before. [#45](https://github.com/stickbear2015/prometheus/issues/45)
* ship attacks such as a massive energy beam fired at an X-Loritan ship play their sound again, and other messages that mention fire, such as promotions on ships with fire in their name, are no longer hidden. [#44](https://github.com/stickbear2015/prometheus/issues/44)
* emoting that you fall to the floor with a sickening thud no longer plays the death sound. creatures really falling still play it as before. [#31](https://github.com/stickbear2015/prometheus/issues/31)
* speech said to someone, such as name (to you): "hey what's up?", now goes into the conversations and all buffers like says do. [#39](https://github.com/stickbear2015/prometheus/issues/39)
* spdebug now also shows what the soundpack does with each line: which trigger caught it (with the line, even if it's normally hidden), each sound it played and whether the file is missing or that kind of sound is switched off, each history buffer it went into, or no trigger if nothing caught it. [#49](https://github.com/stickbear2015/prometheus/issues/49)
* fixes the soundpack failing to load with module not found errors on computers that have another copy of lua installed. [#51](https://github.com/stickbear2015/prometheus/issues/51)
* upgrading the soundpack no longer replaces your settings (config.txt); they're kept, and a new install starts with the default settings. [#7](https://github.com/stickbear2015/prometheus/issues/7)
* spdebug no longer reports a missing sound for channels that don't have their own channel sound, such as pa. nothing you hear changes. [#54](https://github.com/stickbear2015/prometheus/issues/54)
* removes the spupdate command and the old updater, until a new one is designed. for now the soundpack won't tell you when a new version is out. [#14](https://github.com/stickbear2015/prometheus/issues/14)
* the soundpack now shows Kendal Hamilton as its developer, with credit to Krinnzenn, who looked after it before, and Nyano Cooper, who created it. [#57](https://github.com/stickbear2015/prometheus/issues/57)

# previous changes before Kendal took over.
## Version 25.2.1

* Hopefully fixed more broken stuff.
  My thanks to Kira Andrews for all her help in tracking down bugs.
* The repair sound should no longer play twice when you begin repairs on a mining vehicle.
* The notification sound for material packs should now play even if there are more than one of them present.
* Game change notifications are no longer omitted from the output window.
* Also notification sounds have been added for holloween pumpkins, christmas Bells, and chocolate boxes.
* The word, input should no longer trigger its sound when it shouldn't.
  I'm still trying to track down why the words wear, and remove play their sounds when they shouldn't.

## Version 24.10.1

* Hopefully fixed a lot of broken stuff.  Including, but limited to the teleportation and phasing sound mixups.
  In fact, that is primarily what this release is. a bug fix release. Please let me know if anything is still broken.
* My thanks to the red breasted robin for helping me out with some new room sounds, and the addition of a bunch of new helpful aliases.
  I guess I owe him a big bag of bird seed or something. grins.

## Version 23.5.1
This update includes a lot of under the hood changes to allow me  to work more effectively on new sounds and features.
Future releases will also include some changes like these. Maybe you will notice some small performance improvements, or new bugs that come up.
I'm going to try for smaller updates on a more regular basis with shorter update cycles.
Changes in this update:
* Changed the version number to a system kind of  like the one NVDA uses, as I thought it would be easier to understand for you guys, and easier for me to change each time. Seeing as it comes out as, year.month.UpdateNumber
* Introducing the sphelp alias. This will be your goto destination for any help related to this soundpack.
* Replaced mushreader with a more modern plugin utilizing tolk or SAPI for speech output. see 'sphelp tts' for more information.
* Updated Channel history plugin. See 'sphelp channel_history' for more information.
* Option to permanently store Channels and their order, including a certain amount of messages.
* Option to ignore certain channels.
* Enhanced keypad navigation for all directions, including: in, exit and the up and down directions. See 'sphelp keypad'.
* Ftts now keeps its state beyond restarts of MUSHclient.
* Removed the hotkeys alias, Since it's no longer needed with the sphelp system. Please use 'sphelp hotkeys', or 'sphelp settings' respectively.
* Added information about the output functions plugin. See 'sphelp output'
* Added information about soundpack internal aliases for faster game play.
* And much, more documentation. See 'sphelp list' for a full list of all available help-files

## Version 21.8.7
* Added a Commpipe filter for harvesting and the like. It is enabled by default, but can be turned off if desired with Alt+Shift+H.
* Added a feature that speaks the target of the sniper rifle in addition to the click sound.  It is off by default, but can be enabled with, Alt+T.
* Redesigned some of the sounds for the pearl diving activity in an effort to make it more immersive.
* Fixed charging and status display related sounds for vehicles.
* Fixed the issue with the autoRetyping plugin, and pressing enter to pick up all available artifacts. It should work fine now, even with that plugin enabled.

## Version 21.8.6
* Added extra music files, in hopes of adding a bit more variety.
* Added background ambiance for ocean ares.
* Added sifting sounds.
* fixed the issues with background ambiance on relics.
* fixed the issue with corpse decay sounds not playing.
* Fixed the room ambience for river areas on planets.

## Version 21.8.5
* Fixed the sounds for lifting doors.
* Fixed the sounds for the returning of a mining vehicle into the vehicle bay.
* Added sounds for the berry machines.

## Version 21.8.4
* Finally fixed the room ambiance issues with the Obliterator now that I own one, and thus, could do the necessary testing.
  This will hopefully also fix other ship models setup the same way.
* Added sounds for filling canteens with water.
* Fixed the room ambience for the lake areas on planets.

## Version 21.8.3
* Added the capability to update the Soundpack with the spupdate command from this version forward.
  The normal Executable installer will stil continue to be made available at the usual link for first time installs.
* Added sounds for the Medkits.  My thanks to George Rojas for helping out with this, and contributing code to the updater program.
* Moved the skill improvement sounds over from text triggers to OOB. 
* Added sounds for the debris refinery on starships.
* Changed phasing sounds slightly to make the background ambiance of the old location stop as the phasing process begins,
  so it doesn't sound like the the character is still in the old location.
* Groups of two or more creature corpses should no longer growl at you.

## Version 21.8.2
* Added ambiance and  door sounds for apartments and house areas.
* changed the keystroke for hunger and thurst from alt+, to alt+. since the old keystroke seemed to be  conflicting with some of the navigation keystrokes.
* Added a hotkeys command. It sends a list of the soundpack hotkeys to the output window. Useful if you need a quick reminder of the available keystrokes.
* Added a buffer for recently added news articles.
* Added a buffer for HyperNet browser notifications. Things such as new mail, forum posts, etcedra.
* Fixed the sounds for sitting and standing respectively.

## Version 21.8.1
* turn off auto reconnect.
* Ambience and door sounds except for apartments, and houses should work correctly now.
* added sounds for the drink mixer.
* Added a pour sound for pouring liquid into a cup or mug.
* Fixed the sounds for wearing and removing wearable items.
* sinks, showers, and toilets now have sounds too.

## Version 21.8.0
* Krinnzenn started working as of this version.
* Fixed a few regular sound triggers that didn't seem to work.
* Most importantly, implemented a function for processing out of band, (OOB), messages that will ignore unknown messages rather than display them.

## Version 21.7.1
* Fixed the sound trigger when a starship probe has been destroyed by the derelict's onboard security system.
* Added Alt+Letter keys, so you can use both either the numpad keys or the alternative letter keys.
* Removed the old sound trigger for finishing power suppliers recharging.
* Added the sound trigger for receiving new hypermail.
* Fixed the sound for powering up if it is complete and if it fails.
* Fixed the sound trigger for loading/removing cargo from/into the storage room.

## Version 21.5.3
* Renamed the sound file for docking bays, so it can be triggered playing correctly. Thanks to Marcus for pointing it out.
* Fixed the sound trigger if a prevention field is in the sector. The message was changed in the game.
* Fixed the sound trigger if X-Loritan or alien creatures in the same room with you and you look around. corpses of them will no longer trigger that sound any more.
* Fixed the sound triggers when X-Loritan and alien creatures kicks or punches you.

## Version 21.5.2
* Changed some channel sounds. It's now better, hopefully. Let me know what you think
* Added a sound when communications and teleporters are not working, due to either out of communications range or it's blocked.
* Fixed the salvaging message trigger when preparing salvaged things.
* Added sounds when using the walk command.
* Added sounds for sanitation droids.
* Changed the message when a sector has a disruiption field. It's now announced by the starship's computer.
* Removed the 'rdate' alias, it is now within the version alias.

## Version 21.5.1
* Updated the sound trigger to hold someone and who's getting be hold.
* Revamped the sound handling framework to make easier and improved the performance, as well as all made settings should now be saved in the configuration file too, hopefully.
* Added a sound if a UTF Communications Officer informs on General channel about of failed missions.
* Added a sound for trying to fire weapons when being cloaked.
* Changed behaviour of playing fighting sound in rooms only, and no longer on any channels.
* Added playing a random music when a mission is completed successfully.
* Fixed a stupid bug where the sound trigger for computer messages if a target missed, was also triggering for all other computer messages where the word "Miss" was in it.
* Added a social sound for sneeze.
* Added a toggle for the red alarm sounds in starships.
* Updated the readme soundpack file.
* Removed the sound for the 'Uncensored Box' channel due to hosts removed that channel. The Chat channel is already an uncensored one.
* Removed the ability to toggle into the Autosay mode by the hotkey Ctrl+Shift+A.
* Removed the abilitity to force the client to repeat last entered commands by Ctrl+R.
* Fixed the sound trigger for 'hmm' social.
* Added the 'rdate' command to display the release date of this version.
* Updated the soundpack readme file respectively.
* Added the hotkey Ctrl+Shift+L for soundpack reloading if there's something going in a strange way. In some very rare situations it might help, perhaps. If not, let me know.
* Added a sound for a navigation prevention field in the sector.
* Fixed a long-standing bug with playing of the salvaging sound twice. Sorry for that, and thanks for pointing it out.
* Removed self-voicing sounds.
## Version 21.8.7
* Added a Commpipe filter for harvesting and the like. It is enabled by default, but can be turned off if desired with Alt+Shift+H.
* Added a feature that speaks the target of the sniper rifle in addition to the click sound.  It is off by default, but can be enabled with, Alt+T.
* Redesigned some of the sounds for the pearl diving activity in an effort to make it more immersive.
* Fixed charging and status display related sounds for vehicles.
* Fixed the issue with the autoRetyping plugin, and pressing enter to pick up all available artifacts. It should work fine now, even with that plugin enabled.

## Version 21.8.6
* Added extra music files, in hopes of adding a bit more variety.
* Added background ambiance for ocean ares.
* Added sifting sounds.
* fixed the issues with background ambiance on relics.
* fixed the issue with corpse decay sounds not playing.
* Fixed the room ambience for river areas on planets.

## Version 21.8.5
* Fixed the sounds for lifting doors.
* Fixed the sounds for the returning of a mining vehicle into the vehicle bay.
* Added sounds for the berry machines.

## Version 21.8.4
* Finally fixed the room ambiance issues with the Obliterator now that I own one, and thus, could do the necessary testing.
  This will hopefully also fix other ship models setup the same way.
* Added sounds for filling canteens with water.
* Fixed the room ambience for the lake areas on planets.

## Version 21.8.3
* Added the capability to update the Soundpack with the spupdate command from this version forward.
  The normal Executable installer will stil continue to be made available at the usual link for first time installs.
* Added sounds for the Medkits.  My thanks to George Rojas for helping out with this, and contributing code to the updater program.
* Moved the skill improvement sounds over from text triggers to OOB. 
* Added sounds for the debris refinery on starships.
* Changed phasing sounds slightly to make the background ambiance of the old location stop as the phasing process begins,
  so it doesn't sound like the the character is still in the old location.
* Groups of two or more creature corpses should no longer growl at you.

## Version 21.8.2
* Added ambiance and  door sounds for apartments and house areas.
* changed the keystroke for hunger and thurst from alt+, to alt+. since the old keystroke seemed to be  conflicting with some of the navigation keystrokes.
* Added a hotkeys command. It sends a list of the soundpack hotkeys to the output window. Useful if you need a quick reminder of the available keystrokes.
* Added a buffer for recently added news articles.
* Added a buffer for HyperNet browser notifications. Things such as new mail, forum posts, etcedra.
* Fixed the sounds for sitting and standing respectively.

## Version 21.8.1
* turn off auto reconnect.
* Ambience and door sounds except for apartments, and houses should work correctly now.
* added sounds for the drink mixer.
* Added a pour sound for pouring liquid into a cup or mug.
* Fixed the sounds for wearing and removing wearable items.
* sinks, showers, and toilets now have sounds too.

## Version 21.8.0
* Krinnzenn started working as of this version.
* Fixed a few regular sound triggers that didn't seem to work.
* Most importantly, implemented a function for processing out of band, (OOB), messages that will ignore unknown messages rather than display them.

## Version 21.7.1
* Fixed the sound trigger when a starship probe has been destroyed by the derelict's onboard security system.
* Added Alt+Letter keys, so you can use both either the numpad keys or the alternative letter keys.
* Removed the old sound trigger for finishing power suppliers recharging.
* Added the sound trigger for receiving new hypermail.
* Fixed the sound for powering up if it is complete and if it fails.
* Fixed the sound trigger for loading/removing cargo from/into the storage room.

## Version 21.5.3
* Renamed the sound file for docking bays, so it can be triggered playing correctly. Thanks to Marcus for pointing it out.
* Fixed the sound trigger if a prevention field is in the sector. The message was changed in the game.
* Fixed the sound trigger if X-Loritan or alien creatures in the same room with you and you look around. corpses of them will no longer trigger that sound any more.
* Fixed the sound triggers when X-Loritan and alien creatures kicks or punches you.

## Version 21.5.2
* Changed some channel sounds. It's now better, hopefully. Let me know what you think
* Added a sound when communications and teleporters are not working, due to either out of communications range or it's blocked.
* Fixed the salvaging message trigger when preparing salvaged things.
* Added sounds when using the walk command.
* Added sounds for sanitation droids.
* Changed the message when a sector has a disruiption field. It's now announced by the starship's computer.
* Removed the 'rdate' alias, it is now within the version alias.

## Version 21.5.1
* Updated the sound trigger to hold someone and who's getting be hold.
* Revamped the sound handling framework to make easier and improved the performance, as well as all made settings should now be saved in the configuration file too, hopefully.
* Added a sound if a UTF Communications Officer informs on General channel about of failed missions.
* Added a sound for trying to fire weapons when being cloaked.
* Changed behaviour of playing fighting sound in rooms only, and no longer on any channels.
* Added playing a random music when a mission is completed successfully.
* Fixed a stupid bug where the sound trigger for computer messages if a target missed, was also triggering for all other computer messages where the word "Miss" was in it.
* Added a social sound for sneeze.
* Added a toggle for the red alarm sounds in starships.
* Updated the readme soundpack file.
* Removed the sound for the 'Uncensored Box' channel due to hosts removed that channel. The Chat channel is already an uncensored one.
* Removed the ability to toggle into the Autosay mode by the hotkey Ctrl+Shift+A.
* Removed the abilitity to force the client to repeat last entered commands by Ctrl+R.
* Fixed the sound trigger for 'hmm' social.
* Added the 'rdate' command to display the release date of this version.
* Updated the soundpack readme file respectively.
* Added the hotkey Ctrl+Shift+L for soundpack reloading if there's something going in a strange way. In some very rare situations it might help, perhaps. If not, let me know.
* Added a sound for a navigation prevention field in the sector.
* Fixed a long-standing bug with playing of the salvaging sound twice. Sorry for that, and thanks for pointing it out.
* Removed self-voicing sounds.
