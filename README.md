# Pac-Man Ghost AI Viewer

This script shows the target tiles and the projected path of the ghost AI in Pac-Man (Arcade). 

![pac-man ai viewer](https://user-images.githubusercontent.com/22065181/147719178-22c616fc-8210-47f5-bf99-4821de30921b.png)


## Disclaimer
This is a modified version of a script IsoFrieze made for use in MAME. Most of the code in this repository was written by him. I've simply modified the code to work with the BizHawk emulator instead of MAME. IsoFrieze's original script can be found [here](http://www.dotsarecool.com/rgme/tech/ghost_ai.lua). He also made a great YouTube video detailing how the ghost AI works, which can be seen [here](https://youtu.be/ataGotQ7ir8). A video of his script running in MAME can be found [here](https://youtu.be/Pc_fdSEWRJM).

## How to Use
1) Download [this development version of BizHawk](https://ci.appveyor.com/project/zeromus/bizhawk-udexo/build/artifacts) with MAME support
2) Run EmuHawk.exe
3) Go to File > Open Advanced and select "Launch Game".
4) Open your Pac-Man rom (pacman.zip)
5) Go to Tools > Lua console
6) In the new window that comes up, go to Script > Open Script
7) Select the Pac-Man Ghost AI LUA script.

You can also drag and drop the script onto the emulator to run it that way.

## Known Issues
The ghosts' target tiles will not be drawn corectly until a ghost gets eaten

The ghost paths should not be drawn during the ghosts' frightened state. This gets corrected when a ghost gets eaten.

## Special Thanks
I'm no expert when it comes to LUA, so this script would not have been possible if IsoFrieze didn't make the original script. I also wouldn't have been able to modify his script correctly without help from YoshiRulz, feos, and CasualPokePlayer from TASVideos.
