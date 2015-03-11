-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
----------------  Joystick configuration  -----------------
-----------------------------------------------------------

function ConfigureJoystick()
   -- Lines count from 1, not 0 to make easier for non programmers. CombinedThrottleLine and
   -- ThrottleLine can have the same value, they are mutually exclusive and never used together.
   -- Per loco configurations are further down in the function.
   -- Some controls might be used to control other things (based on a loco), but only
   --   if you have not setup those controls explicitly. See "Havner's config" sections.
   -- To disable a control or an invert set it to 0 or comment out.

   --ReverserLine = 7
   --GearLine = 7
   --CruiseControlLine = 7
   CombinedThrottleLine = 3
   ThrottleLine = 3
   TrainBrakeLine = 6
   LocoBrakeLine = 10      -- might also be used for HandBrake if it's not explicitly set
   DynamicBrakeLine = 7    -- might also be used for Reverser, Gear or CruiseControl if they're not explicitly set
   --HandBrakeLine = 10
   SmallEjectorLine = 12
   BlowerLine = 14
   FireboxDoorLine = 18    -- FEF-3: Atomizer
   StokingLine = 19        -- FEF-3: Oil Regulator
   ExhaustSteamLine = 20
   ExhaustWaterLine = 15   -- FEF-3: Feedwater Pump
   LiveSteamLine = 16
   LiveWaterLine = 17

   ReverserInvert = 1
   GearInvert = 1
   CruiseControlInvert = 1
   CombinedThrottleInvert = 1
   ThrottleInvert = 1
   --TrainBrakeInvert = 1
   --LocoBrakeInvert = 1
   --DynamicBrakeInvert = 1
   --HandBrakeInvert = 1
   SmallEjectorInvert = 1
   --BlowerInvert = 1
   FireboxDoorInvert = 1
   StokingInvert = 1
   ExhaustSteamInvert = 1
   ExhaustWaterInvert = 1
   LiveSteamInvert = 1
   LiveWaterInvert = 1

   --ReverserCenterDetent = 0.05
   --CombinedThrottleCenterDetent = 0.05

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues a loco has and detect what to use.
   -- If combined doesn't exist configure separate throttle and train brake.
   -- If combined is with dynamic brake we'll deal with that per loco below.
   ReverserControl =          FindReverser()
   GearControl =              FindGear()
   CruiseControlControl =     FindCruiseControl()
   CombinedThrottleControl =  FindCombinedThrottle()
   if not CombinedThrottleControl then
      ThrottleControl =       FindThrottle()
      TrainBrakeControl =     FindTrainBrake()
   end
   LocoBrakeControl =         FindLocoBrake()
   DynamicBrakeControl =      FindDynamicBrake()
   HandBrakeControl =         FindHandBrake()
   SmallEjectorControl =      FindSmallEjector()
   BlowerControl =            FindBlower()
   FireboxDoorControl =       FindFireboxDoor()
   StokingControl =           FindStoking()
   ExhaustSteamControl =      FindExhaustSteam()
   ExhaustWaterControl =      FindExhaustWater()
   LiveSteamControl =         FindLiveSteam()
   LiveWaterControl =         FindLiveWater()

   -- Get ranges for ALL controls, even unused ones, we might need them later.
   ReverserRange =         GetControlRange(FindReverser())
   GearRange =             GetControlRange(FindGear())
   CruiseControlRange =    GetControlRange(FindCruiseControl())
   CombinedThrottleRange = GetControlRange(FindCombinedThrottle())
   ThrottleRange =         GetControlRange(FindThrottle())
   TrainBrakeRange =       GetControlRange(FindTrainBrake())
   LocoBrakeRange =        GetControlRange(FindLocoBrake())
   DynamicBrakeRange =     GetControlRange(FindDynamicBrake())
   HandBrakeRange =        GetControlRange(FindHandBrake())
   SmallEjectorRange =     GetControlRange(FindSmallEjector())
   BlowerRange =           GetControlRange(FindBlower())
   FireboxDoorRange =      GetControlRange(FindFireboxDoor())
   StokingRange =          GetControlRange(FindStoking())
   ExhaustSteamRange =     GetControlRange(FindExhaustSteam())
   ExhaustWaterRange =     GetControlRange(FindExhaustWater())
   LiveSteamRange =        GetControlRange(FindLiveSteam())
   LiveWaterRange =        GetControlRange(FindLiveWater())

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- In my case (3 throttle axes) I often make use of the DynamicLine in
   -- case where a loco doesn't have DynamicBrake or some other control is
   -- more important. If you have more then 3 throttle axes you could assign
   -- all of them without having to make compromises.

   -- Steamers

   if DetectFEF3_ADV_Smokebox() then
      -- Ignore emergency values (0.85, 1)
      TrainBrakeRange = {0, 0.85}
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectFEF3_HUD_Smokebox() then
      -- Ignore emergency values (0.85, 1)
      TrainBrakeRange = {0, 0.85}
      -- Use regular controls instead of My* versions, they exist, but don't work in the HUD version
      ReverserControl = "Reverser"
      LocoBrakeControl = "EngineBrakeControl"
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif Detect2FDockTank_ADV_MeshTools() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif DetectJ50_ADV_MeshTools() then
      TrainBrakeNotches = {0.04, 0.15, 0.25}
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif Detect3FJinty_ADV_MeshTools() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)
      -- LocoBrake should not be used directly, only push/pull
      LocoBrakeLine = nil

   elseif DetectJ94Train_ADV_MeshTools() then
      TrainBrakeNotches = {0.04, 0.15, 0.25}
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectJ94Steam_ADV_MeshTools() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)
      -- There is no TrainBrake here, use the steam brake as one
      LocoBrakeLine = TrainBrakeLine
      TrainBrakeLine = nil
      -- Add notches as it's otherwise very hard to control the steam brake
      LocoBrakeNotches = {0.30, 0.40, 0.50}

   elseif DetectSmallPrairies_VictoryWorks() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif Detect14xx_VictoryWorks() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif DetectAutocoachA31_VictoryWorks() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif DetectBulleidQ1_VictoryWorks() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif DetectGWRRailmotor_VictoryWorks() or DetectGWRRailmotorBoogie_VictoryWorks() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif Detect56xx_VictoryWorks() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   elseif DetectCastle() then
      -- This loco has VirtualReverser but it doesn't work, override
      ReverserControl = "Reverser"
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectBlack5_KeithRoss() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)
      HandBrakeLine, LocoBrakeLine = ReplaceLines(HandBrakeLine, LocoBrakeLine)

   -- UK

   elseif DetectClass365() then
      -- Ignore emergency values on CombinedThrottle (0, 0.1)
      CombinedThrottleRange = {0.1, 1}
      CombinedThrottleNotches = {0.1, 0.25, 0.38, 0.5, 0.62, 0.74, 0.86, 1}
      CruiseControlNotches = GenerateEqualNotches(25, CruiseControlRange) -- (0,1)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectHST() then
      ThrottleNotches = GenerateEqualNotches(6, ThrottleRange) -- (0,1)
      TrainBrakeNotches = GenerateEqualNotches(8, TrainBrakeRange) -- (0,1)

   elseif DetectClass801() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.25, 0.5, 0.75, 1}

   elseif DetectClass375Class377() then
      CombinedThrottleNotches = {0, 0.1, 0.2, 0.33, 0.5, 0.6, 0.7, 0.81, 1}
      CruiseControlNotches = GenerateEqualNotches(21, CruiseControlRange) -- (0,100)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectClass450() then
      -- Set custom notches for the CombinedThrottle, lower half based on sounds, not .bin
      CombinedThrottleNotches = {-1, -0.81, -0.68, -0.56, -0.44, -0.31, -0.18, 0, 0.2, 0.4, 0.6, 0.8, 1}

   elseif DetectClass395() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.25, 0.5, 0.75, 1}
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      ReverserInvert = InvertBool(ReverserInvert)
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectClass360() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.2, 0.4, 0.6, 0.8, 1}
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      ReverserInvert = InvertBool(ReverserInvert)
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectClass90_ADV_AP() then
      -- Ignore emergency and useless release border values
      TrainBrakeRange = {0.125, 0.875}
      TrainBrakeNotches = GenerateEqualNotches(7, TrainBrakeRange) -- not defined as equal in .bin but they are
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      CruiseControlNotches = GenerateEqualNotches(23, CruiseControlRange) -- (0,110)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectMK3DVT_ADV_AP() then
      -- Ignore emergency values (0.852, 1)
      TrainBrakeRange = {0, 0.852}
      TrainBrakeNotches = {0, 0.142, 0.284, 0.426, 0.568, 0.71, 0.852}
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      CruiseControlNotches = GenerateEqualNotches(23, CruiseControlRange) -- (0,110)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectClass158() then
      ThrottleNotches = GenerateEqualNotches(8, ThrottleRange) -- (0,1)
      -- Ignore emergency values (0.75, 1)
      TrainBrakeRange = {0, 0.75}
      TrainBrakeNotches = GenerateEqualNotches(4, TrainBrakeRange)

   elseif DetectClass101() then
      ThrottleNotches = GenerateEqualNotches(5, ThrottleRange) -- (0,1)
      GearNotches = GenerateEqualNotches(5, GearRange) -- (0,4)
      -- Havner's config
      GearLine, DynamicBrakeLine = ReplaceLines(GearLine, DynamicBrakeLine)

   elseif DetectClass143() then
      ThrottleNotches = GenerateEqualNotches(8, ThrottleRange) -- (0,1)
      -- Ignore emergency values (0.75, 1)
      TrainBrakeRange = {0, 0.75}
      TrainBrakeNotches = GenerateEqualNotches(4, TrainBrakeRange) -- not defined as equal in .bin but they are

   elseif DetectClass35() then
      ThrottleNotches = GenerateEqualNotches(10, ThrottleRange) -- (0,1)
      -- Ignore emergency values (0.9, 1)
      TrainBrakeRange = {0, 0.9}
      TrainBrakeNotches = {0, 0.1, 0.2, 0.235, 0.27, 0.305, 0.34, 0.375, 0.41, 0.445, 0.48, 0.515, 0.55, 0.585, 0.62, 0.655, 0.69, 0.725, 0.76, 0.795, 0.83, 0.865, 0.9}

   elseif DetectClass33() then
      -- Nothing to configure here

   elseif DetectClass03() then
      GearNotches = GenerateEqualNotches(6, GearRange) -- (0,5)
      -- Havner's config
      GearLine, DynamicBrakeLine = ReplaceLines(GearLine, DynamicBrakeLine)

   elseif DetectClass47() then
      ThrottleNotches = GenerateEqualNotches(5, ThrottleRange) -- (0,1)

   elseif DetectClass117() then
      ThrottleNotches = GenerateEqualNotches(5, ThrottleRange) -- (0,1)
      GearNotches = GenerateEqualNotches(5, GearRange) -- (0,4)
      -- Havner's config
      GearLine, DynamicBrakeLine = ReplaceLines(GearLine, DynamicBrakeLine)

   elseif DetectClass170() then
      -- Set custom notches for the CombinedThrottle, it's continuous below center
      CombinedThrottleNotches = {0.5, 0.5713, 0.6427, 0.7142, 0.7857, 0.8571, 0.9285, 1}

   elseif DetectClass321_AP() then
      ThrottleNotches = GenerateEqualNotches(5, ThrottleRange) -- (0,1)
      TrainBrakeNotches = GenerateEqualNotches(5, TrainBrakeRange) -- (0,1)
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectClass156_Oovee() then
      ThrottleNotches = GenerateEqualNotches(8, ThrottleRange) -- (0,7)
      TrainBrakeNotches = GenerateEqualNotches(5, TrainBrakeRange) -- (0,4)
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectClass37_Thomson() then
      ThrottleNotches = {0, 0.2, 0.25, 0.27, 0.3, 0.32, 0.35, 0.37, 0.4, 0.42, 0.45, 0.47, 0.5, 0.52, 0.55, 0.57, 0.6, 0.62, 0.65, 0.67, 0.7, 0.72, 0.75, 0.77, 0.8, 0.82, 0.85, 0.87, 0.9, 0.92, 0.95, 1}
      -- Ignore emergency values (0.7857, 1)
      TrainBrakeRange = {0, 0.7857}
      TrainBrakeNotches = {0, 0.2, 0.4, 0.43, 0.46, 0.49, 0.52, 0.55, 0.58, 0.61, 0.64, 0.67, 0.7, 0.73, 0.7857}
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectClass50_MeshTools() then
      ThrottleNotches = GenerateEqualNotches(8, ThrottleRange) -- (0,1)
      -- Reverser is 4 state Virtual
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   -- German locos here, detection might be flaky as they are very similar to eachother

   elseif DetectBR103TEE_vRailroads() then
      ThrottleNotches = GenerateEqualNotches(40, ThrottleRange) -- (0,39)
      -- Additional notch at 0.07, otherwise DynamicBrake desynchronizes
      TrainBrakeNotches = {0, 0.07, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      DynamicBrakeNotches = {0, 0.07, 0.14, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      -- Self lapped, it's continuous above 0.1
      LocoBrakeNotches = {-1, 0.1}

   elseif DetectBR111_vRailroads() or DetectDBbzf_vRailroads() then
      -- Brake levers desynchronize if using correct notches
      --TrainBrakeNotches = {0, 0.14, 0.35, 0.42, 0.48, 0.61, 0.74, 0.87, 1}
      TrainBrakeNotches = GenerateEqualNotches(10, TrainBrakeRange)

   elseif DetectBR420_Influenzo() then
      -- Throttle used as CombinedThrottle
      ThrottleNotches = GenerateEqualNotches(20, ThrottleRange) -- (-10, 9)
      TrainBrakeNotches = {0, 0.14, 0.35, 0.48, 0.6, 0.7, 0.8, 1}
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectBR442Talent2() then
      CruiseControlNotches = GenerateEqualNotches(19, CruiseControlRange) -- (0,180)
      -- Ignore emergency values (-1, -0.9)
      CombinedThrottleRange = {-0.9, 1}
      CombinedThrottleNotches = {-0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, -0.2, 0, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1}
      -- TrainBrake is controlled with LocoBrake here, reflect that
      LocoBrakeLine = TrainBrakeLine
      TrainBrakeLine = nil
      -- TrainBrake is self lapped here, add some notches to help
      LocoBrakeNotches = {-1, -0.2, 0, 0.2, 1}
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectBR266() then
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)
      CruiseControlNotches = GenerateEqualNotches(21, CruiseControlRange) -- (0,200)
      -- TrainBrake, LocoBrake and CruiseControl are self lapped here, add some notches to help
      TrainBrakeNotches = {-1, 0, 1}
      LocoBrakeNotches = {-1, 0, 0.5, 1}
      CruiseControlNotches = {-1, 0, 1}
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)
      
   elseif DetectBR1460() or DetectBR1462() or DetectDABpbzkfa() then
      TrainBrakeNotches = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      CruiseControlNotches = GenerateEqualNotches(19, CruiseControlRange) -- (0,1)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectBR294() then
      -- Makes it easier to center, it's not notched
      CombinedThrottleCenterDetent = 0.05

   elseif DetectBR101() then
      TrainBrakeNotches = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      CruiseControlNotches = GenerateEqualNotches(26, CruiseControlRange) -- (0,1)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectBR426() then
      -- Makes it easier to center, it's not notched
      CombinedThrottleCenterDetent = 0.05
      CruiseControlNotches = GenerateEqualNotches(31, CruiseControlRange) -- (0,1)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectICE2() or DetectICE2Cab() or DetectICE3() or DetectICET() then
      TrainBrakeNotches = {0, 0.22, 0.35, 0.48, 0.61, 0.74, 0.87, 1}
      CruiseControlNotches = GenerateEqualNotches(31, CruiseControlRange) -- (0,1)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectBR189() then
      TrainBrakeNotches = GenerateEqualNotches(11, TrainBrakeRange) -- (0,1)
      CruiseControlNotches = GenerateEqualNotches(29, CruiseControlRange) -- (0,0.466666)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   -- US Locos here, detection might be flaky as they are very similar to eachother

   elseif DetectGP20_ADV_Reppo() then
      -- Ignore stop value (-2, 0)
      ThrottleRange = {0, 8}
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange)
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectSD45_DTM() then
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectGE44_DTM() then
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)

   elseif DetectF59PHI() or DetectF59PH() or DetectCabCar() then
      -- Not a simple case as the implementation merges two controls with different notches
      CombinedThrottleNotches = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectACS64() then
      -- Makes it easier to center, it's not notched
      CombinedThrottleCenterDetent = 0.05
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      TrainBrakeNotches = {0, 0.1, 0.35, 0.375, 0.4, 0.425, 0.45, 0.475, 0.5, 0.525, 0.55, 0.575, 0.75, 0.85, 1}
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectAcela() then
      ThrottleNotches = GenerateEqualNotches(7, ThrottleRange) -- (0,1)
      -- Following the .bin file
      TrainBrakeRange = {0, 0.99}
      TrainBrakeNotches = {0, 0.2, 0.4, 0.6, 0.8, 0.99}
      CruiseControlNotches = GenerateEqualNotches(33, CruiseControlRange) -- (0,160)
      -- Havner's config
      CruiseControlLine, DynamicBrakeLine = ReplaceLines(CruiseControlLine, DynamicBrakeLine)

   elseif DetectM8() then
      CombinedThrottleNotches = {-1, -0.9, -0.85, -0.8, -0.75, -0.7, -0.65, -0.6, -0.55, -0.5, -0.45, -0.4, -0.35, -0.3, -0.25, -0.2, -0.1, 0, 0.1, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1}
      -- DynamicBrake kinda exists here but is useless
      DynamicBrakeLine = nil

   elseif DetectSD70MAC_ATC() then
      -- Not a simple case as the implementation merges two controls with different notches
      CombinedThrottleNotches = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Ignore emergency values
      TrainBrakeRange = {0, 0.9}
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectSD70M() then
      CombinedThrottleNotches = GenerateEqualNotches(19, CombinedThrottleRange) -- (0,1)
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectC449W() then
      CombinedThrottleNotches = GenerateEqualNotches(19, CombinedThrottleRange) -- (0,1)
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Dynamic brake should not be used directly
      DynamicBrakeLine = nil

   elseif DetectES44DC() then
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)
      DynamicBrakeNotches = GenerateEqualNotches(10, DynamicBrakeRange) -- (-0.125, 1)

   elseif DetectES44AC() then
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)

   elseif DetectF45() then
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)
      DynamicBrakeNotches = GenerateEqualNotches(9, DynamicBrakeRange) -- (0,1)

   -- Generic detections, don't put any specific locos below, they might get caught by those

   elseif DetectGenericSteam() then
      -- Havner's config
      ReverserLine, DynamicBrakeLine = ReplaceLines(ReverserLine, DynamicBrakeLine)

   elseif DetectGenericUS() then
      -- Simple US diesels usually have notched throttle
      ThrottleNotches = GenerateEqualNotches(9, ThrottleRange) -- (0,1)

   else
      DisplayPopup("No custom configuration for this loco")

   end

   -- Past this point the following global values should be set if they exist and are set to be used
   -- *Line, *Control, *Range
   -- and optionally:
   -- *Invert, *Notches, *CenterDetent

   -----------------------------------------------------------
   ---------------  End of user configuration  ---------------
   -----------------------------------------------------------

   -- Set real values at the start to avoid uncontrolled changing the state after game loads
   local lines = ReadFile("trainsim-helper-joystick.txt")
   PreviousReverser =         GetLineValue(lines, ReverserLine, ReverserInvert)
   PreviousGear =             GetLineValue(lines, GearLine, GearInvert)
   PreviousCruiseControl =    GetLineValue(lines, CruiseControlLine, CruiseControlInvert)
   PreviousCombinedThrottle = GetLineValue(lines, CombinedThrottleLine, CombinedThrottleInvert)
   PreviousThrottle =         GetLineValue(lines, ThrottleLine, ThrottleInvert)
   PreviousTrainBrake =       GetLineValue(lines, TrainBrakeLine, TrainBrakeInvert)
   PreviousLocoBrake =        GetLineValue(lines, LocoBrakeLine, LocoBrakeInvert)
   PreviousDynamicBrake =     GetLineValue(lines, DynamicBrakeLine, DynamicBrakeInvert)
   PreviousHandBrake =        GetLineValue(lines, HandBrakeLine, HandBrakeInvert)
   PreviousSmallEjector =     GetLineValue(lines, SmallEjectorLine, SmallEjectorInvert)
   PreviousBlower =           GetLineValue(lines, BlowerLine, BlowerInvert)
   PreviousFireboxDoor =      GetLineValue(lines, FireboxDoorLine, FireboxDoorInvert)
   PreviousStoking =          GetLineValue(lines, StokingLine, StokingInvert)
   PreviousExhaustSteam =     GetLineValue(lines, ExhaustSteamLine, ExhaustSteamInvert)
   PreviousExhaustWater =     GetLineValue(lines, ExhaustWaterLine, ExhaustWaterInvert)
   PreviousLiveSteam =        GetLineValue(lines, LiveSteamLine, LiveSteamInvert)
   PreviousLiveWater =        GetLineValue(lines, LiveWaterLine, LiveWaterInvert)

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

