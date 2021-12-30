# Pac-Man Ghost AI Viewer

This script shows the target tiles and the projected path of the ghost AI in Pac-Man (Arcade). 

![pac-man ai viewer](https://user-images.githubusercontent.com/22065181/147719178-22c616fc-8210-47f5-bf99-4821de30921b.png)


## Disclaimer
This is a modified version of a script IsoFrieze made for use in MAME. Most of the code in this repository was written by him. I've simply modified the code to work with the BizHawk emulator instead of MAME. IsoFrieze's original script can be found [here](http://www.dotsarecool.com/rgme/tech/ghost_ai.lua). He also made a great YouTube video detailing how the ghost AI works, which can be seen [here](https://youtu.be/ataGotQ7ir8). A video of his script running in MAME can be found [here](https://youtu.be/Pc_fdSEWRJM).

## How to Use
1) Download [this development version of BizHawk](https://ci.appveyor.com/project/zeromus/bizhawk-udexo/build/artifacts) with MAME support
2) Download the version of BizHawk linked in the first post in [this](http://tasvideos.org/forum/viewtopic.php?t=21778) thread on TASVideos forum. You only need this for a MAME dll file.
3) take "libmamearcade.dll" (in the dll folder) from the second emulator version you downloaded and place it in the dll folder in the first one you downloaded.
4) Open the first folder you downloaded and run EmuHawk.exe
5) Go to File > Open Advanced and select "Launch Game".
6) Open your Pac-Man rom (pacman.zip)
7) Go to Tools > Lua console
8) In the new window that comes up, go to Script > Open Script
9) Select the Pac-Man Ghost AI LUA script.

## Known Issues
The ghosts' target tiles will not be drawn corectly until a ghost gets eaten

The ghost paths should not be drawn during the ghosts' frightened state. This gets corrected when a ghost gets eaten.
