-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
----------------  Joystick configuration  -----------------
-----------------------------------------------------------

function ConfigureJoystick()
   -- Lines count from 1, not 0 to make easier for non programmers. Line["CombinedThrottle"] and
   -- Line["Throttle"] can have the same value, they are mutually exclusive and never used together.
   -- Per loco configurations are further down in the function.
   -- Some controls might be used to control other things (based on a loco), but only
   --   if you have not setup those controls explicitly. See "Havner's config" sections
   --   and ReplaceLines() calls. This can be disabled with DisableReplace below.
   -- To disable a control or an invert set it to 0 or comment out.

   --Line["Reverser"] = 7
   --Line["Gear"] = 7
   --Line["CruiseCtl"] = 7
   Line["CombinedThrottle"] = 3
   Line["Throttle"] = 3
   Line["TrainBrake"] = 6
   Line["LocoBrake"] = 10      -- might also be used for HandBrake if it's not explicitly set
   Line["DynamicBrake"] = 7    -- might also be used for Reverser, Gear or CruiseCtl if they're not explicitly set
   --Line["HandBrake"] = 10
   Line["SmallEjector"] = 12
   Line["Blower"] = 14
   Line["FireboxDoor"] = 18    -- FEF-3: Atomizer
   Line["Stoking"] = 19        -- FEF-3: Oil Regulator
   Line["ExhaustSteam"] = 20   -- FEF-3: Damper
   Line["ExhaustWater"] = 15   -- FEF-3: Feedwater Pump
   Line["LiveSteam"] = 16
   Line["LiveWater"] = 17

   Invert["Reverser"] = 1
   Invert["Gear"] = 1
   Invert["CruiseCtl"] = 1
   Invert["CombinedThrottle"] = 1
   Invert["Throttle"] = 1
   --Invert["TrainBrake"] = 1
   --Invert["LocoBrake"] = 1
   --Invert["DynamicBrake"] = 1
   --Invert["HandBrake"] = 1
   Invert["SmallEjector"] = 1
   --Invert["Blower"] = 1
   Invert["FireboxDoor"] = 1
   Invert["Stoking"] = 1
   Invert["ExhaustSteam"] = 1
   Invert["ExhaustWater"] = 1
   Invert["LiveSteam"] = 1
   Invert["LiveWater"] = 1

   --CenterDetent["Reverser"] = 0.05
   --CenterDetent["CombinedThrottle"] = 0.05

   -- Sync virtual values with physical ones on start of the sim
   -- after that many seconds. Set to 0 or comment out to disable.
   -- This also disables the throttles before this time's elapsed.
   -- Increase the number if it doesn't work or the loco script is
   -- messing with the values on start. Can be set per loco.
   --SyncOnStart = 0.1

   -- Disable all the ReplaceLines() calls. Meaning you will only get
   -- the axes you configure above, my own configs won't bother you.
   --DisableReplace = 1

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues a loco has and detect what to use.
   -- If combined doesn't exist configure separate throttle and train brake.
   -- If combined is with dynamic brake we'll deal with that per loco below.
   Control["Reverser"] =          FindReverser()
   Control["Gear"] =              FindGear()
   Control["CruiseCtl"] =         FindCruiseCtl()
   Control["CombinedThrottle"] =  FindCombinedThrottle()
   if not Control["CombinedThrottle"] then
      Control["Throttle"] =       FindThrottle()
      Control["TrainBrake"] =     FindTrainBrake()
   end
   Control["LocoBrake"] =         FindLocoBrake()
   Control["DynamicBrake"] =      FindDynamicBrake()
   Control["HandBrake"] =         FindHandBrake()
   Control["SmallEjector"] =      FindSmallEjector()
   Control["Blower"] =            FindBlower()
   Control["FireboxDoor"] =       FindFireboxDoor()
   Control["Stoking"] =           FindStoking()
   Control["ExhaustSteam"] =      FindExhaustSteam()
   Control["ExhaustWater"] =      FindExhaustWater()
   Control["LiveSteam"] =         FindLiveSteam()
   Control["LiveWater"] =         FindLiveWater()

   -- Get ranges for ALL controls, even unused ones, we might need them later.
   Range["Reverser"] =         GetControlRange(FindReverser())
   Range["Gear"] =             GetControlRange(FindGear())
   Range["CruiseCtl"] =        GetControlRange(FindCruiseCtl())
   Range["CombinedThrottle"] = GetControlRange(FindCombinedThrottle())
   Range["Throttle"] =         GetControlRange(FindThrottle())
   Range["TrainBrake"] =       GetControlRange(FindTrainBrake())
   Range["LocoBrake"] =        GetControlRange(FindLocoBrake())
   Range["DynamicBrake"] =     GetControlRange(FindDynamicBrake())
   Range["HandBrake"] =        GetControlRange(FindHandBrake())
   Range["SmallEjector"] =     GetControlRange(FindSmallEjector())
   Range["Blower"] =           GetControlRange(FindBlower())
   Range["FireboxDoor"] =      GetControlRange(FindFireboxDoor())
   Range["Stoking"] =          GetControlRange(FindStoking())
   Range["ExhaustSteam"] =     GetControlRange(FindExhaustSteam())
   Range["ExhaustWater"] =     GetControlRange(FindExhaustWater())
   Range["LiveSteam"] =        GetControlRange(FindLiveSteam())
   Range["LiveWater"] =        GetControlRange(FindLiveWater())

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- In my case (3 throttle axes) I often make use of the Line["DynamicBrake"] in
   -- case where a loco doesn't have DynamicBrake or some other control is
   -- more important. If you have more then 3 throttle axes you could assign
   -- all of them without having to make compromises.

   -- Steamers

   if DetectFEF3_ADV_Smokebox() then
      -- Ignore emergency values (0.85, 1)
      Range["TrainBrake"] = {0, 0.85}
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectFEF3_HUD_Smokebox() then
      -- Ignore emergency values (0.85, 1)
      Range["TrainBrake"] = {0, 0.85}
      -- Use regular controls instead of My* versions, they exist, but don't work in the HUD version
      Control["Reverser"] = "Reverser"
      Control["LocoBrake"] = "EngineBrakeControl"
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif Detect2FDockTank_ADV_MeshTools() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif DetectJ50_ADV_MeshTools() then
      Notches["TrainBrake"] = {0.04, 0.15, 0.25}
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif Detect3FJintyTrain_ADV_MeshTools() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")
      -- Steam brake internal should not be used directly, only push/pull
      Line["LocoBrake"] = nil

   elseif Detect3FJintySteam_ADV_MeshTools() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")
      -- Steam brake internal should not be used directly
      Line["LocoBrake"] = nil

   elseif DetectJ94Train_ADV_MeshTools() then
      -- Notches for the Vacuum or Air brakes (the latter are not keyboard-notched due to a bug)
      Notches["TrainBrake"] = {0.04, 0.15, 0.25}
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectJ94Steam_ADV_MeshTools() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")
      -- There is no TrainBrake here, use the steam brake as one
      Line["LocoBrake"] = Line["TrainBrake"]
      Line["TrainBrake"] = nil
      -- Add notches as it's otherwise very hard to control the steam brake (the only one)
      Notches["LocoBrake"] = {0.30, 0.40, 0.50}

   elseif DetectSmallPrairies_VictoryWorks() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif Detect14xx_VictoryWorks() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif DetectAutocoachA31_VictoryWorks() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif DetectBulleidQ1_VictoryWorks() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif DetectGWRRailmotor_VictoryWorks() or DetectGWRRailmotorBoogie_VictoryWorks() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif Detect56xx_VictoryWorks() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   elseif DetectCastle() then
      -- This loco has VirtualReverser but it doesn't work, override
      Control["Reverser"] = "Reverser"
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectBlack5_KeithRoss() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")
      ReplaceLines("HandBrake", "LocoBrake")

   -- UK

   elseif DetectClass365() then
      -- Ignore emergency values on CombinedThrottle (0, 0.1)
      Range["CombinedThrottle"] = {0.1, 1}
      Notches["CombinedThrottle"] = {0.1, 0.25, 0.38, 0.5, 0.62, 0.74, 0.86, 1}
      GenerateEqualNotch(25, "CruiseCtl") -- (0,1)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectHST() then
      GenerateEqualNotch(6, "Throttle") -- (0,1)
      GenerateEqualNotches(8, "TrainBrake") -- (0,1)

   elseif DetectClass801() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      Range["CombinedThrottle"] = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      Notches["CombinedThrottle"] = {-0.25, 0, 0.25, 0.5, 0.75, 1}

   elseif DetectClass375Class377() then
      Notches["CombinedThrottle"] = {0, 0.1, 0.2, 0.33, 0.5, 0.6, 0.7, 0.81, 1}
      GenerateEqualNotches(21, "CruiseCtl") -- (0,100)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectClass450() then
      -- Set custom notches for the CombinedThrottle, lower half based on sounds, not .bin
      Notches["CombinedThrottle"] = {-1, -0.81, -0.68, -0.56, -0.44, -0.31, -0.18, 0, 0.2, 0.4, 0.6, 0.8, 1}

   elseif DetectClass395() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      Range["CombinedThrottle"] = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      Notches["CombinedThrottle"] = {-0.25, 0, 0.25, 0.5, 0.75, 1}
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      InvInvert("Reverser")
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectClass360() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      Range["CombinedThrottle"] = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      Notches["CombinedThrottle"] = {-0.25, 0, 0.2, 0.4, 0.6, 0.8, 1}
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      InvInvert("Reverser")
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectClass90_ADV_AP() then
      -- Ignore emergency and useless release border values
      Range["TrainBrake"] = {0.125, 0.875}
      GenerateEqualNotches(7, "TrainBrake") -- not defined as equal in .bin but they are
      -- LocoBrake is self lapped
      Notches["LocoBrake"] = {-1, 0, 1}
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      GenerateEqualNotches(23, "CruiseCtl") -- (0,110)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectMK3DVT_ADV_AP() then
      -- Ignore emergency values (0.852, 1)
      Range["TrainBrake"] = {0, 0.852}
      Notches["TrainBrake"] = {0, 0.142, 0.284, 0.426, 0.568, 0.71, 0.852}
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      GenerateEqualNotches(23, "CruiseCtl") -- (0,110)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectClass158() then
      GenerateEqualNotches(8, "Throttle") -- (0,1)
      -- Ignore emergency values (0.75, 1)
      Range["TrainBrake"] = {0, 0.75}
      GenerateEqualNotches(4, "TrainBrake")

   elseif DetectClass101() then
      GenerateEqualNotches(5, "Throttle") -- (0,1)
      GenerateEqualNotches(5, "Gear") -- (0,4)
      -- Havner's config
      ReplaceLines("Gear", "DynamicBrake")

   elseif DetectClass143() then
      GenerateEqualNotches(8, "Throttle") -- (0,1)
      -- Ignore emergency values (0.75, 1)
      Range["TrainBrake"] = {0, 0.75}
      GenerateEqualNotches(4, "TrainBrake") -- not defined as equal in .bin but they are

   elseif DetectClass35() then
      GenerateEqualNotches(10, "Throttle") -- (0,1)
      -- Ignore emergency values (0.9, 1)
      Range["TrainBrake"] = {0, 0.9}
      Notches["TrainBrake"] = {0, 0.1, 0.2, 0.235, 0.27, 0.305, 0.34, 0.375, 0.41, 0.445, 0.48, 0.515, 0.55, 0.585, 0.62, 0.655, 0.69, 0.725, 0.76, 0.795, 0.83, 0.865, 0.9}

   elseif DetectClass03() then
      GenerateEqualNotches(6, "Gear") -- (0,5)
      -- Havner's config
      ReplaceLines("Gear", "DynamicBrake")

   elseif DetectClass47() then
      GenerateEqualNotches(5, "Throttle") -- (0,1)

   elseif DetectClass117() then
      GenerateEqualNotches(5, "Throttle") -- (0,1)
      GenerateEqualNotches(5, "Gear") -- (0,4)
      -- Havner's config
      ReplaceLines("Gear", "DynamicBrake")

   elseif DetectClass170() then
      -- Set custom notches for the CombinedThrottle, it's continuous below center
      Notches["CombinedThrottle"] = {0.5, 0.5713, 0.6427, 0.7142, 0.7857, 0.8571, 0.9285, 1}

   elseif DetectClass321_AP() then
      GenerateEqualNotches(5, "Throttle") -- (0,1)
      GenerateEqualNotches(5, "TrainBrake") -- (0,1)
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectClass156_Oovee() then
      GenerateEqualNotches(8, "Throttle") -- (0,7)
      GenerateEqualNotches(5, "TrainBrake") -- (0,4)
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectClass37_Thomson() then
      Notches["Throttle"] = {0, 0.2, 0.25, 0.27, 0.3, 0.32, 0.35, 0.37, 0.4, 0.42, 0.45, 0.47, 0.5, 0.52, 0.55, 0.57, 0.6, 0.62, 0.65, 0.67, 0.7, 0.72, 0.75, 0.77, 0.8, 0.82, 0.85, 0.87, 0.9, 0.92, 0.95, 1}
      -- Ignore emergency values (0.7857, 1)
      Range["TrainBrake"] = {0, 0.7857}
      Notches["TrainBrake"] = {0, 0.2, 0.4, 0.43, 0.46, 0.49, 0.52, 0.55, 0.58, 0.61, 0.64, 0.67, 0.7, 0.73, 0.7857}
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectClass50_MeshTools() then
      GenerateEqualNotches(8, "Throttle") -- (0,1)
      -- Reverser is 4 state Virtual
      GenerateEqualNotches(4, "Reverser") -- (0,3)
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectClass158_Old() then
      GenerateEqualNotches(8, "Throttle") -- (0,1)

   elseif DetectClass66() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)

   elseif DetectClass166() then
      Notches["CombinedThrottle"] = {0, 0.08, 0.18, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.9, 1}

   -- German locos here, detection might be flaky as they are very similar to eachother

   elseif DetectBR103TEE_vRailroads_Expert() then
      Notches["Reverser"] = {-1, 0, 0.5, 1}
      GenerateEqualNotches(40, "Throttle") -- (0,39)
      -- Additional notch at 0.07, otherwise DynamicBrake desynchronizes
      Notches["TrainBrake"] = {0, 0.07, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      Notches["DynamicBrake"] = {0, 0.07, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}

   elseif DetectBR103TEE_vRailroads() then
      GenerateEqualNotches(40, "Throttle") -- (0,39)
      -- Additional notch at 0.07, otherwise DynamicBrake desynchronizes
      Step["TrainBrake"] = 0.02
      Notches["TrainBrake"] = {0, 0.07, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      Notches["DynamicBrake"] = {0, 0.07, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      -- Self lapped, it's continuous above 0.1
      Notches["LocoBrake"] = {-1, 0.1}

   elseif DetectBR111_vRailroads() or DetectDBbzf_vRailroads() then
      -- Brake levers desynchronize if using correct notches
      --Notches["TrainBrake"] = {0, 0.14, 0.35, 0.42, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(10, "TrainBrake")

   elseif DetectBR420_Influenzo() then
      -- Throttle used as CombinedThrottle
      GenerateEqualNotches(20, "Throttle") -- (-10, 9)
      Notches["TrainBrake"] = {0, 0.14, 0.35, 0.48, 0.6, 0.7, 0.8, 1}
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectBR442Talent2() then
      GenerateEqualNotches(19, "CruiseCtl") -- (0,180)
      -- Ignore emergency values (-1, -0.9)
      Range["CombinedThrottle"] = {-0.9, 1}
      Notches["CombinedThrottle"] = {-0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, -0.2, 0, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1}
      -- TrainBrake is controlled with LocoBrake here, reflect that
      Line["LocoBrake"] = Line["TrainBrake"]
      Line["TrainBrake"] = nil
      -- TrainBrake is self lapped here, add some notches to help
      Notches["LocoBrake"] = {-1, -0.2, 0, 0.2, 1}
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectBR266() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)
      GenerateEqualNotches(21, "CruiseCtl") -- (0,200)
      -- TrainBrake, LocoBrake and CruiseCtl are self lapped here, add some notches to help
      Notches["TrainBrake"] = {-1, 0, 1}
      Notches["LocoBrake"] = {-1, 0, 1}
      Notches["CruiseCtl"] = {-1, 0, 1}
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectBR1460() or DetectBR1462() or DetectDABpbzkfa() then
      Notches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(19, "CruiseCtl") -- (0,1)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectBR426() then
      -- Makes it easier to center, it's not notched
      CenterDetent["CombinedThrottle"] = 0.05
      GenerateEqualNotches(31, "CruiseCtl") -- (0,1)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectICE2() or DetectICE2Cab() or DetectICE3() or DetectICET() then
      Notches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(31, "CruiseCtl") -- (0,1)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectBR189() then
      GenerateEqualNotches(11, "TrainBrake") -- (0,1)
      GenerateEqualNotches(29, "CruiseCtl") -- (0,0.466666)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectBR101() then
      Notches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(26, "CruiseCtl") -- (0,1)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectBR294() then
      -- Makes it easier to center, it's not notched
      CenterDetent["CombinedThrottle"] = 0.05

   elseif DetectBR101_Old() then
      Notches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}

   elseif DetectBR294_Old() then
      CenterDetent["CombinedThrottle"] = 0.05

   elseif DetectV200() then
      GenerateEqualNotches(7, "Throttle") -- (0,1)

   -- US Locos here, detection might be flaky as they are very similar to eachother

   elseif DetectGP20_ADV_Reppo() then
      -- Ignore stop value (-2, 0)
      Range["Throttle"] = {0, 8}
      GenerateEqualNotches(9, "Throttle")
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectSD45_DTM() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectGE44_DTM() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)

   elseif DetectF59PHI() or DetectF59PH() or DetectCabCar() then
      -- Not a simple case as the implementation merges two controls with different notches
      Notches["CombinedThrottle"] = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      Control["TrainBrake"] = FindTrainBrake()
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectM8() then
      Notches["CombinedThrottle"] = {-1, -0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, -0.2, -0.1, 0, 0.1, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1}
      -- DynamicBrake kinda exists here but is useless
      Line["DynamicBrake"] = nil

   elseif DetectAcela() then
      GenerateEqualNotches(7, "Throttle") -- (0,1)
      -- Following the .bin file
      Range["TrainBrake"] = {0, 0.99}
      Notches["TrainBrake"] = {0, 0.2, 0.4, 0.6, 0.8, 0.99}
      GenerateEqualNotches(33, "CruiseCtl") -- (0,160)
      -- Havner's config
      ReplaceLines("CruiseCtl", "DynamicBrake")

   elseif DetectACS64() then
      -- Makes it easier to center, it's not notched
      CenterDetent["CombinedThrottle"] = 0.05
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      Control["TrainBrake"] = FindTrainBrake()
      Notches["TrainBrake"] = {0, 0.1, 0.35, 0.375, 0.4, 0.425, 0.45, 0.475, 0.5, 0.525, 0.55, 0.575, 0.75, 0.85, 1}
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectSD402() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)
      -- Ignore emergency values
      Range["TrainBrake"] = {0, 0.9}

   elseif DetectSD70MAC_ATC() then
      -- Not a simple case as the implementation merges two controls with different notches
      Notches["CombinedThrottle"] = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      Control["TrainBrake"] = FindTrainBrake()
      -- Ignore emergency values
      Range["TrainBrake"] = {0, 0.9}
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectF45() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)
      GenerateEqualNotches(9, "DynamicBrake") -- (0,1)

   elseif DetectC409W() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)
      GenerateEqualNotches(19, "DynamicBrake") -- (0, 1)

   elseif DetectES44DC() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)
      GenerateEqualNotches(10, "DynamicBrake") -- (-0.125, 1)

   elseif DetectSD70M() then
      GenerateEqualNotches(19, "CombinedThrottle") -- (0,1)
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      Control["TrainBrake"] = FindTrainBrake()
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   elseif DetectES44AC() then
      GenerateEqualNotches(9, "Throttle") -- (0,1)

   elseif DetectC449W() then
      GenerateEqualNotches(19, "CombinedThrottle") -- (0,1)
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      Control["TrainBrake"] = FindTrainBrake()
      -- Dynamic brake should not be used directly
      Line["DynamicBrake"] = nil

   -- Generic detections, don't put any specific locos below, they might get caught by those

   elseif DetectGenericSteam() then
      -- Havner's config
      ReplaceLines("Reverser", "DynamicBrake")

   elseif DetectGenericUSDiesel() then
      -- Simple US diesels usually have notched throttle
      GenerateEqualNotches(9, "Throttle") -- (0,1)

   else
      DisplayPopup("No custom configuration for this loco")

   end

   -- Past this point the following global values should be set if they exist and are set to be used
   -- Line[], Control[], Range[]
   -- and optionally:
   -- Invert[], Notches[], CenterDetent[], Step[]

   -----------------------------------------------------------
   ---------------  End of user configuration  ---------------
   -----------------------------------------------------------

   if not SyncOnStart or SyncOnStart == 0 then
      -- Set real values at the start to avoid uncontrolled changing the state after game loads
      local lines = ReadFile("trainsim-helper-joystick.txt")

      for key, l in pairs(Line) do
         PreviousInput[key] = GetLineValue(key, lines)
      end
   end

   -- Set at the very end to be a mark whether the configuration has been successful.
   JoystickConfigured = 1