function FindCruiseControl()
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
   if Call("ControlExists", "SmallCompressorOnOff", 0) == 1 then
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
   if Call("ControlExists", "Left Steam", 0) == 1 then  -- 2F, 3F
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
   local lines = ReadFile("trainsim-helper-joystick.txt")

   local Reverser =         GetLineValue(lines, ReverserLine, ReverserInvert)
   local Gear =             GetLineValue(lines, GearLine, GearInvert)
   local CruiseControl =    GetLineValue(lines, CruiseControlLine, CruiseControlInvert)
   local CombinedThrottle = GetLineValue(lines, CombinedThrottleLine, CombinedThrottleInvert)
   local Throttle =         GetLineValue(lines, ThrottleLine, ThrottleInvert)
   local TrainBrake =       GetLineValue(lines, TrainBrakeLine, TrainBrakeInvert)
   local LocoBrake =        GetLineValue(lines, LocoBrakeLine, LocoBrakeInvert)
   local DynamicBrake =     GetLineValue(lines, DynamicBrakeLine, DynamicBrakeInvert)
   local HandBrake =        GetLineValue(lines, HandBrakeLine, HandBrakeInvert)
   local SmallEjector =     GetLineValue(lines, SmallEjectorLine, SmallEjectorInvert)
   local Blower =           GetLineValue(lines, BlowerLine, BlowerInvert)
   local FireboxDoor =      GetLineValue(lines, FireboxDoorLine, FireboxDoorInvert)
   local Stoking =          GetLineValue(lines, StokingLine, StokingInvert)
   local ExhaustSteam =     GetLineValue(lines, ExhaustSteamLine, ExhaustSteamInvert)
   local ExhaustWater =     GetLineValue(lines, ExhaustWaterLine, ExhaustWaterInvert)
   local LiveSteam =        GetLineValue(lines, LiveSteamLine, LiveSteamInvert)
   local LiveWater =        GetLineValue(lines, LiveWaterLine, LiveWaterInvert)

   -- Feed with data
   PreviousReverser =         SetControl(ReverserControl,         PreviousReverser,         Reverser,         ReverserRange,         ReverserNotches,         ReverserCenterDetent)
   PreviousGear =             SetControl(GearControl,             PreviousGear,             Gear,             GearRange,             GearNotches)
   PreviousCruiseControl =    SetControl(CruiseControlControl,    PreviousCruiseControl,    CruiseControl,    CruiseControlRange,    CruiseControlNotches)
   PreviousCombinedThrottle = SetControl(CombinedThrottleControl, PreviousCombinedThrottle, CombinedThrottle, CombinedThrottleRange, CombinedThrottleNotches, CombinedThrottleCenterDetent)
   PreviousThrottle =         SetControl(ThrottleControl,         PreviousThrottle,         Throttle,         ThrottleRange,         ThrottleNotches)
   PreviousTrainBrake =       SetControl(TrainBrakeControl,       PreviousTrainBrake,       TrainBrake,       TrainBrakeRange,       TrainBrakeNotches)
   PreviousLocoBrake =        SetControl(LocoBrakeControl,        PreviousLocoBrake,        LocoBrake,        LocoBrakeRange,        LocoBrakeNotches)
   PreviousDynamicBrake =     SetControl(DynamicBrakeControl,     PreviousDynamicBrake,     DynamicBrake,     DynamicBrakeRange,     DynamicBrakeNotches)
   PreviousHandBrake =        SetControl(HandBrakeControl,        PreviousHandBrake,        HandBrake,        HandBrakeRange,        HandBrakeNotches)
   PreviousSmallEjector =     SetControl(SmallEjectorControl,     PreviousSmallEjector,     SmallEjector,     SmallEjectorRange,     SmallEjectorNotches)
   PreviousBlower =           SetControl(BlowerControl,           PreviousBlower,           Blower,           BlowerRange,           BlowerNotches)
   PreviousFireboxDoor =      SetControl(FireboxDoorControl,      PreviousFireboxDoor,      FireboxDoor,      FireboxDoorRange,      FireboxDoorNotches)
   PreviousStoking =          SetControl(StokingControl,          PreviousStoking,          Stoking,          StokingRange,          StokingNotches)
   PreviousExhaustSteam =     SetControl(ExhaustSteamControl,     PreviousExhaustSteam,     ExhaustSteam,     ExhaustSteamRange,     ExhaustSteamNotches)
   PreviousExhaustWater =     SetControl(ExhaustWaterControl,     PreviousExhaustWater,     ExhaustWater,     ExhaustWaterRange,     ExhaustWaterNotches)
   PreviousLiveSteam =        SetControl(LiveSteamControl,        PreviousLiveSteam,        LiveSteam,        LiveSteamRange,        LiveSteamNotches)
   PreviousLiveWater =        SetControl(LiveWaterControl,        PreviousLiveWater,        LiveWater,        LiveWaterRange,        LiveWaterNotches)
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------
-----  Here be dragons, careful with modifications  -------
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

function GetLineValue(lines, line, invert)
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

function InvertBool(b)
   if b and b ~= 0 then
      return nil
   else
      return 1
   end
end

-- Replace control lines, but only if you have not setup the newLine explicitly.
function ReplaceLines(newLine, prevLine)
   if not newLine or newLine == 0 then
      return prevLine, nil
   else
      return newLine, prevLine
   end
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
end

function GenerateEqualNotches(count, range)
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
      return notches
   end
end

function SetControl(control, previous, value, range, notches, detent)
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

      SetControlValue(control, value)
      return saved_value
   end

   return previous
end

function ValueChanged(previous, value)
   if math.abs(value - previous) > 0.005 or
      (value == 0 and previous ~= 0) or
      (value == 1 and previous ~= 1)
   then
      return 1
   end
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
