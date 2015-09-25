-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
----------------  Joystick configuration  -----------------
-----------------------------------------------------------

function ConfigureJoystick()
   -- Lines count from 1, not 0 to make easier for non programmers. tshLine["CombinedThrottle"] and
   -- tshLine["Throttle"] can have the same value, they are mutually exclusive and never used together.
   -- Per loco configurations are further down in the function.
   -- Some controls might be used to control other things (based on a loco), but only
   --   if you have not setup those controls explicitly. See "Havner's config" sections
   --   and ReplaceLines() calls. This can be disabled with DisableReplace below.
   -- To disable a control or an invert set it to 0 or comment out.

   --tshLine["CruiseCtl"] = 7
   --tshLine["Reverser"] = 7
   --tshLine["Gear"] = 7          -- BR155: Power Selector
   tshLine["CombinedThrottle"] = 3
   tshLine["Throttle"] = 3
   tshLine["TrainBrake"] = 6
   tshLine["LocoBrake"] = 10      -- might also be used for HandBrake if it's not explicitly set
   tshLine["DynamicBrake"] = 7    -- might also be used for Reverser, Gear/Power or CruiseCtl if they're not explicitly set
   --tshLine["HandBrake"] = 10
   tshLine["SmallEjector"] = 11
   tshLine["LargeEjector"] = 12
   tshLine["Blower"] = 14
   tshLine["FireboxDoor"] = 18    -- FEF-3: Atomizer
   tshLine["Stoking"] = 19        -- FEF-3: Oil Regulator
   tshLine["ExhaustSteam"] = 20   -- FEF-3: Damper
   tshLine["ExhaustWater"] = 15   -- FEF-3: Feedwater Pump
   tshLine["LiveSteam"] = 16      -- DR BR86: Pneumatic Blow Down
   tshLine["LiveWater"] = 17      -- DR BR86: Feedwater Pump

   tshInvert["Reverser"] = 1
   tshInvert["Gear"] = 1
   tshInvert["CruiseCtl"] = 1
   tshInvert["CombinedThrottle"] = 1
   tshInvert["Throttle"] = 1
   --tshInvert["TrainBrake"] = 1
   --tshInvert["LocoBrake"] = 1
   --tshInvert["DynamicBrake"] = 1
   --tshInvert["HandBrake"] = 1
   --tshInvert["SmallEjector"] = 1
   tshInvert["LargeEjector"] = 1
   --tshInvert["Blower"] = 1
   tshInvert["FireboxDoor"] = 1
   tshInvert["Stoking"] = 1
   tshInvert["ExhaustSteam"] = 1
   tshInvert["ExhaustWater"] = 1
   tshInvert["LiveSteam"] = 1
   tshInvert["LiveWater"] = 1

   --tshCenterDetent["Reverser"] = 0.05
   --tshCenterDetent["CombinedThrottle"] = 0.05

   -- Sync virtual values with physical ones on start of the sim
   -- after that many seconds. Set to 0 or comment out to disable.
   -- This also disables the throttles before this time's elapsed.
   -- Increase the number if it doesn't work or the loco script is
   -- messing with the values on start. Can be set per loco.
   --SyncOnStart = 0.1

   -- Disable all the ReplaceLines() calls. Meaning you will only get
   -- the axes you configure above, my own configs won't bother you.
   --DisableReplace = 1

   -- Disable artificial notch blockers on SmokeBox brakes
   -- This affects FEF-3, Connie and SmokeBox made brakes for DTG e.g. in:
   -- UP Gas Turbine, SD40-T in Soldier Summit, all Sherman Hill locos.
   -- Comment out if you don't use physical throttles.
   HANDLE_PROTECTION_TIMEOUT_MAX = 0

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues a loco has and detect what to use.
   tshControl["Reverser"] =          FindReverser()
   tshControl["Gear"] =              FindGear()
   tshControl["CruiseCtl"] =         FindCruiseCtl()
   tshControl["CombinedThrottle"] =  FindCombinedThrottle()
   tshControl["Throttle"] =          FindThrottle()
   tshControl["TrainBrake"] =        FindTrainBrake()
   tshControl["LocoBrake"] =         FindLocoBrake()
   tshControl["DynamicBrake"] =      FindDynamicBrake()
   tshControl["HandBrake"] =         FindHandBrake()
   tshControl["SmallEjector"] =      FindSmallEjector()
   tshControl["LargeEjector"] =      FindLargeEjector()
   tshControl["Blower"] =            FindBlower()
   tshControl["FireboxDoor"] =       FindFireboxDoor()
   tshControl["Stoking"] =           FindStoking()
   tshControl["ExhaustSteam"] =      FindExhaustSteam()
   tshControl["ExhaustWater"] =      FindExhaustWater()
   tshControl["LiveSteam"] =         FindLiveSteam()
   tshControl["LiveWater"] =         FindLiveWater()

   -- Get ranges for ALL controls, even unused ones, we might need them later.
   tshRange["Reverser"] =         GetControlRange(tshControl["Reverser"])
   tshRange["Gear"] =             GetControlRange(tshControl["Gear"])
   tshRange["CruiseCtl"] =        GetControlRange(tshControl["CruiseCtl"])
   tshRange["CombinedThrottle"] = GetControlRange(tshControl["CombinedThrottle"])
   tshRange["Throttle"] =         GetControlRange(tshControl["Throttle"])
   tshRange["TrainBrake"] =       GetControlRange(tshControl["TrainBrake"])
   tshRange["LocoBrake"] =        GetControlRange(tshControl["LocoBrake"])
   tshRange["DynamicBrake"] =     GetControlRange(tshControl["DynamicBrake"])
   tshRange["HandBrake"] =        GetControlRange(tshControl["HandBrake"])
   tshRange["SmallEjector"] =     GetControlRange(tshControl["SmallEjector"])
   tshRange["LargeEjector"] =     GetControlRange(tshControl["LargeEjector"])
   tshRange["Blower"] =           GetControlRange(tshControl["Blower"])
   tshRange["FireboxDoor"] =      GetControlRange(tshControl["FireboxDoor"])
   tshRange["Stoking"] =          GetControlRange(tshControl["Stoking"])
   tshRange["ExhaustSteam"] =     GetControlRange(tshControl["ExhaustSteam"])
   tshRange["ExhaustWater"] =     GetControlRange(tshControl["ExhaustWater"])
   tshRange["LiveSteam"] =        GetControlRange(tshControl["LiveSteam"])
   tshRange["LiveWater"] =        GetControlRange(tshControl["LiveWater"])

   -----------------------------------------------------------
   -- Do some common automagic, this way we don't need to do that per loco.
   -- This section tries to autodetect several commonly used things
   -- based on the ControlValues detected above.
   -----------------------------------------------------------

   -- If CombinedThrottle exists, disable separate Throttle and TrainBrake.
   -- If CombinedThrottle is with DynamicBrake we'll deal with that per loco below.
   if tshControl["CombinedThrottle"] then
      tshControl["Throttle"] = nil
      tshControl["TrainBrake"] = nil
   end

   -- Notch the Reverser for non Steamers
   if not DetectGenericSteam(true) and tshControl["Reverser"] then
      if tshRange["Reverser"][1] == -1 and tshRange["Reverser"][2] == 1 then
         GenerateEqualNotches(3, "Reverser")
      elseif tshRange["Reverser"][1] == 0 and tshRange["Reverser"][2] >= 2 then
         GenerateEqualNotches(tshRange["Reverser"][2] + 1, "Reverser")  -- Virtual, might be inverted
      elseif tshRange["Reverser"][1] == -1 and tshRange["Reverser"][2] >= 2 then
         GenerateEqualNotches(tshRange["Reverser"][2] + 2, "Reverser")  -- Virtual, might be inverted
      end
   end

   -- Notch the GearLever
   if tshControl["Gear"] and tshRange["Gear"][1] == 0 and tshRange["Gear"][2] >= 2 then
      GenerateEqualNotches(tshRange["Gear"][2] + 1, "Gear")
   end

   -- Use Gear instead of DynamicBrake if the latter doesn't exist (old Diesels)
   if tshControl["Gear"] and not tshControl["DynamicBrake"] then
      ReplaceLines("Gear", "DynamicBrake")                  -- Havner's config
   end

   -- Use HandBrake instead of LocoBrake if the latter doesn't exist
   if tshControl["HandBrake"] and not tshControl["LocoBrake"] then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
   end

   -- For Steamers use Reverser instead of DynamicBrake
   if DetectGenericSteam(true) then
      ReplaceLines("Reverser", "DynamicBrake")              -- Havner's config
   end

   -----------------------------------------------------------
   -- Override defaults for custom locos. Detect functions are in the main script.
   -- In my case (3 throttle axes) I often make use of the tshLine["DynamicBrake"] in
   -- case where a loco doesn't have DynamicBrake or some other control is
   -- more important. If you have more then 3 throttle axes you could assign
   -- all of them without having to make compromises.
   -----------------------------------------------------------

   -- Steamers

   if DetectFEF3_ADV_Smokebox() then
      tshRange["TrainBrake"] = {0.34, 0.74}                 -- Ignore release and emergency values
      tshNotches["TrainBrake"] = {0.0, 0.34, 0.42, 0.62, 0.74, 1}
      tshStep["TrainBrake"] = 0.03                          -- Not needed per se, cosmetics

   elseif DetectFEF3_HUD_Smokebox() then
      tshRange["TrainBrake"] = {0, 0.85}                    -- Ignore emergency values (0.85, 1)
      tshControl["Reverser"] = "Reverser"                   -- Use regular controls instead of My* versions,
      tshControl["LocoBrake"] = "EngineBrakeControl"        -- they exist, but don't work in the HUD version

   elseif DetectConnie_ADV_Smokebox() then
      tshRange["TrainBrake"] = {0.34, 0.74}                 -- Ignore release and emergency values
      tshNotches["TrainBrake"] = {0.0, 0.34, 0.42, 0.62, 0.74, 1}
      tshStep["TrainBrake"] = 0.03                          -- Not needed per se, cosmetics

   elseif DetectConnie_HUD_Smokebox() then
      -- only overlay

   elseif DetectEE3B_ADV_MeshTools() then
      ReplaceControls("CombinedThrottle", "Throttle")       -- CombinedThrottle is controlled with Throttle here, reflect that
      tshNotches["CombinedThrottle"] = {0, 0.05, 0.09, 0.13, 0.18, 0.22, 0.26, 0.36, 0.5, 0.54, 0.58, 0.62, 0.67, 0.82, 0.87, 0.914, 0.957, 1}
      tshControl["LocoBrake"] = nil                         -- internal brake should not be used directly
      tshControl["HandBrake"] = nil                         -- internal brake should not be used directly
      --SplitCombinedWithAt("DynamicBrake", 0.36)

   elseif DetectAusterity_ADV_MeshTools() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshNotches["Reverser"] = {-0.75, -0.6, -0.45, 0, 0.45, 0.6, 0.75}
      tshStep["Reverser"] = 0.03                            -- Not needed per se, cosmetics
      tshNotches["TrainBrake"] = {0.10, 0.20, 0.30}         -- Add notches as it's otherwise very hard to control the steam brake (the only one)
      tshControl["LocoBrake"] = nil                         -- Steam brake internal should not be used directly
      tshControl["SmallEjector"] = nil                      -- Blueprint garbage
      tshControl["LargeEjector"] = nil                      -- Blueprint garbage

   elseif Detect2FDockTank_ADV_MeshTools() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshControl["LocoBrake"] = nil                         -- Steam brake internal should not be used directly

   elseif DetectJ50_ADV_MeshTools() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshNotches["TrainBrake"] = {0.04, 0.15, 0.25}
      tshControl["LocoBrake"] = nil                         -- Vacuum brake internal should not be used directly

   elseif Detect3FJintyTrain_ADV_MeshTools() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshControl["LocoBrake"] = nil                         -- Steam brake internal should not be used directly, only push/pull

   elseif Detect3FJintySteam_ADV_MeshTools() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshControl["LocoBrake"] = nil                         -- Steam brake internal should not be used directly

   elseif DetectJ94Train_ADV_MeshTools() then
      tshNotches["TrainBrake"] = {0.04, 0.15, 0.25}         -- Notches for the Vacuum or Air brakes (the latter are not keyboard-notched due to a bug)
      tshNotches["LocoBrake"] = {0.30, 0.40, 0.50}          -- Add notches as it's otherwise very hard to control the steam brake (the only one)

   elseif DetectJ94Steam_ADV_MeshTools() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshNotches["LocoBrake"] = {0.30, 0.40, 0.50}          -- Add notches as it's otherwise very hard to control the steam brake (the only one)
      tshControl["TrainBrake"] = nil                        -- Not functional
      tshControl["SmallEjector"] = nil                      -- Not functional
      ReplaceControls("TrainBrake", "LocoBrake")            -- There is no TrainBrake here, use the steam brake as one

   elseif DetectDRBR86() then
      tshControl["SmallEjector"] = nil                      -- Blueprint garbage
      tshControl["LargeEjector"] = nil                      -- Blueprint garbage
      tshRange["TrainBrake"] = {0, 0.676}                   -- Ignore emergency application
      tshNotches["TrainBrake"] = {0, 0.31, 0.448, 0.566, 0.676, 1}
      tshNotches["LocoBrake"] = {0, 0.5, 1}

   elseif Detect5700Pannier() then
      ReplaceLines("HandBrake", "LocoBrake")                -- Havner's config
      tshNotches["Reverser"] = {-0.75, -0.65, -0.55, -0.45, -0.35, -0.25, -0.15, 0, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75}
      tshNotches["TrainBrake"] = {0, 0.5}                   -- (0,1), It's continous above 0.5
      tshControl["LocoBrake"] = nil                         -- Vacuum brake internal should not be used directly
      tshControl["SmallEjector"] = nil                      -- Internal, not used directly

   elseif DetectCastle() then
      tshControl["Reverser"] = "Reverser"                   -- This loco has VirtualReverser but it doesn't work, override

   -- UK

   elseif DetectClass180() then
      tshCenterDetent["CombinedThrottle"] = 0.05            -- Makes it easier to center, it's not notched
      --SplitCombinedWithAt("TrainBrake", 0)

   elseif DetectClass365() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["CombinedThrottle"] = {0, 0.1, 0.25, 0.38, 0.5, 0.62, 0.74, 0.86, 1}
      tshRange["CombinedThrottle"] = {0.1, 1}               -- Ignore emergency values on CombinedThrottle (0, 0.1)
      GenerateEqualNotches(25, "CruiseCtl")                 -- (0,1)
      --SplitCombinedWithAt("TrainBrake", 0.5)

   elseif DetectHST() then
      GenerateEqualNotches(6, "Throttle")                   -- (0,1)
      GenerateEqualNotches(8, "TrainBrake")                 -- (0,1)

   elseif DetectClass801() then
      tshNotches["CombinedThrottle"] = {-1.5, -1, -0.938, -0.875, -0.812, -0.75, -0.688, -0.625, -0.562, -0.5, -0.438, -0.375, -0.312, -0.25, 0, 0.25, 0.5, 0.75, 1}
      tshRange["CombinedThrottle"] = {-1, 1}                -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      --SplitCombinedWithAt("TrainBrake", 0)

   elseif DetectClass375Class377() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["CombinedThrottle"] = {0, 0.1, 0.2, 0.33, 0.5, 0.6, 0.7, 0.81, 1}
      GenerateEqualNotches(21, "CruiseCtl")                 -- (0,100)
      tshControl["DynamicBrake"] = nil                      -- Dynamic brake should not be used directly
      --SplitCombinedWithAt("TrainBrake", 0.5)

   elseif DetectClass450() then
      tshNotches["CombinedThrottle"] = {-1, -0.81, -0.68, -0.56, -0.44, -0.31, -0.18, 0, 0.2, 0.4, 0.6, 0.8, 1}  -- Lower half based on sounds, not .bin

   elseif DetectClass395() then
      tshNotches["CombinedThrottle"] = {-1.5, -1, -0.938, -0.875, -0.812, -0.75, -0.688, -0.625, -0.562, -0.5, -0.438, -0.375, -0.312, -0.25, 0, 0.25, 0.5, 0.75, 1}
      tshRange["CombinedThrottle"] = {-1, 1}                -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      InvInvert("Reverser")                                 -- Invert the invert, as this Virtual is inverted compared to the simple one
      --SplitCombinedWithAt("TrainBrake", 0)

   elseif DetectClass360() then
      tshNotches["CombinedThrottle"] = {-1.5, -1, -0.95, -0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, 0, 0.2, 0.4, 0.6, 0.8, 1}
      tshRange["CombinedThrottle"] = {-1, 1}                -- Ignore emergency values (-1.5, -1)
      InvInvert("Reverser")                                 -- Invert the invert, as this Virtual is inverted compared to the simple one
      --SplitCombinedWithAt("TrainBrake", 0)

   elseif DetectClass90_ADV_AP() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      GenerateEqualNotches(9, "TrainBrake")                 -- (0,1), not defined as equal in .bin but they are
      tshRange["TrainBrake"] = {0.125, 0.875}               -- Ignore emergency (0, 0.125) and release (0.875, 1) values
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- LocoBrake is self lapped, add some notches to help
      GenerateEqualNotches(23, "CruiseCtl")                 -- (0,110)

   elseif DetectMK3DVT_ADV_AP() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.142, 0.284, 0.426, 0.568, 0.71, 0.852, 1}
      tshRange["TrainBrake"] = {0, 0.852}                   -- Ignore emergency values (0.852, 1)
      GenerateEqualNotches(23, "CruiseCtl")                 -- (0,110)

   elseif DetectClass158() then
      GenerateEqualNotches(8, "Throttle")                   -- (0,1)
      GenerateEqualNotches(5, "TrainBrake")                 -- (0,1)
      tshRange["TrainBrake"] = {0, 0.75}                    -- Ignore emergency values (0.75, 1)

   elseif DetectClass08() then
      tshNotches["Throttle"] = {0, 0.3, 0.9, 1}             -- (0,1)

   elseif DetectClass105() then
      GenerateEqualNotches(5, "Throttle")                   -- (0,1)

   elseif DetectClass101() then
      GenerateEqualNotches(5, "Throttle")                   -- (0,1)

   elseif DetectClass143() then
      GenerateEqualNotches(8, "Throttle")                   -- (0,1)
      GenerateEqualNotches(5, "TrainBrake")                 -- (0,1), not defined as equal in .bin but they are
      tshRange["TrainBrake"] = {0, 0.75}                    -- Ignore emergency values (0.75, 1)

   elseif DetectClass35() then
      GenerateEqualNotches(10, "Throttle")                  -- (0,1)
      tshNotches["TrainBrake"] = {0, 0.1, 0.2, 0.235, 0.27, 0.305, 0.34, 0.375, 0.41, 0.445, 0.48, 0.515, 0.55, 0.585, 0.62, 0.655, 0.69, 0.725, 0.76, 0.795, 0.83, 0.865, 0.9, 1}
      tshRange["TrainBrake"] = {0, 0.9}                     -- Ignore emergency values (0.9, 1)

   elseif DetectClass47() then
      GenerateEqualNotches(5, "Throttle")                   -- (0,1)

   elseif DetectClass117() then
      GenerateEqualNotches(5, "Throttle")                   -- (0,1)

   elseif DetectClass170() then
      tshNotches["CombinedThrottle"] = {0.5, 0.5713, 0.6427, 0.7142, 0.7857, 0.8571, 0.9285, 1}  -- It's continuous below 0.5

   elseif DetectClass321_AP() then
      GenerateEqualNotches(5, "Throttle")                   -- (0,1)
      GenerateEqualNotches(5, "TrainBrake")                 -- (0,1)
      GenerateEqualNotches(4, "Reverser")                   -- (0,3), 4 state Virtual

   elseif DetectClass156_Oovee() then
      GenerateEqualNotches(8, "Throttle")                   -- (0,7)
      GenerateEqualNotches(5, "TrainBrake")                 -- (0,4)

   elseif DetectClass37_Thomson() then
      tshNotches["Throttle"] = {0, 0.2, 0.25, 0.27, 0.3, 0.32, 0.35, 0.37, 0.4, 0.42, 0.45, 0.47, 0.5, 0.52, 0.55, 0.57, 0.6, 0.62, 0.65, 0.67, 0.7, 0.72, 0.75, 0.77, 0.8, 0.82, 0.85, 0.87, 0.9, 0.92, 0.95, 1}
      tshNotches["TrainBrake"] = {0, 0.2, 0.4, 0.43, 0.46, 0.49, 0.52, 0.55, 0.58, 0.61, 0.64, 0.67, 0.7, 0.73, 0.7857, 1}
      tshStep["Throttle"] = 0.03                            -- Not needed per se, cosmetics
      tshStep["TrainBrake"] = 0.03                          -- Not needed per se, cosmetics
      GenerateEqualNotches(4, "Reverser")                   -- (-2,1), 4 state Virtual
      -- These settings include the Release (TrainBrake) and Off (Throttle) positions
      --tshRange["TrainBrake"] = {0, 0.7857}                -- Ignore Emergency values (0.7857, 1)
      -- These settings don't, use D and ;/' keys mapped somewhere, they only include the most used positions
      tshRange["Throttle"] = {0.2, 1}                       -- Ignore Off values (0, 0.2)
      tshRange["TrainBrake"] = {0.2, 0.7857}                -- Ignore Release (0, 0.2) and Emergency values (0.7857, 1)

   elseif DetectClass350_Thomson() then
      tshNotches["CombinedThrottle"] = {-1, -0.72, -0.68, -0.64, -0.6, -0.56, -0.52, -0.48, -0.44, -0.40, -0.36, -0.32, -0.28, -0.24, -0.2, -0.16, -0.12, -0.08, -0.04, 0, 0.2, 0.4, 0.6, 0.8, 1}
      --SplitCombinedWithAt("TrainBrake", 0)

   elseif DetectClass66_Thomson() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      tshNotches["TrainBrake"] = {-1, 0, 1}                 -- Self lapped here, add some notches to help
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help

   elseif DetectClass76() then
      GenerateEqualNotches(20, "Throttle")
      GenerateEqualNotches(21, "DynamicBrake")

   elseif DetectClass50_MeshTools() then
      GenerateEqualNotches(8, "Throttle")                   -- (0,1)
      GenerateEqualNotches(4, "Reverser")                   -- (-4,-1), 4 state Virtual

   elseif DetectClass158_Old() then
      GenerateEqualNotches(8, "Throttle")                   -- (0,1)

   elseif DetectClass66() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)

   elseif DetectClass166() then
      tshNotches["CombinedThrottle"] = {0, 0.08, 0.18, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.9, 1}
      
   elseif DetectClass456() then
      GenerateEqualNotches(5, "Throttle")                   -- (0,1)
      GenerateEqualNotches(5, "TrainBrake")
      tshRange["TrainBrake"] = {0, 0.75}                    -- ignore Emergency at 0.1 pos

   -- German locos here, detection might be flaky as they are very similar to eachother

   elseif DetectBR103TEE_vRailroads_Expert() then
      tshNotches["Reverser"] = {-1, 0, 0.5, 1}
      GenerateEqualNotches(40, "Throttle")                  -- (0,39)
      tshNotches["TrainBrake"] = {0, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      tshNotches["DynamicBrake"] = {0, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      tshStep["TrainBrake"] = 0.03                          -- Step for TrainBrake required, otherwise DynamicBrake desynchronizes

   elseif DetectBR103TEE_vRailroads() then
      GenerateEqualNotches(40, "Throttle")                  -- (0,39)
      tshNotches["TrainBrake"] = {0, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      tshNotches["DynamicBrake"] = {0, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      tshNotches["LocoBrake"] = {-1, 0.1}                   -- Self lapped, it's continuous above 0.1
      tshStep["TrainBrake"] = 0.03                          -- Step for TrainBrake required, otherwise DynamicBrake desynchronizes

   elseif DetectBR111_vRailroads() or DetectDBbzf_vRailroads() then
      tshNotches["TrainBrake"] = {0, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      tshStep["TrainBrake"] = 0.03                          -- Step for TrainBrake required, otherwise DynamicBrake desynchronizes

   elseif DetectBR420_Influenzo() then
      ReplaceControls("CombinedThrottle", "Throttle")       -- CombinedThrottle is controlled with Throttle here, reflect that
      GenerateEqualNotches(20, "CombinedThrottle")          -- (-9, 10)
      tshNotches["TrainBrake"] = {0, 0.14, 0.35, 0.48, 0.6, 0.7, 0.8, 1}
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly
      --SplitCombinedWithAt("DynamicBrake", 0)
      --SwitchLines("TrainBrake", "DynamicBrake")           -- IMO better to have Dynamic/Combined Brake on the "main" handle

   elseif DetectBR155() then
      GenerateEqualNotches(17, "Gear")                      -- (-0.5,1.3)
      GenerateEqualNotches(34, "Throttle")                  -- (-3,30)
      tshRange["Throttle"] = {0, 30}                        -- Disable negative TapChanger positions, they make little sense on fast Throttle
      tshNotches["TrainBrake"] = {0, 0.1, 0.22, 0.34, 0.44, 0.54, 0.66, 0.75, 0.85, 0.9, 1}
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help
      GenerateEqualNotches(20, "DynamicBrake")              -- (0,1)

   elseif DetectOBB1116() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      GenerateEqualNotches(49, "CruiseCtl")                 -- (0,240)
      tshNotches["TrainBrake"] = {0, 0.1, 0.175, 0.225, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1}
      tshNotches["DynamicBrake"] = {0, 0.15, 0.225, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1}
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help
      tshStep["TrainBrake"] = 0.03                          -- Step for TrainBrake required, otherwise DynamicBrake desynchronizes

   elseif DetectBR261() then
      tshNotches["CombinedThrottle"] = {-1, -0.66, -0.33, 0, 0.33, 0.66, 1}
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshRange["TrainBrake"] = {-0.9, 0.9}                  -- Ignore Emergency and Full Release brake applications, hard to use with spring loaded
      tshNotches["TrainBrake"] = {-1, -0.9, 0, 0.9, 1}      -- TrainBrake is self lapped here, add some notches to help
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- LocoBrake is self lapped here, add some notches to help
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake not functional by itself
      tshControl["HandBrake"] = nil                         -- HandBrake not functional by lever
      --SplitCombinedWithAt("DynamicBrake", 0)

   elseif DetectBR442Talent2() then
      tshNotches["CombinedThrottle"] = {-1, -0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, -0.2, 0, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1}
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshNotches["TrainBrake"] = {-1, 0, 1}                 -- TrainBrake is self lapped here, add some notches to help
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake not functional by itself
      tshControl["HandBrake"] = nil                         -- HandBrake not functional by lever
      --SplitCombinedWithAt("DynamicBrake", 0)
      --SwitchLines("TrainBrake", "DynamicBrake")           -- IMO better to have Dynamic/Combined Brake on the "main" handle

   elseif DetectBR232() then
      GenerateEqualNotches(16, "Throttle")                  -- (0,15)
      tshNotches["TrainBrake"] = {0, 0.14, 0.35, 0.48, 0.6, 0.7, 0.8, 1}
      tshStep["TrainBrake"] = 0.03                          -- Step for TrainBrake required, otherwise DynamicBrake desynchronizes

   elseif DetectBR266() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      GenerateEqualNotches(21, "CruiseCtl")                 -- (0,200)
      tshNotches["TrainBrake"] = {-1, 0, 1}                 -- Self lapped here, add some notches to help
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help
      tshNotches["CruiseCtl"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help

   elseif DetectBR1460() or DetectBR1462() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      GenerateEqualNotches(19, "CruiseCtl")                 -- (0,1)
      tshNotches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help

   elseif DetectDABpbzkfa() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      GenerateEqualNotches(19, "CruiseCtl")                 -- (0,1)
      tshNotches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}

   elseif DetectBR189_MK() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.1, 0.2, 0.275, 0.35, 0.425, 0.5, 0.575, 0.65, 0.85, 1} -- (0,1)
      GenerateEqualNotches(37, "CruiseCtl")                 -- (0,0.6)
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help

   elseif DetectBR425() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshCenterDetent["CombinedThrottle"] = 0.05            -- Makes it easier to center, it's not notched
      GenerateEqualNotches(19, "CruiseCtl")                 -- (0,1)
      tshControl["DynamicBrake"] = nil                      -- Dynamic brake should not be used directly
      --SplitCombinedWithAt("TrainBrake", 0.5)

   elseif DetectICE3M_MK() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.1, 0.2, 0.275, 0.35, 0.425, 0.5, 0.575, 0.65, 0.85, 1} -- (0,1)
      GenerateEqualNotches(34, "CruiseCtl")                 -- (0,1)
      tshControl["DynamicBrake"] = nil                      -- Dynamic brake should not be used directly

   elseif DetectBR426() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshCenterDetent["CombinedThrottle"] = 0.05            -- Makes it easier to center, it's not notched
      tshRange["CruiseCtl"] = {0, 18/30}                    -- By default it goes to 300 kph, this loco can do 180 kph
      GenerateEqualNotches(19, "CruiseCtl")                 -- (0,1)
      tshControl["DynamicBrake"] = nil                      -- Dynamic brake should not be used directly

   elseif DetectICE2() or DetectICE2Cab() or DetectICE3M() or DetectICET() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(31, "CruiseCtl")                 -- (0,1)
      tshControl["DynamicBrake"] = nil                      -- Dynamic brake should not be used directly

   elseif DetectBR189() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.1, 0.2, 0.25, 0.3, 0.38, 0.46, 0.54, 0.62, 0.7, 0.8, 1} -- (0,1)
      GenerateEqualNotches(29, "CruiseCtl")                 -- (0,1)
      tshNotches["LocoBrake"] = {-1, 0, 1}                  -- Self lapped here, add some notches to help

   elseif DetectBR101_New() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(26, "CruiseCtl")                 -- (0,1)
      tshControl["LocoBrake"] = nil                         -- The way it's been scripted it should be used with keys only

   elseif DetectBR101() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      tshNotches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      GenerateEqualNotches(26, "CruiseCtl")                 -- (0,1)

   elseif DetectBR294() or DetectBR294_New() then
      tshCenterDetent["CombinedThrottle"] = 0.05            -- Makes it easier to center, it's not notched
      --SplitCombinedWithAt("TrainBrake", 0.5)

   elseif DetectBR101_Old() then
      tshNotches["TrainBrake"] = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}

   elseif DetectBR294_Old() then
      tshCenterDetent["CombinedThrottle"] = 0.05            -- Makes it easier to center, it's not notched
      --SplitCombinedWithAt("TrainBrake", 0.5)

   elseif DetectV200() then
      GenerateEqualNotches(7, "Throttle")                   -- (0,1)

   -- US Locos here, detection might be flaky as they are very similar to eachother

   elseif DetectUPGasTurbine() then
      GenerateEqualNotches(21, "Throttle")                  -- (0,1)
      GenerateEqualNotches(21, "DynamicBrake")              -- (0,1)
      tshSetControlTargetValue["Reverser"] = true           -- A fix for the Reverser

   elseif DetectGP20_ADV_Reppo() then
      tshNotches["Throttle"] = {-2, 0, 1, 2, 3, 4, 5, 6, 7, 8}
      tshRange["Throttle"] = {0, 8}                         -- Ignore stop values (-2, 0)
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly

   elseif DetectSD45_DTM() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly

   elseif DetectGE44_DTM() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)

   elseif DetectF40PH() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      GenerateEqualNotches(9, "DynamicBrake")               -- (0,1)

   elseif DetectF59PHI() or DetectF59PH() or DetectCabCar() then
      tshNotches["CombinedThrottle"] = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}  -- Not a simple case as the implementation merges two controls with different notches
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly
      --SplitCombinedWithAt("DynamicBrake", 0.5)

   elseif DetectM8() then
      tshNotches["CombinedThrottle"] = {-1, -0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, -0.2, -0.1, 0, 0.1, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1}
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake kinda exists here but is useless

   elseif DetectAcela() then
      ReplaceLines("CruiseCtl", "DynamicBrake")             -- Havner's config
      GenerateEqualNotches(7, "Throttle")                   -- (0,1)
      tshNotches["TrainBrake"] = {0, 0.2, 0.4, 0.6, 0.8, 0.99}
      tshRange["TrainBrake"] = {0, 0.99}                    -- Following the .bin file
      GenerateEqualNotches(33, "CruiseCtl")                 -- (0,160)

   elseif DetectACS64() then
      tshCenterDetent["CombinedThrottle"] = 0.05            -- Makes it easier to center, it's not notched
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshNotches["TrainBrake"] = {0, 0.1, 0.35, 0.375, 0.4, 0.425, 0.45, 0.475, 0.5, 0.525, 0.55, 0.575, 0.75, 0.85, 1}
      tshControl["DynamicBrake"] = nil                      -- Dynamic brake should not be used directly

   elseif DetectSD402() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      tshRange["TrainBrake"] = {0, 0.9}                     -- Ignore emergency values (0.9, 1)

   elseif DetectSD70MAC_ATC() then
      tshNotches["CombinedThrottle"] = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}  -- Not a simple case as the implementation merges two controls with different notches
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshRange["TrainBrake"] = {0, 0.9}                     -- Ignore emergency values (0.9, 1)
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly

   elseif DetectF45() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      GenerateEqualNotches(9, "DynamicBrake")               -- (0,1)

   elseif DetectC409W() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      GenerateEqualNotches(19, "DynamicBrake")              -- (0, 1)

   elseif DetectES44DC() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)
      GenerateEqualNotches(10, "DynamicBrake")              -- (-0.125, 1)

   elseif DetectSD60M() then
      tshNotches["CombinedThrottle"] = {0.5, 0.571, 0.642, 0.714, 0.785, 0.857, 0.928, 1}  -- (0, 1), It's continous below 0.5 (DynamicBrake), notches from cab sounds
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly
      --SplitCombinedWithAt("DynamicBrake", 0.5)
      
   elseif DetectSD70M() then
      tshNotches["CombinedThrottle"] = {0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1} -- (-1, 1), It's continous below 0 (DynamicBrake)
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly
      --SplitCombinedWithAt("DynamicBrake", 0)

   elseif DetectES44AC() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1)

   elseif DetectC449W() then
      GenerateEqualNotches(19, "CombinedThrottle")          -- (0,1)
      tshControl["TrainBrake"] = FindTrainBrake()           -- CombinedThrottle is with DynamicBrake, use also TrainBrake lever
      tshControl["DynamicBrake"] = nil                      -- DynamicBrake should not be used directly

   -- Generic detections, don't put any specific locos below, they might get caught by those

   elseif DetectGenericSteam() then
      -- Just note it's been detected

   elseif DetectGenericUSDiesel() then
      GenerateEqualNotches(9, "Throttle")                   -- (0,1), simple US diesels usually have notched throttle

   else
      DisplayPopup("No custom configuration for this loco")

   end

   -- Past this point the following global values should be set if they exist and are set to be used
   -- tshLine[], tshControl[], tshRange[]
   -- and optionally:
   -- tshInvert[], tshNotches[], tshCenterDetent[], tshStep[]

   -----------------------------------------------------------
   ---------------  End of user configuration  ---------------
   -----------------------------------------------------------

   if not SyncOnStart or SyncOnStart == 0 then
      -- Set real values at the start to avoid uncontrolled changing the state after game loads
      local lines = ReadFile("trainsim-helper-joystick.txt")

      for key, l in pairs(tshLine) do
         tshPreviousInput[key] = GetLineValue(key, lines)
      end
   end

   -- Set at the very end to be a mark whether the configuration has been successful.
   JoystickConfigured = 1