end

-----------------------------------------------------------
------------  Control values finder functions  ------------
-----------------------------------------------------------

function FindReverser()
   if Call("ControlExists", "MyReverser", 0) == 1 then  -- FEF-3
      return "MyReverser"
   elseif Call("ControlExists", "VirtualReverser", 0) == 1 then
      return "VirtualReverser"
   elseif Call("ControlExists", "Reverser", 0) == 1 then
      return "Reverser"
   end
end

function FindGear()
   if Call("ControlExists", "VirtualGearLever", 0) == 1 then
      return "VirtualGearLever"
   elseif Call("ControlExists", "GearLever", 0) == 1 then
      return "GearLever"
   end
end

function FindCruiseCtl()
   if Call("ControlExists", "SpeedControlTarget", 0) == 1 then     -- BR266
      return "SpeedControlTarget"
   elseif Call("ControlExists", "AFBTargetSpeed", 0) == 1 then     -- BR442 Talent 2
      return "AFBTargetSpeed"
   elseif Call("ControlExists", "SpeedSet", 0) == 1 then           -- Class 90 AP
      return "SpeedSet"
   elseif Call("ControlExists", "CruiseControlSpeed", 0) == 1 then -- Acela
      return "CruiseControlSpeed"
   elseif Call("ControlExists", "AFB", 0) == 1 then                -- German
      return "AFB"
   elseif Call("ControlExists", "SpeedTarget", 0) == 1 then        -- Class 365
      return "SpeedTarget"
   elseif Call("ControlExists", "TargetSpeed", 0) == 1 then        -- Class 375/377
      return "TargetSpeed"
   end
