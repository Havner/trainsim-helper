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
   -- To disable a control or an invert set it to 0 or comment out.

   --Gear = 7
   --ReverserLine = 7
   CombinedThrottleLine = 3
   ThrottleLine = 3
   TrainBrakeLine = 6
   --LocoBrakeLine = 7
   DynamicBrakeLine = 7
   --AFBLine = 7

   GearInvert = 1
   ReverserInvert = 1
   CombinedThrottleInvert = 1
   ThrottleInvert = 1
   --TrainBrakeInvert = 1
   --LocoBrakeInvert = 1
   --DynamicBrakeInvert = 1
   AFBInvert = 1

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues a loco has and detect what to use.
   -- If combined doesn't exist configure separate throttle and train brake.
   GearControl =              FindGear()
   ReverserControl =          FindReverser()
   CombinedThrottleControl =  FindCombinedThrottle()
   if not CombinedThrottleControl then
      ThrottleControl =       FindThrottle()
      TrainBrakeControl =     FindTrainBrake()
   end
   LocoBrakeControl =         FindLocoBrake()
   DynamicBrakeControl =      FindDynamicBrake()
   AFBControl =               FindAFB()

   -- Get ranges for ALL controls, even unused ones, we might need them later
   GearRange =             GetControlRange(FindGear())
   ReverserRange =         GetControlRange(FindReverser())
   CombinedThrottleRange = GetControlRange(FindCombinedThrottle())
   ThrottleRange =         GetControlRange(FindThrottle())
   TrainBrakeRange =       GetControlRange(FindTrainBrake())
   LocoBrakeRange =        GetControlRange(FindLocoBrake())
   DynamicBrakeRange =     GetControlRange(FindDynamicBrake())
   AFBRange =              GetControlRange(FindAFB())

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- In my case (3 throttle axes) I often make use of the DynamicLine in
   -- case where a loco doesn't have DynamicBrake or some other control is
   -- more important. If you have more then 3 throttle axes you could assign
   -- all of them without having to make compromises.

   if DetectClass365() then
      -- Ignore emergency values (0, 0.1)
      CombinedThrottleRange = {0.1, 1}
      -- Set custom notches for the CombinedThrottle
      CombinedThrottleNotches = {0.1, 0.25, 0.38, 0.5, 0.62, 0.74, 0.86, 1}

   elseif DetectHST() then
      ThrottleNotches = GenerateEqualNotches(6) -- (0,1)
      TrainBrakeNotches = GenerateEqualNotches(8) -- (0,1)

   elseif DetectClass375Class377() then
      -- Set custom notches for the CombinedThrottle
      CombinedThrottleNotches = {0, 0.1, 0.2, 0.33, 0.5, 0.6, 0.7, 0.81, 1}

   elseif DetectClass450() then
      -- Set custom notches for the CombinedThrottle, lower half based on sounds, not .bin
      CombinedThrottleNotches = {-1, -0.81, -0.68, -0.56, -0.44, -0.31, -0.18, 0, 0.2, 0.4, 0.6, 0.8, 1}

   elseif DetectClass395() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.25, 0.5, 0.75, 1}
      -- No Dynamic here, add Reverser, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      ReverserInvert = InvertBool(ReverserInvert)
      -- Disable dynamic
      DynamicBrakeControl = nil

   elseif DetectClass360() then
      -- Ignore emergency values on CombinedThrottle (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set custom notches for the CombinedThrottle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.2, 0.4, 0.6, 0.8, 1}
      -- No Dynamic here, add Reverser, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      ReverserInvert = InvertBool(ReverserInvert)
      -- Disable dynamic
      DynamicBrakeControl = nil

   elseif DetectClass90_ADV_AP() then
      -- Ignore emergency and useless release border values
      TrainBrakeRange = {0.125, 0.875}
      TrainBrakeNotches = GenerateEqualNotches(7, TrainBrakeRange) -- not defined as equal in .bin but they are
      -- Add Reverser instead of DynamicBrake, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Disable dynamic
      DynamicBrakeControl = nil

   elseif DetectMK3DVT_ADV_AP() then
      -- Ignore emergency values
      TrainBrakeRange = {0, 0.852}
      TrainBrakeNotches = {0, 0.142, 0.284, 0.426, 0.568, 0.71, 0.852}
      -- Add Reverser instead of DynamicBrake, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Disable dynamic
      DynamicBrakeControl = nil

   elseif DetectClass321_AP() then
      ThrottleNotches = GenerateEqualNotches(5) -- (0,1)
      TrainBrakeNotches = GenerateEqualNotches(5) -- (0,1)
      -- Add Reverser instead of DynamicBrake, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Disable dynamic
      DynamicBrakeControl = nil      

   elseif DetectClass156_Oovee() then
      ThrottleNotches = GenerateEqualNotches(8, ThrottleRange) -- (0,7)
      TrainBrakeNotches = GenerateEqualNotches(5, TrainBrakeRange) -- (0,4)
      -- No Dynamic here, add Reverser, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserNotches = GenerateEqualNotches(4, ReverserRange) -- (0,3)
      -- Disable dynamic
      DynamicBrakeControl = nil

   -- US Locos here, detection might be flaky as they are very similar to eachother

   elseif DetectES44DC() then
      ThrottleNotches = GenerateEqualNotches(9) -- (0,1)
      DynamicBrakeNotches = GenerateEqualNotches(10, DynamicBrakeRange) -- (-0.125, 1)

   elseif DetectGP38_2() then
      ThrottleNotches = GenerateEqualNotches(9) -- (0,1)

   elseif DetectES44AC() then
      ThrottleNotches = GenerateEqualNotches(9) -- (0,1)

   elseif DetectSD70M() then
      CombinedThrottleNotches = GenerateEqualNotches(19) -- (0,1)
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Use a spare axis left from DynamicBrake to control LocoBrake
      LocoBrakeLine = DynamicBrakeLine
      -- And don't use separate dynamic control
      DynamicBrakeControl = nil

   elseif DetectF59PH() or DetectCabCar() then
      -- Not a simple case as the implementation merges two controls with different notches
      CombinedThrottleNotches = {0, 0.0555, 0.1111, 0.1666, 0.2222, 0.2777, 0.3333, 0.3888, 0.4444, 0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 0.9375, 1}
      -- This loco has CombinedThrottle combined with DynamicBrake
      -- Make use of TrainBrake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Use a spare axis left from DynamicBrake to control LocoBrake
      LocoBrakeLine = DynamicBrakeLine
      -- And don't use separate dynamic control
      DynamicBrakeControl = nil

   -- Some very general German locos detection for AFB/Sifa

   elseif DetectGermanAFB() then
      -- Setup AFB instead of Dynamic, the control has already been detected
      AFBLine = DynamicBrakeLine
      -- Disable dynamic control
      DynamicBrakeControl = nil

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
   PreviousGear =             GetLineValue(lines, GearLine, GearInvert)
   PreviousReverser =         GetLineValue(lines, ReverserLine, ReverserInvert)
   PreviousCombinedThrottle = GetLineValue(lines, CombinedThrottleLine, CombinedThrottleInvert)
   PreviousThrottle =         GetLineValue(lines, ThrottleLine, ThrottleInvert)
   PreviousTrainBrake =       GetLineValue(lines, TrainBrakeLine, TrainBrakeInvert)
   PreviousLocoBrake =        GetLineValue(lines, LocoBrakeLine, LocoBrakeInvert)
   PreviousDynamicBrake =     GetLineValue(lines, DynamicBrakeLine, DynamicBrakeInvert)
   PreviousAFB =              GetLineValue(lines, AFBLine, AFBInvert)

   -- set at the very end to be a mark whether the configuration has been successful
   JoystickConfigured = 1