end

-----------------------------------------------------------
----------------  Main joystick function  -----------------
-----------------------------------------------------------

function SetJoystickData()
   if SyncOnStart and SyncOnStart ~= 0 and Call("GetSimulationTime", 0) < SyncOnStart then return end

   local lines = ReadFile("trainsim-helper-joystick.txt")
   local value = {}

   for key, l in pairs(tshLine) do
      value[key] = GetLineValue(key, lines)
   end

   for key, v in pairs(value) do
      TrySetControl(key, v)
   end

   -- For those configured to be set over time, set them step by step
   for key, s in pairs(tshStep) do
      SetControlDelayed(key)
   end
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------
-----  Here be dragons, careful with modifications  -------
-----------------------------------------------------------

-----------------------------------------------------------
----------------  Configuration helpers  ------------------
-----------------------------------------------------------

function InvInvert(key)
   if tshInvert[key] and tshInvert[key] ~= 0 then
      tshInvert[key] = nil
   else
      tshInvert[key] = 1
   end
end

function GenerateEqualNotches(count, key)
   local range = tshRange[key]

   if count and count >= 2 then
      local notches = {0}
      for x = 2, count do
         notches[x] = (x-1) / (count-1)
      end
      if range[1] then
         for x = 1, count do
            notches[x] = notches[x] * (range[2] - range[1]) + range[1]
         end
      end
      tshNotches[key] = notches
   end
