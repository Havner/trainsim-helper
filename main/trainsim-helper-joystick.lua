-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
----------------  Joystick configuration  -----------------
-----------------------------------------------------------

function ConfigureJoystick()
   -- Lines count from 1, not 0 to make easier for non programmers. CombinedThrottleLine and
   -- ThrottleLine can have the same value, they are mutually exclusive and never used together.
   -- Per loco axes are further down in the function.

   -- To disable a control set it to 0 or comment out
   --ReverserLine = 7
   CombinedThrottleLine = 3
   ThrottleLine = 3
   TrainBrakeLine = 6
   --LocoBrakeLine = 7
   DynamicBrakeLine = 7
   --AFBLine = 7

   -- To disable an invert set it to 0 or comment out
   ReverserInvert = 1
   CombinedThrottleInvert = 1
   ThrottleInvert = 1
   --TrainBrakeInvert = 1
   --LocoBrakeInvert = 1
   --DynamicBrakeInvert = 1
   AFBInvert = 1

   -----------------------------------------------------------
   --- No need to go below for a very basic configuration  ---
   -----------------------------------------------------------

   -- Find ControlValues this loco has and detect what to use.
   -- If combined doesn't exist configure separate throttle and train brake.
   ReverserControl =          FindReverser()
   CombinedThrottleControl =  FindCombinedThrottle()
   if not CombinedThrottleControl then
      ThrottleControl =       FindThrottle()
      TrainBrakeControl =     FindTrainBrake()
   end
   LocoBrakeControl =         FindLocoBrake()
   DynamicBrakeControl =      FindDynamicBrake()
   AFBControl =               FindAFB()

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- In my case (3 throttle axes) I often make use of the DynamicLine in
   -- case where a loco doesn't have DynamicBrakes or some other control is
   -- more important. If you have more then 3 throttle axes you could assign
   -- all of them without having to make compromises.

   if DetectClass365() then
      -- Ignore emergency values (0, 0.1)
      CombinedThrottleRange = {0.1, 1}
      -- Create notches for the CombinedThrottle
      CombinedThrottleNotches = {0.1, 0.25, 0.38, 0.5, 0.62, 0.74, 0.86, 1}

   elseif DetectHST() then
      ThrottleNotches = GenerateEqualNotches(6)
      TrainBrakeNotches = GenerateEqualNotches(8)

   elseif DetectClass377() then
      -- Create notches for the CombinedThrottle
      CombinedThrottleNotches = {0, 0.1, 0.2, 0.33, 0.5, 0.6, 0.7, 0.81, 1}

   elseif DetectClass450() then
      -- Create notches for the CombinedThrottle, lower half based on sounds, not .bin
      CombinedThrottleNotches = {-1, -0.81, -0.68, -0.56, -0.44, -0.31, -0.18, 0, 0.2, 0.4, 0.6, 0.8, 1}

   elseif DetectClass395() then
      -- Ignore emergency values (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set notches for the throttle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.25, 0.5, 0.75, 1}
      -- No dynamic here, add reverser, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserRange = GetControlRange(ReverserControl)
      ReverserNotches = GenerateEqualNotches(4, ReverserRange)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      ReverserInvert = InvertBool(ReverserInvert)
      -- Disable dynamic
      DynamicBrakeControl = nil
      DynamicBrakeLine = nil

   elseif DetectClass360() then
      -- Ignore emergency values (-1.5, -1)
      CombinedThrottleRange = {-1, 1}
      -- Set notches for the throttle, it's continuous below min brake
      CombinedThrottleNotches = {-0.25, 0, 0.2, 0.4, 0.6, 0.8, 1}
      -- No dynamic here, add reverser, for this loco it's 4 state Virtual
      ReverserLine = DynamicBrakeLine
      ReverserRange = GetControlRange(ReverserControl)
      ReverserNotches = GenerateEqualNotches(4, ReverserRange)
      -- Invert the invert, as this Virtual is inverted compared to the simple one
      ReverserInvert = InvertBool(ReverserInvert)
      -- Disable dynamic
      DynamicBrakeControl = nil
      DynamicBrakeLine = nil

   elseif DetectClass156_Oovee() then
      ThrottleRange = GetControlRange(ThrottleControl)
      ThrottleNotches = GenerateEqualNotches(8, ThrottleRange)
      TrainBrakeRange = GetControlRange(TrainBrakeControl)
      TrainBrakeNotches = GenerateEqualNotches(5, TrainBrakeRange)
      ReverserRange = GetControlRange(ReverserControl)
      ReverserNotches = GenerateEqualNotches(4, ReverserRange)

   -- US Locos here, detection might be flaky as they are very similar to eachother

   elseif DetectES44DC() then
      -- Notches for the regulator, it's (0, 1)
      ThrottleNotches = GenerateEqualNotches(9)
      -- Notches for the dynamic, it's not (0, 1) so automate
      DynamicBrakeRange = GetControlRange(DynamicBrakeControl)
      DynamicBrakeNotches = GenerateEqualNotches(10, DynamicBrakeRange)

   elseif DetectGP38_2() then
      ThrottleNotches = GenerateEqualNotches(9)

   elseif DetectES44AC() then
      ThrottleNotches = GenerateEqualNotches(9)

   elseif DetectSD70M() then
      -- Notches for the combined, it's (0, 1)
      CombinedThrottleNotches = GenerateEqualNotches(19)
      -- This loco has CombinedThrottle combined with dynamic brake
      -- Make use of train brake then, the control has not been found previously
      TrainBrakeControl = FindTrainBrake()
      -- Use a spare axis left from dynamic to control loco brake
      LocoBrakeLine = DynamicBrakeLine
      -- And don't use separate dynamic axis
      DynamicBrakeControl = nil
      DynamicBrakeLine = nil

   -- Some very general German locos detection for AFB/Sifa

   elseif DetectGermanAFBEngine() then
      -- Setup AFB line, the control has already been detected
      AFBLine = DynamicBrakeLine
      -- Disable dynamic
      DynamicBrakeControl = nil
      DynamicBrakeLine = nil

   end

   -- Past this point the following global values should be set if they exist and are set to be used
   -- *Line, *Control
   -- and optionally:
   -- *Invert, *Range, *Notches, *CenterDetent

   -----------------------------------------------------------
   ----- No need to go below for a basic configuration  ------
   -----------------------------------------------------------

   -- Configure axes ranges if applicable and not previously set
   ReverserRange =         GetControlRange(ReverserControl, ReverserRange)
   CombinedThrottleRange = GetControlRange(CombinedThrottleControl, CombinedThrottleRange)
   ThrottleRange =         GetControlRange(ThrottleControl, ThrottleRange)
   TrainBrakeRange =       GetControlRange(TrainBrakeControl, TrainBrakeRange)
   LocoBrakeRange =        GetControlRange(LocoBrakeControl, LocoBrakeRange)
   DynamicBrakeRange =     GetControlRange(DynamicBrakeControl, DynamicBrakeRange)
   AFBRange =              GetControlRange(AFBControl, AFBRange)

   -- Set real values at the start to avoid uncontrolled changing the state after game loads
   local lines = ReadFile("trainsim-helper-joystick.txt")
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

   local Reverser =         GetLineValue(lines, ReverserLine, ReverserInvert)
   local CombinedThrottle = GetLineValue(lines, CombinedThrottleLine, CombinedThrottleInvert)
   local Throttle =         GetLineValue(lines, ThrottleLine, ThrottleInvert)
   local TrainBrake =       GetLineValue(lines, TrainBrakeLine, TrainBrakeInvert)
   local LocoBrake =        GetLineValue(lines, LocoBrakeLine, LocoBrakeInvert)
   local DynamicBrake =     GetLineValue(lines, DynamicBrakeLine, DynamicBrakeInvert)
   local AFB =              GetLineValue(lines, AFBLine, AFBInvert)

   -- Feed with data
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

function WriteFile(name, data)
   local file = io.open("plugins/"..name, "w")
   file:write(data)
   file:flush()
   file:close()
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

function GetControlRange(control, range)
   if control and not range then
      --if Call("*:ControlExists", control, 0) == 1 then
         range = {}
	 range[1] = Call("*:GetControlMinimum", control, 0)
	 range[2] = Call("*:GetControlMaximum", control, 0)
      --end
   end
   if range and (range[1] ~= 0 or range[2] ~= 1) then
      return range
   end
end

function GenerateEqualNotches(count, range)
   if count and count >= 2 then
      notches = {0}
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