end

-----------------------------------------------------------
------------  Control values finder functions  ------------
-----------------------------------------------------------

function FindGear()
   if Call("*:ControlExists", "GearLever", 0) == 1 then
      return "GearLever"
   end
end

function FindReverser()
   if Call("*:ControlExists", "VirtualReverser", 0) == 1 then
      return "VirtualReverser"
   elseif Call("*:ControlExists", "Reverser", 0) == 1 then
      return "Reverser"
   end
end

function FindCombinedThrottle()
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 then
      return "ThrottleAndBrake"
   end
end

function FindThrottle()
   if Call("*:ControlExists", "VirtualThrottle", 0) == 1 then
      return "VirtualThrottle"
   elseif Call("*:ControlExists", "Regulator", 0) == 1 then
      return "Regulator"
   end
end

function FindTrainBrake()
   if Call("*:ControlExists", "M8Brake", 0) == 1 then
      return "M8Brake"
   elseif Call("*:ControlExists", "VirtualBrake", 0) == 1 then
      return "VirtualBrake"
   elseif Call("*:ControlExists", "VirtualTrainBrakeControl", 0) == 1 then
      return "VirtualTrainBrakeControl"
   elseif Call("*:ControlExists", "TrainBrakeControl", 0) == 1 then
      return "TrainBrakeControl"
   end
