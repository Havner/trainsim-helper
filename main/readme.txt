Table of contents:
1. Quick introduction
2. Initial setup
3. Script/Overlay setup
4. Joystick setup
5. Patching further locos
6. Keyboard shortcuts and command line switches
7. Distance/Countdown/Odometer usage
8. Additional steamers support
9. Full description
10. Additional notes for the overlay
11. New control values
12. Advanced configuration / custom locos
13. HELP! It doesn't work
14. Modifications of the C++ code
15. The Lua_Out editor
A. Acknowledgements
B. Licence


1. Quick introduction

  This is a little helper for Train Simulator 2014/2015 that I wrote for my
  own needs to improve on the limitations of the game. The first is the poor
  in-game interface. The F3/F4 views show too much and obscure the view
  killing the immersion. The F5 view on the other hand lacks few things. The
  second thing is joystick support. This software tries to fix them
  both.

  NOTE 1: This software CAN be used without a joystick. It will warn
  you that you don't have any connected each time you run it but the
  overlay will work fine anyway. See the command line switches on how
  to supress the warning permanently.

  NOTE 2: This software does not handle switches and shortcuts for the
  joystick. For this use your joystick's software (Thrustmaster,
  Logitech, Saitek) to assign keyboard shortcuts. This software handles
  axes only: Reverser, CombinedThrottle, Throttle, TrainBrake,
  LocoBrake, DynamicBrake, AFB.

  I wrote a guide on how to customize loco controls:
  http://forums.uktrainsim.com/viewtopic.php?f=361&t=139086

  If you have a custom joystick you can try those for the switches:
  http://joytokey.net/en/
  http://www.emulation-evolved.net/
  http://www.deinmeister.de/jct_e.htm

  NOTE 3: There is no Steam Locos support in this software as I don't
  drive them, but in principle it could be added.

  The full description on how it works and what can you possibly do
  with that starts at section 9. Also mind you, this is not all GUI
  software. Also because of the way it works (injecting itself into LUA
  scripts) it requires to get your hands dirty a little. Read
  carefully and tread lightly. Make backups and prepare some good text
  editor. Most people use Notepad++ from what I've noticed.

  This software with full source code released can also be a great
  developer's resource on making custom UIs and/or other different
  things.

  Without further ado I'll get to how to initially configure it.

2. Initial setup

  In the package you have several files (.EXE, .LUA and .TXT) and a
  directory (with another .EXE and .LUA). Put the main .EXE and all
  .LUA files from the main directory directly into the RailWorks\plugin
  directory. Usually in:
  C:\Program Files (x86)\Steam\steamapps\common\railworks\plugins
  You should have something like:

  \plugins\transim-helper.exe
  \plugins\transim-helper.lua
  \plugins\transim-helper-overlay.lua
  \plugins\transim-helper-joystick.lua

  The trainsim-helper-lua-out directory you can put wherever you want.

  Run the game and set it to run in the Borderless Window under
  graphics settings. This is required for the overlay to be
  shown. The only drawback is that VSync won't work in this mode. On
  the plus side Alt-Tabbing is much faster and safer now. Even if
  you're not interested in the Overlay please do it now as we'll need
  it to confirm whether the script is working properly.