end

function FindCombinedThrottle()
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 then
      return "ThrottleAndBrake"
   end
end

function FindThrottle()
   if Call("ControlExists", "RegulatorLever", 0) == 1 then  -- FEF-3
      return "RegulatorLever"
   elseif Call("ControlExists", "VirtualThrottle", 0) == 1 then
      return "VirtualThrottle"
   elseif Call("ControlExists", "Regulator", 0) == 1 then
      return "Regulator"
   end
end

function FindTrainBrake()
   if Call("ControlExists", "TrainBrakeHandle", 0) == 1 then  -- FEF-3
      return "TrainBrakeHandle"
   elseif Call("ControlExists", "M8Brake", 0) == 1 then
      return "M8Brake"
   elseif Call("ControlExists", "VirtualBrake", 0) == 1 then
      return "VirtualBrake"
   elseif Call("ControlExists", "VirtualTrainBrakeControl", 0) == 1 then
      return "VirtualTrainBrakeControl"
   elseif Call("ControlExists", "TrainBrakeControl", 0) == 1 then
      return "TrainBrakeControl"
   end
end

function FindLocoBrake()
   if Call("ControlExists", "MyEngineBrakeControl", 0) == 1 then  -- FEF-3
      return "MyEngineBrakeControl"
   elseif Call("ControlExists", "VirtualLocoBrake", 0) == 1 then  -- J94
      return "VirtualLocoBrake"
   elseif Call("ControlExists", "VirtualEngineBrakeControl", 0) == 1 then
      return "VirtualEngineBrakeControl"
   elseif Call("ControlExists", "EngineBrakeControl", 0) == 1 then
      return "EngineBrakeControl"
   end