end

function SplitCombinedWithAt(brake, split)
   local range = tshRange["CombinedThrottle"]
   if not range[1] then range = {0,1} end
   -- Throttle
   tshRange["CombinedThrottle"] = {split, range[2]}
   -- SomeBrake
   tshControl[brake] = tshControl["CombinedThrottle"]
   tshRange[brake] = {range[1], split}
   tshNotches[brake] = tshNotches["CombinedThrottle"]
   InvInvert(brake)
end

function SwitchLines(key_1, key_2)
   if DisableReplace and DisableReplace ~= 0 then return end

   local tmp = tshLine[key_1]
   tshLine[key_1] = tshLine[key_2]
   tshLine[key_2] = tmp
end

-- Replace control lines, but don't do this if:
--   * DisableReplace is set
--   * tshLine[newKey] is already set
function ReplaceLines(newKey, prevKey)
   if DisableReplace and DisableReplace ~= 0 then return end
   if tshLine[newKey] and tshLine[newKey] ~= 0 then return end

   tshLine[newKey] = tshLine[prevKey]
   tshLine[prevKey] = nil
end

function ReplaceControls(newKey, prevKey)
   tshControl[newKey]       = tshControl[prevKey]
   tshRange[newKey]         = tshRange[prevKey]
   tshInvert[newKey]        = tshInvert[prevKey]
   tshCenterDetent[newKey]  = tshCenterDetent[prevKey]
   tshNotches[newKey]       = tshNotches[prevKey]
   tshStep[newKey]          = tshStep[prevKey]

   tshControl[prevKey]      = nil
   tshRange[prevKey]        = {}
   tshInvert[prevKey]       = nil
   tshCenterDetent[prevKey] = nil
   tshNotches[prevKey]      = nil
   tshStep[prevKey]         = nil