3. Script/Overlay setup

  Now we'll patch a loco. For the first one, that we'll use as an
  example pick something relatively simple. Some old US locos from the
  "US Locos and Assets" pack are fine. All the Sherman Hill locos as
  well. And ICE2/ICE3, Class 375/377/395 should be fine as well as I
  tested those the most.

  Make sure the loco you want to patch is unpacked from .AP files (use
  RW_Tools or any other packager to unpack RailVehicles folder).

  Make sure you know how to run this particular engine. If you have
  multiple locos of the same type selecting it in the QD might run a
  different copy of this loco from a different directory/route/pack
  depending on what you select as a consist.

  Run the trainsim-helper-lua-out.exe (making sure you have the
  accompanying template file in the same directory). Click "Select
  File". You should be in the RailWorks directory. Navigate to the
  chosen loco directory and find a .LUA/.OUT engine script of that loco
  (usually it will be an .OUT file). Most locos have 2 scripts. Engine
  and Simulation. They might be in the following subfolders in the
  loco directory:

  LIVERY_NAME_OF_THE_LOCO/
  CommonScripts/
  Engine/
  Default/
  Simulation/

  You need to find the Engine one. It should have an "engine" in its
  name and not have a "simulation". Although that varies. Click it and
  the program should process the script automatically. Original script
  will be renamed and a new one under the original file name will
  appear. You need both now.

  Now run the game (in Borderless Window mode). After you are in the
  main menu Alt-Tab from the game and run trainsim-helper.exe from the
  plugins directory (it is important for this program to have a
  working folder set to plugins/). It might warn you that you don't
  have a joystick if that is the case.

  After you run it, it should move you back in the game and you should
  see "TrainSim Helper $VERSION active" in the lower left corner.

  Now run some scenario/QD/whatever with the loco you previously
  patched. If after the game loads you see the full overlay in the
  lower left corner that means the loco was patched successfully and
  my script is running properly.

  This also concludes setting up an overlay. The helper program will
  run only when the game is running and will quit together with it so
  you need to always relaunch it when launching the game.