end

function FindDynamicBrake()
   if Call("ControlExists", "VirtualDynamicBrake", 0) == 1 then
      return "VirtualDynamicBrake"
   elseif Call("ControlExists", "DynamicBrake", 0) == 1 then
      return "DynamicBrake"
   end
end

function FindHandBrake()
   if Call("ControlExists", "HandBrake", 0) == 1 then
      return "HandBrake"
   elseif Call("ControlExists", "Handbrake", 0) == 1 then
      return "Handbrake"
   end
end

function FindSmallEjector()
   if Call("ControlExists", "SmallEjectorOnOff", 0) == 1 then
      return "SmallEjectorOnOff"
   elseif Call("ControlExists", "SmallCompressorOnOff", 0) == 1 then
      return "SmallCompressorOnOff"
   end
end

function FindBlower()
   if Call("ControlExists", "BlowerControlValve", 0) == 1 then  -- FEF-3
      return "BlowerControlValve"
   elseif Call("ControlExists", "Blower", 0) == 1 then
      return "Blower"
   end
end

function FindFireboxDoor()
   if Call("ControlExists", "Atomizer", 0) == 1 then  -- FEF-3
      return "Atomizer"
   elseif Call("ControlExists", "FireboxDoor", 0) == 1 then
      return "FireboxDoor"
   end
