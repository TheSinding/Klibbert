# Klibbert v1.2.2
A Simple screenshot uploader

##### Depends on:
+ [Maim](https://github.com/naelstrof/maim)
+ [Slop](https://github.com/naelstrof/slop)
+ curl
+ sed
+ hash
+ xdg-open

---

This is just a personal script for uploading screenshots to https://ptpb.pw/   
You are welcome to use it.

##### Usage
klibbert [OPTIONS]

-h Show help

-f Take fullscreen screenshot

-s [filepath] Upload a local picture (Technically this should work with textfiles as well)

-r Take region screenshot, or a shot of a open window.


##### Installation
```
git clone https://github.com/TheSinding/Klibbert
cd klibbert
./install.sh
```

#### That's it! :) 


#### TODO 
+ Add more sites 
+ Add config
+ Add support for more maim things


---


### Changelog

v1.2.2
+ Added -s argument for fileupload

v1.2.1

+ Added notifications! YAY!

v1.2

+ Changed from scrot to maim
+ Removed pastey, used curl inside the script instead
+ Beefed up the install script
+ It's faster now :)

v1.0

+ Initial "release" (It's a script nothing fancy)