4. Joystick setup

  While the game and my helper is running and you see the full overlay,
  Alt-Tab from the game and navigate to the plugins/ directory. You
  should find 2 new .TXT files there:

  trainsim-helper-overlay.txt
  trainsim-helper-joystick.txt

  They are used to exchange data between the .LUA and .EXE. Make sure
  that my helper did not warn you about a lack of the joystick when
  you launched it (you can also confirm in the Windows Control Panel
  that your joystick(s) is/are attached and working properly).

  Open the trainsim-helper-joystick.txt (this can be in notepad,
  doesn't matter). You should see all axes of your joystick listed
  there with a value and axis name. Pick what you want to use. Either
  by name or by moving the axis, closing the .txt file, reopen it and
  noticing what has changed. There is a # sign and a number following
  it. This is a line number in the file. Remember the numbers of all
  the lines/axes you want to use.

  Now open the trainsim-helper-joystick.lua. This has to be done in a
  good text editor. At the top of the file, below the
  function ConfigureJoystick()
  line you have few variables (CombinedThrottleLine = 3, etc). Assign
  line numbers of the axes you want to use to the controls you want to
  use. Comment out rest of them. Further below you have variables for
  invert. I think this is self explanatory (of course you will know
  whether you need an invert after first run, so don't change anything
  now). Save the file.

  Run the game again using your patched loco and see whether the axes
  do anything. Remember that for some scripted locos the axes might
  move only with the Reverser set, or some other condition.

  If you got it working that is basically it. If it doesn't, post a
  note on the UKTrainSim forums in the release thread. I'll try to
  help you there.

5. Patching further locos

  Now what is left is to patch all the locos/engines you want this
  program to run with. Unfortunately there is no single place to do
  this once for the whole game. Every loco has to be patched
  separately.

  Use the attached lua-out program for that. For the most cases you
  can patch either an Engine or a Simulation script (not both though)
  but in some rare cases Engine script is required so just get in the
  habit of patching this one not to get into troubles later on.

6. Keyboard shortcuts and command line switches

   cmd line switch | keyboard shortcut |           function
  -----------------|-------------------|--------------------------------
         -j        |       n/a         |       disables joystick
                   |                   |      support and warning
  -----------------|-------------------|--------------------------------
         -v        |    SHIFT+ALT+v    |   toggles the overlay display
  -----------------|-------------------|--------------------------------
         -1        |   SHIFT+ALT+F1    |      toggles the speed
  -----------------|-------------------|--------------------------------
         -2        |   SHIFT+ALT+F2    |  toggles the boiler pressure
  -----------------|-------------------|--------------------------------
         -3        |   SHIFT+ALT+F2    | toggles the distance/countdown
  -----------------|-------------------|--------------------------------
         -4        |   SHIFT+ALT+F3    |    toggles the next limit
  -----------------|-------------------|--------------------------------
         -5        |   SHIFT+ALT+F4    |   toggles the acceleration
  -----------------|-------------------|--------------------------------
         -6        |   SHIFT+ALT+F5    |     toggles the controls
  -----------------|-------------------|--------------------------------
         -7        |   SHIFT+ALT+F6    |     toggles the indicators
  -----------------|-------------------|--------------------------------
         -8        |   SHIFT+ALT+F8    |     toggles the gradient
  -----------------|-------------------|--------------------------------
         -9        |   SHIFT+ALT+F9    | toggles the driver's indicators
  -----------------|-------------------|--------------------------------
         -10       |   SHIFT+ALT+F10   |toggles the fireman's indicators
  -----------------|-------------------|--------------------------------
         -11       |   SHIFT+ALT+F11   |      toggles the clock
  -----------------|-------------------|--------------------------------
         -12       |   SHIFT+ALT+F12   | toggles warnings (AWS, DSD...)
  -----------------|-------------------|--------------------------------
    runtime only   |    SHIFT+ALT+r    |      reset the distance
                   |                   |      turn off countdown
  -----------------|-------------------|--------------------------------
    runtime only   |  SHIFT+ALT+(0-9)  |      setup the countdown
  -----------------|-------------------|--------------------------------
    runtime only   |    SHIFT+ALT+s    |         invert side
  -----------------|-------------------|--------------------------------

  By default everything is turned on. If you want to permanently
  disable some function make a shortcut to the trainsim-helper.exe,
  and in its properties add the switches for the functions you don't want.

  Command line switches are toggles as well, they accumulate. If you
  pass a single "-1" you will disable current speed. But if you pass
  it twice "-1 -1" you will end up with it being enabled again.

7. Distance/Countdown/Odometer usage

  There is no way to get the distance to the next task from the game
  itself, but based on what I do have (time and speed) I've
  implemented an internal odometer. It calculates the distance within
  the helper itself from delta time and momentary speed. Because of
  that it's not 100% accurate, but it's very accurate nontheless. It
  shouldn't deviate more then 0.01 mile per 10 miles.

  When you launch the overlay you'll notice distance below the
  speed. It will be 0 at the start and count up by default. You can
  reset it with SHIFT+ALT+R. You can use it however you like.

  Its second mode is Countdown. It can count down from a set value to
  e.g. tell you how far you have to the next stop. When you're on the
  station have a look at time table. See next distance. Enter it and
  it will count down. Below 1 (mile/km) it will turn yellow. Below 0
  it will turn red.

  To set it up hold SHIFT+ALT and type 4 digits that will compose the
  set distance in miles/km. So to enter 12.34 hit SHIFT+ALT and while
  holding them 1, 2, 3, 4. To set up 3.76 hit SHIFT+ALT and while
  holding them 0, 3, 7, 6. You will see what you enter in the middle
  of the screen. After you enter the countdown will initiate
  immediately with the press of the last digit and your selection will
  be visible on the screen for one more second. If you change your
  mind while entering just stop. Incomplete selection will disappear
  and be ignored after 5 seconds. If you want to return to the Distance
  mode hit SHIFT+ALT+R.

  To see this in action look here:
  http://forums.uktrainsim.com/viewtopic.php?p=1723307#p1723307

8. Additional steamers support

  From version 0.5 the steamers received additional support. For the
  controlling nothing's changed. You still have Regulator(Throttle),
  Reverser and Brakes. The change is with the Overlay.

  - Boiler pressure got added with color indicators depending on
    whether the pressure is increasing (green), constant (grey) and
    decreasing (red).
  - Steam chest pressure in the indicators section. Some steamers have
    this.
  - Additional section for the driver's controls. This is something I
    have not done for non-steamers as there is no need. You can usualy
    see in what state your headlights, wipers or other non essential
    stuff is. This is not necessarily true for steamers as the valves
    can be hard to read and sometimes are in difficult to see
    locations. This is not a complete list, but I've added them based
    on the locos I own (list below) and they are shared throughout
    most steamers. If a control is not there you can still drive
    without problems. Let me know if there is a control from a steamer
    I don't own and you'd like it to be there. Those controls have
    been added to the new section on the left hand side of the screen,
    right of the main overlay.
  - Additional section for the fireman's controls and indicators. Those
    are the things that are disabled with auto fireman plus water and
    firebox levels. You can use it with manual fireman or just see how
    the auto fireman is working. Also there are safety valves that are
    always automatic.

  Steamers I have for which I've added all the indicators:
  - Black 5 4-6-0            (EU pack)
  - BR52 2-10-0              (EU pack)
  - 7F 2-8-0                 (EU pack)
  - Fowler 4F                (Academy)
  - GWR Modified Hall        (West Somerset Railway)
  - SDJR 7F                  (West Somerset Railway)
  - Castle Class             (DLC)
  - Class A4 Pacifics        (DLC)
  - Duches of Sutherland     (DLC)
  - The Spirit of Halloween  (Halloween Route 2014)

9. Full description

  First of all why have I wrote it?
  - I hate F3/F4 views, they kill immersion for me, obscure the
    view and show lots of unwanted (for me) informations that cheat the
    game (locations of signals, speed limits, tasks, etc).
  - But still the cockpit in most locos displays too little, hence the
    F5 interface is nice, but it has some limitations.

  I tried to overcome those here.
  - F5 does not have a clock, I find it tedious to turn on F3 just to
    see the clock. Here I can show it always and it plays nice with F1.
  - The whole overlay is always shown, even with F1 view so I can
    control my speed while looking at the plan.
  - Immediate view of the current speed limit and overspeed (speed
    indicator is red on overspeed and yellow if driving backwards).
  - It can display AWS/DSD/Emergency brake warnings and also in
    external view so you won't get caught while admiring the views.

  And most importantly as it's a custom code I can display whatever,
  wherever in a format I want. I could move the whole overlay to the
  upper right corner. Display the warnings in the middle of the
  screen. I could even draw a custom speedometer based on graphics (as
  it's drawn on a D3D surface).

  How does it work?  It consists of 2 parts.

  LUA scripts:
  You need to inject an execution of a script into every loco's
  engine script file. The script does 2 things:
  - It exports simulation data to a text file (speed, limits,
    reverser, warning, etc, everything that I display).
  - It also reads another text file with values from my joystick
    and feed the sim with those. With this I can control every train
    with a joystick, even scripted ones (BR101, VirtualThrottle,
    VirtualBrake), RailDriver interface can't handle those.

  Custom C++ based code that also does two things:
  - It reads my joystick's axes values using DirectInput and writes
    them to a text file that script is reading.
  - It reads the exported data, parses it and displays an overlay
    using a D3D surface.

  All the parts try to autodetect as many things as possible. The LUA
  script tries to detect proper ControlValues names, their ranges and
  some other custom stuff. I put as much as I found for the locos I
  have and I will supplement the list in the future releases.

  Also the data displayed in the overlay tries to autodect stuff and
  put them only if they exist. Some values have different control
  values in different locos (brakes, target speed, etc).

  The C part autodetect up to 8 joysticks and axes they use. It adds
  comments to the output joystick txt file so it's easier to see what
  is what.

10. Additional notes for the overlay

  Next Limit:
    It happens sometimes that the Next Limit speed has undefined
    value. I have no idea why, but when that happens I display
    '??'. Nothing more I can do about that. It happens around track
    changes and for a very short distances so it's not really an
    issue.

  Acceleration:
    Its sign (+/-) might be counter intuitive sometimes. In general if
    it's positive you;re accelerating, if it's negative you're
    decelerating. But... if you're driving backwards it's the other
    way around. Also if you switch cabs it might be the other way
    around as well. I don't implement this variable. I pull it out of
    the game and it is like this there.

  Gradient:
    Its sign (+/-) might be counter intuitive. It's not dependent on
    the loco, direction you're driving etc. It's a route
    characteristic. So if a route shows you positive values for an
    uphill when driving north it will always be like this. If you
    switch cab and go backwards on this uphill (effectively downhill)
    it will still be positive.

  Ammeter:
    If it's not displayed properly (clamped on minimum/maximum
    values too early) you can edit loco .bin file in the RW_Tools and
    change Minimum/Maximum value for the Ammeter ControlValue.
    E.g. for SD70M (-900, 1500) is nice as it has 0 as Minimum initially
    hence you won't see the negative values for the DynamicBrake.
    Note that for some locos that display accurate ammeter values in the
    cab this will rescale the needle. But such locos on the other hand
    have those ranges set properly already.

-----------------------------------------------------------------------
  From this point onwards some basic LUA skills are required. Remember
  that the LUA code is very fragile and if you make a mistake you
  won't get any notification from the game apart that it won't work at
  all.
-----------------------------------------------------------------------

11. New control values

  If the script is working fine for you for the most locos but others
  are problematic first of all post in the release thread. I want to
  know about it. Secondly you can try to fix/add/customize this
  yourself.

  In the trainsim-helper-joystick.lua there are functions to find
  correct ControlValues names for a specific control:

  function FindCombinedThrottle()
  function FindTrainBrake()
  ...

  If your loco is using a ControlValue not mentioned there add it to a
  specific function at the top. The script should handle the rest
  automatically.

  If you want to add a completely new control (let's say some steam
  control) see how the others are done. AFB is a good example as it's
  last. Make a configuration (*Line, *Invert, *Control, *Range) and
  add code for reading and setting proper joystick values exported in
  the joystick.txt file. You don't have to modify the C++ part.

12. Advanced configuration / custom locos

  It is possible to customize controls per loco. There is no simple
  way to detect a loco you are driving though. I use a unique set of
  ControlValues a loco has to recognize it. See the example functions
  in the trainsim-helper.lua script:

  function DetectClass365()
  function DetectClass395()
  ...

  You have to open an engine.bin in RW_Tools and look for control
  values and prepare a set that will identify this loco and hopefully
  only this one. Make a new function for it.

  Then in the ConfigureJoystick() you can customize settings for this
  specific loco. I've added few examples.

  Worth noting is that for a control to work it has to have those
  values set:
  *Line         (to know where to take the joystick data from)
  *Control      (to know which variable in the sim to control)
  *Range        (will be autodetected, you can override it)

  Those are optional:
  *Invert       (self explanatory)
  *Notches      (sets a nothed lever)
  *CenterDetent (works only for Reverser and CombinedThrottle)

  *Notches has to be a table with values between
  <MinControlValue, MaxControlValue>.
  It defines values the axis will clamp to. They are applied _AFTER_
  the range rescaling. The easiest way to set them properly is to have a
  look at the loco .bin file and copy/paste the notched values for a
  specific control from there.

  If you want to make the lever continuous before or after some
  values then don't define a full range. If you have a control with
  range {-1, 1} and define notches as {-0.5, 0, 0.25, 0.5, 0.7} then in
  the ranges of {-1, -0.5} and {0.7, 1} the lever will be continuous.
  To make it fully notched make sure border values (-1 and 1 in this
  case) are on the list.

  Notches take precedence over CenterDetent if both are defined.

  There is also a helper function to create a nothed lever with N
  equal notches. See the examples. Also if the range is not within <0,1>
  you need to pass it as a parameter.

  GenerateEqualNotches(5) will give:
  {0, 0.25, 0.5, 0.75, 1}
  GenerateEqualNotches(5,r) for r = {-1,1} will give:
  {-1, -0.5, 0, 0.5, 1}

  You can also configure the overlay a little in the
  trainsim-helper-overlay.lua script.
  You can redefine warning texts and set UK Gradient format
  (1:XXX). Those things can be set globally or per loco using the same
  loco detection functions as described above.

  In summary:
  - trainsim-helper.lua: loco detections and main frame update function.
  - trainsim-helper-overlay.lua: Overlay configuration an implementation.
  - trainsim-helper-joystick.lua: Joystick configuration an implementation.

13. HELP! It doesn't work

  Forum thread:
  http://forums.uktrainsim.com/viewtopic.php?f=361&t=139304

  If you can't get it to work at all re-read the readme, try
  again. From what I've seen so far none of the poeple I've spoken to
  have not had major problems to get it to work. It's a little bit
  complicated but definitely doable.

  If in general it works but you have only problems with one loco:

  Q: The overlay doesn't work for one loco, all you can see is
     "TrainSim Helper Active"
  A: Let me know ASAP on the forums and see below about sending me
     some files.
  Q: I can see the overlay but the joystick only seem to apply the
     very minimum and very maximum values, nothing in between.
  A: There are some locos with notched levers scripted in a way that
     they require you to set very specific values for the
     ControlValue. It means you NEED notches definitions for this
     loco. See the examples above and try to do it. If you fail write
     on the forums and see below about sending me some files.
  Q: The joystick only works for some levers. Or it works for all but
     the levers in the cab don't move or any other 'kinda works, but not
     exactly as it should'.
  A: It most probably means that this loco has some control values I
     don't know about. See section 9 of this readme and tell me about
     in the forums. Also see below for sending me some files.

  Sending some files to me when help is requested:
  If you have a problem with a specific loco (not all of them, when
  generally things work for you, but not for a specific loco) write on
  the forums and send be the files listed below so I can investigate:

  1. Input mapper. There should be an InputMapper directory somewhere
     in the addon. Probably in its top level, although on rare
     occasions it might be deeper. Maybe somewhere in the
     RailVehicles. Send me all files from this directory.
  2. Scripts. There should be at least 2 scripts per loco. Engine and
     simulation. Either with .lua or .out (or both) extensions. They
     are somewhere in the loco's dir (as described in section 3). Send
     me all of them.
  3. The main loco's definition file. It's a .bin file somewhere in
     the loco's dir. It's usually named by the Livery name or
     "Default" or "Engine". Its name varies. Usually it will be named
     similarly to the loco name.

-----------------------------------------------------------------------
  From this point onwards you need to code in C++/C# and have a
  VisualStudio installed (Express is fine, I use 2010). Also a DirectX
  SDK will be required. Windows 8 might that builtin, not sure
  though. For Windows 7 you need DXSDK_Jun10.exe.

  Source code available here:
  https://github.com/Havner/trainsim-helper
-----------------------------------------------------------------------

14. Modifications of the C++ code

  I'll just note for now that the C++ code is not very nicely written
  yet (conrary to the LUA) as I just patched all of this together to
  work. I'll get to cleaning this at some point.

  The things you can do with it:

  - Change placement/colors/fonts of the UI.
  - Add new values to be displayed in the Overlay (you need to export
    them first with LUA.
  - Write your own UI, you have a D3D surface there and data exported
    from the sim. Do whatever your imagination lets you.

  NOTE: Have a look at Config.h as the DEBUG and RELEASE versions look
  for the plugins directory in different ways.

15. The Lua_Out editor

  This is C# which I know very little about. It's based on CobraOne
  patcher available here:
  https://www.dropbox.com/sh/paxigk37gqd9vll/AAA8pjmAzYVCAuwHrrgYmxENa
  But the new method used is by nschichan so I don't have to recompile
  the LUA code at all.

A. Acknowledgements

  CobraOne for an initial inspiration. I always planned to write this
  software but his work on data extractor and on figuring out how to
  patch binary LUA bytecode files made me write this sooner then
  later. My current Lua_Out editor is heavily based on his program,
  although the current method used here is different.

  linuxbox for pointing this new method and for notches implementation.
  nschichan for the idea itself.

  The C++ part uses code from here:
  http://code.msdn.microsoft.com/windowsdesktop/DirectInput-Samples-8ac6f5e3/sourcecode?fileId=121930&pathId=1414531679
  http://www.unknowncheats.me/forum/c-and-c/84234-c-external-directx-overlay-translated-c.html

B. Licence

  Basically free for non-commercial use. You can modify the code,
  adapt it to your own needs. Just don't forget about acknowledgements
  and please note that not all code here originates from my own mind
  so treat it with respect. I don't know the License for the code that
  is not mine as it didn't come with a License note.

Lukasz 'Havner' Pawelczyk
havner@gmail.com
