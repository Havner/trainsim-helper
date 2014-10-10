-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
----------------  Locos detect functions  -----------------
-----------------------------------------------------------
--  Can be used for both, Overlay and Joystick modules  ---
-----------------------------------------------------------

function DetectClass365() -- London - Peterborough
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "Thingy", 0) == 1 and
      Call("*:ControlExists", "SpeedTriangle", 0) == 1 and
      Call("*:ControlExists", "SpeedTarget", 0) == 1 and
      Call("*:ControlExists", "DashLights", 0) == 1
   then
      return 1
   end
end

function DetectHST() -- London - Peterborough
   if Call("*:ControlExists", "RpmDial", 0) == 1 and
      Call("*:ControlExists", "HandBrakeOff", 0) == 1 and
      Call("*:ControlExists", "Headlightsmarker", 0) == 1 and
      Call("*:ControlExists", "EngineStop", 0) == 1 and
      Call("*:ControlExists", "EngineStart", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "EmergencyValve", 0) == 1
   then
      return 1
   end
end

function DetectClass377() -- and 375, London - Brighton, London - Faversham
   if Call("*:ControlExists", "Buzzer", 0) == 1 and
      Call("*:ControlExists", "BrakeHold", 0) == 1 and
      Call("*:ControlExists", "CarSlider", 0) == 1 and
      Call("*:ControlExists", "ShoesUp", 0) == 1 and
      Call("*:ControlExists", "PanUp", 0) == 1 and
      Call("*:ControlExists", "TaillightSwitch", 0) == 1 and
      Call("*:ControlExists", "SpeedSetUp", 0) == 1 and
      Call("*:ControlExists", "SideBlind", 0) == 1
   then
      return 1
   end
end

function DetectClass450() -- London - Brighton
   if Call("*:ControlExists", "SimulationJustSetup", 0) == 1 and
      Call("*:ControlExists", "CoachID", 0) == 1 and
      Call("*:ControlExists", "RegenerativeSound", 0) == 1 and
      Call("*:ControlExists", "MotorSound", 0) == 1 and
      Call("*:ControlExists", "InputDisabler", 0) == 1 and
      Call("*:ControlExists", "SignalBell", 0) == 1
   then
      return 1
   end
end

function DetectClass395() -- London - Faversham
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:GetControlMinimum", "ThrottleAndBrake", 0) == -1.5 and
      Call("*:ControlExists", "PanUpShoesDown", 0) == 1 and
      Call("*:ControlExists", "VirtualReverser", 0) == 1 and
      Call("*:ControlExists", "DC", 0) == 1 and
      Call("*:ControlExists", "CTRL", 0) == 1
   then
      return 1
   end
end

function DetectClass360() -- London - Ipswich
   if Call("*:ControlExists", "LineVolts", 0) == 1 and
      Call("*:ControlExists", "CoachType", 0) == 1 and
      Call("*:ControlExists", "CamInCab", 0) == 1 and
      Call("*:ControlExists", "FanSound", 0) == 1 and
      Call("*:ControlExists", "MotorLowPitch", 0) == 1 and
      Call("*:ControlExists", "MotorHighPitch1", 0) == 1 and
      Call("*:ControlExists", "MotorVolume", 0) == 1 and
      Call("*:ControlExists", "AuxMotors", 0) == 1 and
      Call("*:ControlExists", "SideR", 0) == 1 and
      Call("*:ControlExists", "SideL", 0) == 1 and
      Call("*:ControlExists", "Instruments", 0) == 1 and
      Call("*:ControlExists", "Fuerza", 0) == 1
   then
      return 1
   end
end

function DetectClass156_Oovee()
   if Call("*:ControlExists", "VirtualRPM", 0) == 1 and
      Call("*:ControlExists", "VirtualFluid", 0) == 1 and
      Call("*:ControlExists", "Surge", 0) == 1 and
      Call("*:ControlExists", "GuardSignal", 0) == 1 and
      Call("*:ControlExists", "Destination", 0) == 1 and
      Call("*:ControlExists", "GearBoxFault", 0) == 1 and
      Call("*:ControlExists", "DriverSignal", 0) == 1 and
      Call("*:ControlExists", "DestinationLight", 0) == 1 and
      Call("*:ControlExists", "HeaterFan", 0) == 1 and
      Call("*:ControlExists", "SunblindLeft", 0) == 1
   then
      return 1
   end