end

-----------------------------------------------------------
-------  Raw functions, unaware of global variables  ------
-----------------------------------------------------------

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
   return {}
end

function tshSetControlValue(control, value, setTarget)
   if OnControlValueChange then
      OnControlValueChange(control, 0, value)
   else
      --if Call("ControlExists", control, 0) == 1 then
         Call("SetControlValue", control, 0, value)
      --end
   end
   if setTarget then
      Call("SetControlTargetValue", control, 0, value)
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

-----------------------------------------------------------
-----  Specialized functions, aware of global values  -----
-----------------------------------------------------------

function GetLineValue(key, lines)
   local line = tshLine[key]
   local invert = tshInvert[key]

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

function TrySetControl(key, value)
   local control = tshControl[key]
   local previous = tshPreviousInput[key]
   local range = tshRange[key]
   local notches = tshNotches[key]
   local detent = tshCenterDetent[key]
   local step = tshStep[key]
   local setTarget = tshSetControlTargetValue[key]

   if control and value >= 0.0 and value <= 1.0 and ValueChanged(previous, value) then
      local saved_value = value

      if not notches and detent and value > (0.5 - detent / 2) and value < (0.5 + detent / 2) then
         value = 0.5
      end
      if range[1] then
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
         if value ~= tshTargetSim[key] then
            tshTargetSim[key] = value
            -- Set CurrentSim in case it has been moved by some other means (keys, script)
            tshCurrentSim[key] = Call("GetControlValue", control, 0)
         end
      else
         tshSetControlValue(control, value, setTarget)
      end

      tshPreviousInput[key] = saved_value
   end
end

function SetControlDelayed(key)
   local step = tshStep[key]
   local control = tshControl[key]
   local setTarget = tshSetControlTargetValue[key]

   if step and tshTargetSim[key] and tshCurrentSim[key] then
      if math.abs(tshTargetSim[key] - tshCurrentSim[key]) < step then
         -- Make sure we match the target perfectly and stop the delayed set
         tshCurrentSim[key] = tshTargetSim[key]
         tshTargetSim[key] = nil
      elseif tshCurrentSim[key] < tshTargetSim[key] then
         tshCurrentSim[key] = tshCurrentSim[key] + step
      else
         tshCurrentSim[key] = tshCurrentSim[key] - step
      end

      tshSetControlValue(control, tshCurrentSim[key], setTarget)
   end
end