end

function FindLocoBrake()
   if Call("*:ControlExists", "VirtualEngineBrakeControl", 0) == 1 then
      return "VirtualEngineBrakeControl"
   elseif Call("*:ControlExists", "EngineBrakeControl", 0) == 1 then
      return "EngineBrakeControl"
   end
end

function FindDynamicBrake()
   if Call("*:ControlExists", "VirtualDynamicBrake", 0) == 1 then
      return "VirtualDynamicBrake"
   elseif Call("*:ControlExists", "DynamicBrake", 0) == 1 then
      return "DynamicBrake"
   end
end

function FindAFB()
   if Call("*:ControlExists", "AFB", 0) == 1 then
      return "AFB"
   end
end

-----------------------------------------------------------
----------------  Main joystick function  -----------------
-----------------------------------------------------------

function SetJoystickData()
   local lines = ReadFile("trainsim-helper-joystick.txt")

   local Gear =             GetLineValue(lines, GearLine, GearInvert)
   local Reverser =         GetLineValue(lines, ReverserLine, ReverserInvert)
   local CombinedThrottle = GetLineValue(lines, CombinedThrottleLine, CombinedThrottleInvert)
   local Throttle =         GetLineValue(lines, ThrottleLine, ThrottleInvert)
   local TrainBrake =       GetLineValue(lines, TrainBrakeLine, TrainBrakeInvert)
   local LocoBrake =        GetLineValue(lines, LocoBrakeLine, LocoBrakeInvert)
   local DynamicBrake =     GetLineValue(lines, DynamicBrakeLine, DynamicBrakeInvert)
   local AFB =              GetLineValue(lines, AFBLine, AFBInvert)

   -- Feed with data
   PreviousGear =             SetControl(GearControl,             PreviousGear,             Gear,             GearRange,             GearNotches)
   PreviousReverser =         SetControl(ReverserControl,         PreviousReverser,         Reverser,         ReverserRange,         ReverserNotches,         ReverserCenterDetent)
   PreviousCombinedThrottle = SetControl(CombinedThrottleControl, PreviousCombinedThrottle, CombinedThrottle, CombinedThrottleRange, CombinedThrottleNotches, CombinedThrottleCenterDetent)
   PreviousThrottle =         SetControl(ThrottleControl,         PreviousThrottle,         Throttle,         ThrottleRange,         ThrottleNotches)
   PreviousTrainBrake =       SetControl(TrainBrakeControl,       PreviousTrainBrake,       TrainBrake,       TrainBrakeRange,       TrainBrakeNotches)
   PreviousLocoBrake =        SetControl(LocoBrakeControl,        PreviousLocoBrake,        LocoBrake,        LocoBrakeRange,        LocoBrakeNotches)
   PreviousDynamicBrake =     SetControl(DynamicBrakeControl,     PreviousDynamicBrake,     DynamicBrake,     DynamicBrakeRange,     DynamicBrakeNotches)
   PreviousAFB =              SetControl(AFBControl,              PreviousAFB,              AFB,              AFBRange,              AFBNotches)
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

function GetControlRange(control)
   if control then
      --if Call("*:ControlExists", control, 0) == 1 then
         local range = {}
	 range[1] = Call("*:GetControlMinimum", control, 0)
	 range[2] = Call("*:GetControlMaximum", control, 0)
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
   --if Call("*:ControlExists", control, 0) == 1 then
      Call("*:SetControlValue", control, 0, value)
   --end
   end
end