end

function DetectES44DC() -- Stevens Pass
   if Call("*:GetControlMinimum", "DynamicBrake", 0) == -0.125 and
      Call("*:ControlExists", "UnitNumber", 0) == 1 and
      Call("*:ControlExists", "G_Speedo", 0) == 1 and
      Call("*:ControlExists", "SPEED_units", 0) == 1 and
      Call("*:ControlExists", "G_ER", 0) == 1 and
      Call("*:ControlExists", "ER_units", 0) == 1 and
      Call("*:ControlExists", "G_BC", 0) == 1 and
      Call("*:ControlExists", "BC_units", 0) == 1 and
      Call("*:ControlExists", "G_MAIN", 0) == 1 and
      Call("*:ControlExists", "MAIN_units", 0) == 1
   then
      return 1
   end
end

function DetectGP38_2() -- Stevens Pass
   if Call("*:ControlExists", "TractiveEffort", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 and
      Call("*:ControlExists", "StepsLight", 0) == 1 and
      Call("*:ControlExists", "CylinderCock", 0) == 1
   then
      return 1
   end
end

function DetectES44AC() -- Sherman Hill
   if Call("*:GetControlMinimum", "DynamicBrake", 0) == 0 and
      Call("*:ControlExists", "UnitNumber", 0) == 1 and
      Call("*:ControlExists", "G_Speedo", 0) == 1 and
      Call("*:ControlExists", "SPEED_units", 0) == 1 and
      Call("*:ControlExists", "G_ER", 0) == 1 and
      Call("*:ControlExists", "ER_units", 0) == 1 and
      Call("*:ControlExists", "G_BC", 0) == 1 and
      Call("*:ControlExists", "BC_units", 0) == 1 and
      Call("*:ControlExists", "G_MAIN", 0) == 1 and
      Call("*:ControlExists", "MAIN_units", 0) == 1
   then
      return 1
   end
end

function DetectSD70M() -- Sherman Hill
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "AWSReset", 0) == 1 and
      Call("*:ControlExists", "GlarePanels", 0) == 1 and
      Call("*:ControlExists", "UN_units", 0) == 1 and
      Call("*:ControlExists", "UN_thousands", 0) == 1 and
      Call("*:ControlExists", "StepsLight", 0) == 1 and
      Call("*:ControlExists", "EqReservoirPressurePSI", 0) == 1
   then
      return 1
   end
end

-- some general detections

function DetectUK() -- MPH and BAR, should be UK, hopefully
   if Call("*:ControlExists", "SpeedometerMPH", 0) == 1 and
      (Call("*:ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 or
	  Call("*:ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 or
	  Call("*:ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 or
	  Call("*:ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 or
	  Call("*:ControlExists", "AirBrakePipePressureBAR", 0) == 1 or
	  Call("*:ControlExists", "aAirBrakePipePressureBAR", 0) == 1 or
	  Call("*:ControlExists", "BrakePipePressureBAR", 0) == 1 or
	  Call("*:ControlExists", "aBrakePipePressureBAR", 0) == 1)
   then
      return 1
   end
end

function DetectGermanAFB()
   if Call("*:ControlExists", "AFB", 0) == 1
   then
      return 1
   end
end

-----------------------------------------------------------
------------  Load TrainSim-Helper modules  ---------------
-----------------------------------------------------------

require("plugins/trainsim-helper-overlay.lua")
require("plugins/trainsim-helper-joystick.lua")

-----------------------------------------------------------
------------  Main per frame update function  -------------
-----------------------------------------------------------

function UpdateHelper(time)
   -- Check if the player is driving this train
   if Call("*:GetIsEngineWithKey") ~= 1 then
      return nil
   end

   if not OverlayConfigured then
      ConfigureOverlay()
   end
   GetOverlayData()

   if not JoystickConfigured then
      ConfigureJoystick()
   end
   SetJoystickData()
end