end

function FindStoking()
   if Call("ControlExists", "Firing", 0) == 1 then  -- FEF-3
      return "Firing"
   elseif Call("ControlExists", "Stoking", 0) == 1 then
      return "Stoking"
   end
end

function FindExhaustSteam()
   if Call("ControlExists", "FiredoorDamper", 0) == 1 then  -- FEF-3
      return "FiredoorDamper"
   elseif Call("ControlExists", "Left Steam", 0) == 1 then  -- 2F, 3F
      return "Left Steam"
   elseif Call("ControlExists", "ExhaustInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      return "ExhaustInjectorSteamLever"
   elseif Call("ControlExists", "ExhaustInjectorSteamOnOff", 0) == 1 then
      return "ExhaustInjectorSteamOnOff"
   end
end

function FindExhaustWater()
   if Call("ControlExists", "FWPump", 0) == 1 then  -- FEF-3
      return "FWPump"
   elseif Call("ControlExists", "Left Water", 0) == 1 then  -- 2F, 3F
      return "Left Water"
   elseif Call("ControlExists", "ExhaustInjectorWaterLever", 0) == 1 then  -- 14xx
      return "ExhaustInjectorWaterLever"
   elseif Call("ControlExists", "ExhaustInjectorWaterFineControl", 0) == 1 then  -- Q1
      return "ExhaustInjectorWaterFineControl"
   elseif Call("ControlExists", "ExhaustInjectorWater", 0) == 1 then
      return "ExhaustInjectorWater"
   end
end

function FindLiveSteam()
   if Call("ControlExists", "InjectorLeverR", 0) == 1 then  -- FEF-3
      return "InjectorLeverR"
   elseif Call("ControlExists", "Right Steam", 0) == 1 then  -- 2F, 3F
      return "Right Steam"
   elseif Call("ControlExists", "LiveInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      return "LiveInjectorSteamLever"
   elseif Call("ControlExists", "LiveInjectorSteamOnOff", 0) == 1 then
      return "LiveInjectorSteamOnOff"
   end
end

function FindLiveWater()
   if Call("ControlExists", "Right Water", 0) == 1 then  -- 2F, 3F
      return "Right Water"
   elseif Call("ControlExists", "LiveInjectorWaterLever", 0) == 1 then  -- 14xx
      return "LiveInjectorWaterLever"
   elseif Call("ControlExists", "LiveInjectorWaterFineControl", 0) == 1 then  -- Q1
      return "LiveInjectorWaterFineControl"
   elseif Call("ControlExists", "LiveInjectorWater", 0) == 1 then
      return "LiveInjectorWater"
   end
end

-----------------------------------------------------------
----------------  Main joystick function  -----------------
-----------------------------------------------------------

function SetJoystickData()
   if SyncOnStart and SyncOnStart ~= 0 and Call("GetSimulationTime", 0) < SyncOnStart then return end

   local lines = ReadFile("trainsim-helper-joystick.txt")
   local value = {}

   for key, l in pairs(Line) do
      value[key] = GetLineValue(key, lines)
   end

   for key, v in pairs(value) do
      SetControl(key, v)
   end

   -- For those configured to be set over time, set them step by step
   for key, s in pairs(Step) do
      SetControlDelayed(key)
   end
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------
-----  Here be dragons, careful with modifications  -------
-----------------------------------------------------------

-- Don't touch those lines
Line = {}
Control = {}
Range = {}
Invert = {}
CenterDetent = {}
Notches = {}
Step = {}
PreviousInput = {}
CurrentSim = {}
TargetSim = {}

-- Raw function, unaware of global variables
function GetControlRange(control)
   if control then
      --if Call("ControlExists", control, 0) == 1 then
         local range = {}
         range[1] = Call("GetControlMinimum", control, 0)
         range[2] = Call("GetControlMaximum", control, 0)
         if range[1] ~= 0 or range[2] ~= 1 then
            return range
         end
      --end
   end
end

function GetControlValue(control)
   --if Call("ControlExists", control, 0) == 1 then
      return Call("GetControlValue", control, 0)
   --end
end

function SetControlValue(control, value)
   if OnControlValueChange then
      OnControlValueChange(control, 0, value)
   else
      --if Call("ControlExists", control, 0) == 1 then
         Call("SetControlValue", control, 0, value)
      --end
   end
end

function ValueChanged(previous, value)
   if not previous or
      math.abs(value - previous) > 0.005 or
      (value == 0 and previous ~= 0) or
      (value == 1 and previous ~= 1)
   then
      return 1
   end
end

function ReadFile(name)
   local lines = {}
   local file = io.open("plugins/"..name, "r")
   if not file then return lines end
   local i = 1  -- for some reason # operator doesn't work here
   for line in file:lines() do
      -- ugly, but couldn't get match to work, too old LUA?
      local cut = line
      local space = string.find(cut, "%s")
      if space then
         cut = string.sub(cut, 1, string.find(cut, "%s") - 1)
      end
      lines[i] = tonumber(cut)
      i=i+1
   end
   file:close()
   return lines
end

-- Specialized functions, aware of global values
function GetLineValue(key, lines)
   local line = Line[key]
   local invert = Invert[key]

   if line and line > 0 then
      local value = lines[line]
      if not value or value < 0.0 or value > 1.0 then
         return -99999
      end
      if invert and invert ~= 0 then
         value = 1.0 - value
      end
      return value
   end
   return -99999
end

function InvInvert(key)
   if Invert[key] and Invert[key] ~= 0 then
      Invert[key] = nil
   else
      Invert[key] = 1
   end
end

-- Replace control lines, but don't do this if:
--   * DisableReplace is set
--   * Line[newKey] is already set
function ReplaceLines(newKey, prevKey)
   if DisableReplace and DisableReplace ~= 0 then return end
   if Line[newKey] and Line[newKey] ~= 0 then return end
   
   Line[newKey] = Line[prevKey]
   Line[prevKey] = nil
end

function GenerateEqualNotches(count, key)
   local range = Range[key]

   if count and count >= 2 then
      local notches = {0}
      for x = 2, count do
         notches[x] = (x-1) / (count-1)
      end
      if range then
         for x = 1, count do
            notches[x] = notches[x] * (range[2] - range[1]) + range[1]
         end
      end
      Notches[key] = notches
   end
end

function SetControl(key, value)
   local control = Control[key]
   local previous = PreviousInput[key]
   local range = Range[key]
   local notches = Notches[key]
   local detent = CenterDetent[key]
   local step = Step[key]

   if control and value >= 0.0 and value <= 1.0 and ValueChanged(previous, value) then
      local saved_value = value

      if not notches and detent and value > (0.5 - detent / 2) and value < (0.5 + detent / 2) then
         value = 0.5
      end
      if range then
         value = value * (range[2] - range[1]) + range[1]
      end
      if notches and table.getn(notches) then
         for x = 1, table.getn(notches)-1 do
            if value >= notches[x] and value < notches[x+1] then
               if value >= (notches[x]+notches[x+1])/2 then
                  value = notches[x+1]
               else
                  value = notches[x]
               end
            end
         end
      end

      -- If Steps are defined we don't want to set the ControlValue immediately
      -- We want to set the TargetSim to achieve over time
      if step then
         if value ~= TargetSim[key] then
            TargetSim[key] = value
            -- Set CurrentSim in case it has been moved by some other means (keys, script)
            CurrentSim[key] = GetControlValue(control)
         end
      else
         SetControlValue(control, value)
      end

      PreviousInput[key] = saved_value
   end
end

function SetControlDelayed(key)
   local step = Step[key]
   local control = Control[key]

   if step and TargetSim[key] and CurrentSim[key] then
      if math.abs(TargetSim[key] - CurrentSim[key]) < step then
         -- Make sure we match the target perfectly and stop the delayed set
         CurrentSim[key] = TargetSim[key]
         TargetSim[key] = nil
      elseif CurrentSim[key] < TargetSim[key] then
         CurrentSim[key] = CurrentSim[key] + step
      else
         CurrentSim[key] = CurrentSim[key] - step
      end
      
      SetControlValue(control, CurrentSim[key])
   end
end
