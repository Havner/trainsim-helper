-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
------------  Control values finder functions  ------------
-----------------------------------------------------------
----------- Those are used for joystick input,  -----------
----  but can be used indirectly for overlay as well  -----
-----------------------------------------------------------

function FindCruiseCtl()
   if Call("ControlExists", "SpeedControlTarget", 0) == 1 then     -- BR266
      return "SpeedControlTarget"
   elseif Call("ControlExists", "AFBSet", 0) == 1 then             -- BR442 Talent 2
      return "AFBSet"
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

function FindReverser()
   if Call("ControlExists", "MyReverser", 0) == 1 then  -- FEF-3
      return "MyReverser"
   elseif Call("ControlExists", "UserVirtualReverser", 0) == 1 then  -- BR155, UPGasTurbine
      return "UserVirtualReverser"
   elseif Call("ControlExists", "VirtualReverser", 0) == 1 then
      return "VirtualReverser"
   elseif Call("ControlExists", "Reverser", 0) == 1 then
      return "Reverser"
   end
end

function FindGear()
   if Call("ControlExists", "PowerSelector", 0) == 1 then  -- BR155
      return "PowerSelector"
   elseif Call("ControlExists", "VirtualGearLever", 0) == 1 then
      return "VirtualGearLever"
   elseif Call("ControlExists", "GearLever", 0) == 1 then
      return "GearLever"
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
   if Call("ControlExists", "RegBrake", 0) == 1 then  -- Class 76
      return "RegBrake"
   elseif Call("ControlExists", "VirtualDynamicBrake", 0) == 1 then
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
   if Call("ControlExists", "VirtualSmallCompressorOnOff", 0) == 1 then  -- Fifties Steamers
      return "VirtualSmallCompressorOnOff"
   elseif Call("ControlExists", "SmallEjectorOnOff", 0) == 1 then
      return "SmallEjectorOnOff"
   elseif Call("ControlExists", "SmallCompressorOnOff", 0) == 1 then
      return "SmallCompressorOnOff"
   end
end

function FindLargeEjector()
   if Call("ControlExists", "LargeEjector", 0) == 1 then  -- 3F
      return "LargeEjector"
   elseif Call("ControlExists", "LargeEjectorOnOff", 0) == 1 then
      return "LargeEjectorOnOff"
   end
end

function FindBlower()
   if Call("ControlExists", "BlowerControlValve", 0) == 1 then  -- FEF-3, Connie
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
   elseif Call("ControlExists", "InjectorLeverL", 0) == 1 then  -- Connie
      return "InjectorLeverL"
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
   elseif Call("ControlExists", "VirtualExhaustInjectorWater", 0) == 1 then  -- A2
      return "VirtualExhaustInjectorWater"
   elseif Call("ControlExists", "ExhaustInjectorWater", 0) == 1 then
      return "ExhaustInjectorWater"
   end
end

function FindLiveSteam()
   if Call("ControlExists", "InjectorLeverR", 0) == 1 then  -- FEF-3, Connie
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
   elseif Call("ControlExists", "VirtualLiveInjectorWater", 0) == 1 then  -- A2
      return "VirtualLiveInjectorWater"
   elseif Call("ControlExists", "LiveInjectorWater", 0) == 1 then
      return "LiveInjectorWater"
   end
end

-----------------------------------------------------------
------------  Control values finder functions  ------------
-----------------------------------------------------------
------------ Those are used for overlay input  ------------
-----------------------------------------------------------

