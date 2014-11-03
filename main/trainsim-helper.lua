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
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 365 detected", 3, 0)
      return 1
   end
end

function DetectHST() -- London - Peterborough, Riviera Line
   if Call("*:ControlExists", "RpmDial", 0) == 1 and
      Call("*:ControlExists", "HandBrakeOff", 0) == 1 and
      Call("*:ControlExists", "Headlightsmarker", 0) == 1 and
      Call("*:ControlExists", "EngineStop", 0) == 1 and
      Call("*:ControlExists", "EngineStart", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "EmergencyValve", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "HST detected", 3, 0)
      return 1
   end
end

function DetectClass801() -- London - Peterborough
   if Call("*:ControlExists", "SpeedoUnits", 0) == 1 and
      Call("*:ControlExists", "SpeedoTens", 0) == 1 and
      Call("*:ControlExists", "SpeedoHundreds", 0) == 1 and
      Call("*:ControlExists", "MotorLowPitch", 0) == 1 and
      Call("*:ControlExists", "MotorHighPitch", 0) == 1 and
      Call("*:ControlExists", "MotorVolume", 0) == 1 and
      Call("*:ControlExists", "CamInCab", 0) == 1 and
      Call("*:ControlExists", "Table", 0) == 1 and
      Call("*:ControlExists", "ATPBox", 0) == 1 and
      Call("*:ControlExists", "Coat1", 0) == 1 and
      Call("*:ControlExists", "ForwardPreparation", 0) == 1 and
      Call("*:ControlExists", "RearPreparation", 0) == 1 and
      Call("*:ControlExists", "ReadingLight", 0) == 1 and
      Call("*:ControlExists", "DeskIllumination", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 801 detected", 3, 0)
      return 1
   end
end   

function DetectClass375Class377() -- London - Faversham, London - Brighton
   if Call("*:ControlExists", "Buzzer", 0) == 1 and
      Call("*:ControlExists", "BrakeHold", 0) == 1 and
      Call("*:ControlExists", "CarSlider", 0) == 1 and
      Call("*:ControlExists", "ShoesUp", 0) == 1 and
      Call("*:ControlExists", "PanUp", 0) == 1 and
      Call("*:ControlExists", "TaillightSwitch", 0) == 1 and
      Call("*:ControlExists", "SpeedSetUp", 0) == 1 and
      Call("*:ControlExists", "SideBlind", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 375/377 detected", 3, 0)
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
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 450 detected", 3, 0)
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
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 395 detected", 3, 0)
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
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 360 detected", 3, 0)
      return 1
   end
end

function DetectClass90_ADV_AP() -- London - Ipswich
   if Call("*:ControlExists", "VisualAids", 0) == 1 and
      Call("*:ControlExists", "CabAmbience", 0) == 1 and
      Call("*:ControlExists", "AirCon", 0) == 1 and
      Call("*:ControlExists", "IntFanTimer", 0) == 1 and
      Call("*:ControlExists", "ExtFanTimer", 0) == 1 and
      Call("*:ControlExists", "BIS", 0) == 1 and
      Call("*:ControlExists", "swGuardWiper", 0) == 1 and
      Call("*:ControlExists", "GuardWiper", 0) == 1 and
      Call("*:ControlExists", "TPWS", 0) == 1 and
      Call("*:ControlExists", "DSDPedal", 0) == 1 and
      Call("*:ControlExists", "VirtualEngineBrakeControl", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 90 (ADV, AP) detected", 3, 0)
      return 1
   end
end

function DetectMK3DVT_ADV_AP() -- London - Ipswich
   if Call("*:ControlExists", "VisualAids", 0) == 1 and
      Call("*:ControlExists", "CabAmbience", 0) == 1 and
      Call("*:ControlExists", "AirCon", 0) == 1 and
      Call("*:ControlExists", "IntFanTimer", 0) == 1 and
      Call("*:ControlExists", "ExtFanTimer", 0) == 1 and
      Call("*:ControlExists", "BIS", 0) == 1 and
      Call("*:ControlExists", "swGuardWiper", 0) == 1 and
      Call("*:ControlExists", "GuardWiper", 0) == 1 and
      Call("*:ControlExists", "TPWS", 0) == 1 and
      Call("*:ControlExists", "DSDPedal", 0) == 1 and
      Call("*:ControlExists", "DVTTraction", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "MK3 DVT (ADV, AP) detected", 3, 0)
      return 1
   end
end

function DetectClass158() -- Liverpool - Manchester
   if Call("*:ControlExists", "SptEngineStartLight", 0) == 1 and
      Call("*:ControlExists", "VirtualBrake", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "SptDoorInterlock", 0) == 1 and
      Call("*:ControlExists", "CabLight", 0) == 1 and
      Call("*:ControlExists", "Instrument Lights", 0) == 1 and
      Call("*:ControlExists", "Blower", 0) == 1 and
      Call("*:ControlExists", "DRA", 0) == 1 and
      Call("*:ControlExists", "DSDEnabled", 0) == 1 and
      Call("*:ControlExists", "AWSReady", 0) == 1 and
      Call("*:ControlExists", "AWSTesting", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 158 detected", 3, 0)
      return 1
   end
end   

function DetectClass101() -- Liverpool - Manchester
   if Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "ReservoirPressurePSI", 0) == 1 and
      Call("*:ControlExists", "VacuumChamberPressureINCHES", 0) == 1 and
      Call("*:ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("*:ControlExists", "EngineStop", 0) == 1 and
      Call("*:ControlExists", "EngineStart", 0) == 1 and
      Call("*:ControlExists", "GearLever", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "Bell", 0) == 1 and
      Call("*:ControlExists", "CabLight", 0) == 1 and
      Call("*:ControlExists", "InstrumentLights", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 101 detected", 3, 0)
      return 1
   end
end   

function DetectClass143() -- Riviera Line
   if Call("*:ControlExists", "RPM", 0) == 1 and
      Call("*:ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("*:ControlExists", "VirtualBrake", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "CabLight", 0) == 1 and
      Call("*:ControlExists", "DashLights", 0) == 1 and
      Call("*:ControlExists", "DRA", 0) == 1 and
      Call("*:ControlExists", "Fan", 0) == 1 and
      Call("*:ControlExists", "Buzzer", 0) == 1 and
      Call("*:ControlExists", "AWSReady", 0) == 1 and
      Call("*:ControlExists", "AWSTesting", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 143 detected", 3, 0)
      return 1
   end
end

function DetectClass35() -- Riviera Line
   if Call("*:ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("*:ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("*:ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 and
      Call("*:ControlExists", "HandBrake", 0) == 1 and
      Call("*:ControlExists", "CabLight", 0) == 1 and
      Call("*:ControlExists", "Oven", 0) == 1 and
      Call("*:ControlExists", "HotPlate", 0) == 1 and
      Call("*:ControlExists", "InstrumentLights", 0) == 1 and
      Call("*:ControlExists", "Pasty", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 35 detected", 3, 0)
      return 1
   end
end

function DetectClass03() -- West Somerset Railway
   if Call("*:ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("*:ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("*:ControlExists", "OilPressure", 0) == 1 and
      Call("*:ControlExists", "FuelGauge", 0) == 1 and
      Call("*:ControlExists", "WaterTemperatureGauge", 0) == 1 and
      Call("*:ControlExists", "GearBoxPressure", 0) == 1 and
      Call("*:ControlExists", "OldAirBrakePipePressurePSI", 0) == 1 and
      Call("*:ControlExists", "GearLever", 0) == 1 and
      Call("*:ControlExists", "CabLight", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 03 detected", 3, 0)
      return 1
   end
end


function DetectClass47() -- West Somerset Railway
   if Call("*:ControlExists", "TractiveEffort", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("*:ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("*:ControlExists", "MainReservoirPressurePSI", 0) == 1 and
      Call("*:ControlExists", "Ammeter", 0) == 1 and
      Call("*:ControlExists", "EngineStop", 0) == 1 and
      Call("*:ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 and
      Call("*:ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("*:ControlExists", "CabLight", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 47 detected", 3, 0)
      return 1
   end
end

function DetectClass321_AP()
   if Call("*:ControlExists", "desind", 0) == 1 and
      Call("*:ControlExists", "Destination", 0) == 1 and
      Call("*:ControlExists", "Bogie1Flat", 0) == 1 and
      Call("*:ControlExists", "RoofCabLight", 0) == 1 and
      Call("*:ControlExists", "Linelightdimmer", 0) == 1 and
      Call("*:ControlExists", "Linelightglow", 0) == 1 and
      Call("*:ControlExists", "Linelight", 0) == 1 and
      Call("*:ControlExists", "DSHeater", 0) == 1 and
      Call("*:ControlExists", "NDSHeater", 0) == 1 and
      Call("*:ControlExists", "WheelLock", 0) == 1 and
      Call("*:ControlExists", "VirtualResPressureNeedle", 0) == 1 and
      Call("*:ControlExists", "DialLightSwitch", 0) == 1 and
      Call("*:ControlExists", "VCB", 0) == 1 and
      Call("*:ControlExists", "TPWS", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 321 (AP) detected", 3, 0)
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
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 156 (Oovee) detected", 3, 0)
      return 1
   end
end

function DetectClass170() -- Academy
   if Call("*:ControlExists", "Buzzer", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("*:ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "GlareScreen", 0) == 1 and
      Call("*:ControlExists", "DRA", 0) == 1 and
      Call("*:ControlExists", "DSDEnabled", 0) == 1 and
      Call("*:ControlExists", "InteriorCamera", 0) == 1 and
      Call("*:ControlExists", "Loco", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Class 170 detected", 3, 0)
      return 1
   end
end

-- Steamers

function DetectCastle() -- Riviera Line
   if Call("*:ControlExists", "FireboxDoor", 0) == 1 and
      Call("*:ControlExists", "Stoking", 0) == 1 and
      Call("*:ControlExists", "SteamFlow", 0) == 1 and
      Call("*:ControlExists", "Flap", 0) == 1 and
      Call("*:ControlExists", "HeadBoard", 0) == 1 and
      Call("*:ControlExists", "Lamp1", 0) == 1 and
      Call("*:ControlExists", "Lamp4", 0) == 1 and
      Call("*:ControlExists", "SteamHeat", 0) == 1 and
      Call("*:ControlExists", "SteamHeatGauge", 0) == 1 and
      Call("*:ControlExists", "MasonsValve", 0) == 1 and
      Call("*:ControlExists", "TestCock1", 0) == 1 and
      Call("*:ControlExists", "TestCock2", 0) == 1 and
      Call("*:ControlExists", "Lubricator", 0) == 1 and
      Call("*:ControlExists", "LubricatorWarming", 0) == 1 and
      Call("*:ControlExists", "AshpanSprinkler", 0) == 1 and
      Call("*:ControlExists", "SeatDriver", 0) == 1 and
      Call("*:ControlExists", "SeatFireman", 0) == 1 and
      Call("*:ControlExists", "CastleThunder", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Castle detected", 3, 0)
      return 1
   end
end

-- German

function DetectBR294() -- Munich - Augsburg, Hamburg - Hanover
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 0 and
      Call("*:ControlExists", "LZBEnable", 0) == 0 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "DummyAmmeter", 0) == 1 and
      Call("*:ControlExists", "DummyVoltmeter", 0) == 1 and
      Call("*:ControlExists", "DummyOilPressure", 0) == 1 and
      Call("*:ControlExists", "DummyCoolantTemperature", 0) == 1 and
      Call("*:ControlExists", "DummyOilTemperature", 0) == 1 and
      Call("*:ControlExists", "DummyEnginePressure", 0) == 1 and
      Call("*:ControlExists", "DummyTransmissionPressure", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "BR294 detected", 3, 0)
      return 1
   end
end

function DetectBR101() -- Munich - Augsburg, Hamburg - Hanover
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 250 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("*:ControlExists", "RolloL", 0) == 0 and
      Call("*:ControlExists", "RolloR", 0) == 0 and
      Call("*:ControlExists", "Amp", 0) == 0 and
      Call("*:ControlExists", "HandBrake", 0) == 1 and
      Call("*:ControlExists", "Tilt", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "BR101 detected", 3, 0)
      return 1
   end
end

function DetectBR426() -- Munich - Garmisch
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 300 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("*:ControlExists", "RolloL", 0) == 1 and
      Call("*:ControlExists", "RolloR", 0) == 1 and
      Call("*:ControlExists", "Amp", 0) == 1 and
      Call("*:ControlExists", "HandBrake", 0) == 1 and
      Call("*:ControlExists", "Tilt", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "BR426 detected", 3, 0)
      return 1
   end
end

function DetectICE2() -- Hamburg - Hanover
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 300 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("*:ControlExists", "RolloL", 0) == 1 and
      Call("*:ControlExists", "RolloR", 0) == 1 and
      Call("*:ControlExists", "Amp", 0) == 1 and
      Call("*:ControlExists", "HandBrake", 0) == 1 and
      Call("*:ControlExists", "Tilt", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ICE 2 detected", 3, 0)
      return 1
   end
end

function DetectICE2Cab() -- Hamburg - Hanover
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 300 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("*:ControlExists", "RolloL", 0) == 1 and
      Call("*:ControlExists", "RolloR", 0) == 1 and
      Call("*:ControlExists", "Amp", 0) == 1 and
      Call("*:ControlExists", "HandBrake", 0) == 1 and
      Call("*:ControlExists", "Tilt", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ICE 2 CabCar detected", 3, 0)
      return 1
   end
end

function DetectICE3() -- Hamburg - Hanover
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 350 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("*:ControlExists", "RolloL", 0) == 0 and
      Call("*:ControlExists", "RolloR", 0) == 0 and
      Call("*:ControlExists", "Amp", 0) == 0 and
      Call("*:ControlExists", "HandBrake", 0) == 0 and
      Call("*:ControlExists", "Tilt", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ICE 3 detected", 3, 0)
      return 1
   end
end

function DetectICET() -- Hamburg - Hanover
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 350 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("*:ControlExists", "RolloL", 0) == 0 and
      Call("*:ControlExists", "RolloR", 0) == 0 and
      Call("*:ControlExists", "Amp", 0) == 0 and
      Call("*:ControlExists", "HandBrake", 0) == 1 and
      Call("*:ControlExists", "Tilt", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ICE T detected", 3, 0)
      return 1
   end
end

function DetectBR189() -- Academy
   if Call("*:ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("*:ControlExists", "VSoll", 0) == 1 and
      Call("*:GetControlMaximum", "VSoll", 0) == 140 and
      Call("*:ControlExists", "PZBEnable", 0) == 1 and
      Call("*:ControlExists", "PZB_1000", 0) == 1 and
      Call("*:ControlExists", "LZBEnable", 0) == 1 and
      Call("*:ControlExists", "LZB_End", 0) == 1 and
      Call("*:ControlExists", "VigilEnable", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "GlarePanel_L", 0) == 1 and
      Call("*:ControlExists", "CabAmmeter", 0) == 1 and
      Call("*:ControlExists", "SpeedoGuide", 0) == 1 and
      Call("*:ControlExists", "PantoMovement", 0) == 1 and
      Call("*:ControlExists", "TrackLimit", 0) == 1 and
      Call("*:ControlExists", "DynamicBrakeFanSound", 0) == 1 and
      Call("*:ControlExists", "TrainBrakeOnly", 0) == 1 and
      Call("*:ControlExists", "CamInCab", 0) == 1 and
      Call("*:ControlExists", "PowerBar", 0) == 1 and
      Call("*:ControlExists", "CabDirection", 0) == 1 and
      Call("*:ControlExists", "PowerBar", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "BR189 detected", 3, 0)
      return 1
   end
end

-- US
   
function DetectCabCar() -- Pacific Surfliner and its addons
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "AWSReset", 0) == 1 and
      Call("*:ControlExists", "HornHB", 0) == 1 and
      Call("*:ControlExists", "Flash", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("*:ControlExists", "EqReservoirPressurePSI", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "CabCar detected", 3, 0)
      return 1
   end
end

function DetectF59PHI() -- Pacific Surfliner and its addon
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "AWSReset", 0) == 1 and
      Call("*:ControlExists", "HornHB", 0) == 1 and
      Call("*:ControlExists", "Flash", 0) == 1 and
      Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("*:ControlExists", "VisorLeft", 0) == 0 and
      Call("*:ControlExists", "VisorMiddle", 0) == 0 and
      Call("*:ControlExists", "VisorRight", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "F59PHI detected", 3, 0)
      return 1
   end
end

function DetectF59PH() -- Pacific Surfliner addon
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "AWSReset", 0) == 1 and
      Call("*:ControlExists", "HornHB", 0) == 1 and
      Call("*:ControlExists", "Flash", 0) == 1 and
      Call("*:ControlExists", "HEPGen", 0) == 1 and
      Call("*:ControlExists", "VisorLeft", 0) == 1 and
      Call("*:ControlExists", "VisorMiddle", 0) == 1 and
      Call("*:ControlExists", "VisorRight", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "F59PH detected", 3, 0)
      return 1
   end
end

function DetectACS64() -- New York - New Haven
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "ATCCutIn", 0) == 1 and
      Call("*:ControlExists", "TimeToPenalty", 0) == 1 and
      Call("*:ControlExists", "SpeedDigit_units", 0) == 1 and
      Call("*:ControlExists", "SigAspectTopGreen", 0) == 1 and
      Call("*:ControlExists", "SigText", 0) == 1 and
      Call("*:ControlExists", "ScreenDoorsBypassed", 0) == 1 and
      Call("*:ControlExists", "ScreenFireSuppressionDisabled", 0) == 1 and
      Call("*:ControlExists", "SpeedDigit_guide", 0) == 1 and
      Call("*:ControlExists", "AlarmsToExterior", 0) == 1 and
      Call("*:ControlExists", "TractiveEffortKLBF", 0) == 1 and
      Call("*:ControlExists", "SigModeACSES", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ACS64 detected", 3, 0)
      return 1
   end
end

function DetectAcela() -- New York - New Haven
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("*:ControlExists", "ATCCutIn", 0) == 1 and
      Call("*:ControlExists", "TimeToPenalty", 0) == 1 and
      Call("*:ControlExists", "Doors", 0) == 1 and
      Call("*:ControlExists", "SelPanto", 0) == 1 and
      Call("*:ControlExists", "FrontPantoControl", 0) == 1 and
      Call("*:ControlExists", "RearPantoControl", 0) == 1 and
      Call("*:ControlExists", "Servicio", 0) == 1 and
      Call("*:ControlExists", "TiltIsolate", 0) == 1 and
      Call("*:ControlExists", "FrontCone", 0) == 1 and
      Call("*:ControlExists", "GroundLights", 0) == 1 and
      Call("*:ControlExists", "Dimmer", 0) == 1 and
      Call("*:ControlExists", "SpeedoGuide", 0) == 1 and
      Call("*:ControlExists", "DestJoy", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Acela detected", 3, 0)
      return 1
   end
end   

function DetectM8() -- New York - New Haven
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "ATCCutIn", 0) == 1 and
      Call("*:ControlExists", "TimeToPenalty", 0) == 1 and
      Call("*:ControlExists", "MyNumber", 0) == 1 and
      Call("*:ControlExists", "Coach_2", 0) == 1 and
      Call("*:ControlExists", "Cars", 0) == 1 and
      Call("*:ControlExists", "SpeedoUnits", 0) == 1 and
      Call("*:ControlExists", "CylinderUnits", 0) == 1 and
      Call("*:ControlExists", "PipeUnits", 0) == 1 and
      Call("*:ControlExists", "PowerAC", 0) == 1 and
      Call("*:ControlExists", "PowerOverhead", 0) == 1 and
      Call("*:ControlExists", "MotorVolume", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "M8 detected", 3, 0)
      return 1
   end
end   

function DetectSD70MAC_ATC() -- Academy
   if Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "ATCCutIn", 0) == 1 and
      Call("*:ControlExists", "TimeToPenalty", 0) == 1 and
      Call("*:ControlExists", "RPMDelta", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "AWSReset", 0) == 1 and
      Call("*:ControlExists", "GlarePanels", 0) == 1 and
      Call("*:ControlExists", "StepsLight", 0) == 1 and
      Call("*:ControlExists", "aEqReservoirPressurePSI", 0) == 1 and
      Call("*:ControlExists", "EmergencyBrake_Flap", 0) == 1 and
      Call("*:ControlExists", "G_BP", 0) == 1 and
      Call("*:ControlExists", "AirCompressor", 0) == 1 and
      Call("*:ControlExists", "CurrentAmtrakSignal", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "SD70MAC (ATC) detected", 3, 0)
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
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "SD70M detected", 3, 0)
      return 1
   end
end 

function DetectES44DC() -- Stevens Pass, Marias Pass
   if Call("*:GetControlMinimum", "DynamicBrake", 0) == -0.125 and
      Call("*:ControlExists", "UnitNumber", 0) == 1 and
      Call("*:ControlExists", "G_Speedo", 0) == 1 and
      Call("*:ControlExists", "SPEED_units", 0) == 1 and
      Call("*:ControlExists", "G_ER", 0) == 1 and
      Call("*:ControlExists", "ER_units", 0) == 1 and
      Call("*:ControlExists", "G_BC", 0) == 1 and
      Call("*:ControlExists", "BC_units", 0) == 1 and
      Call("*:ControlExists", "G_MAIN", 0) == 1 and
      Call("*:ControlExists", "MAIN_units", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ES44DC detected", 3, 0)
      return 1
   end
end

function DetectC449W() -- Donner Pass
   if Call("*:GetControlMaximum", "Ammeter", 0) == 1800 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "AWS", 0) == 1 and
      Call("*:ControlExists", "AWSReset", 0) == 1 and
      Call("*:ControlExists", "GlarePanels", 0) == 1 and
      Call("*:ControlExists", "TrackDetect1", 0) == 1 and
      Call("*:ControlExists", "TrackDetect2", 0) == 1
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "C44-9W detected", 3, 0)
      return 1
   end
end

function DetectES44AC() -- Sherman Hill, Norfolk Southern
   if Call("*:GetControlMinimum", "DynamicBrake", 0) == 0 and
      Call("*:ControlExists", "UnitNumber", 0) == 1 and
      Call("*:ControlExists", "G_Speedo", 0) == 1 and
      Call("*:ControlExists", "SPEED_units", 0) == 1 and
      Call("*:ControlExists", "G_ER", 0) == 1 and
      Call("*:ControlExists", "ER_units", 0) == 1 and
      Call("*:ControlExists", "G_BC", 0) == 1 and
      Call("*:ControlExists", "BC_units", 0) == 1 and
      Call("*:ControlExists", "G_MAIN", 0) == 1 and
      Call("*:ControlExists", "MAIN_units", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "ES44AC detected", 3, 0)
      return 1
   end
end

function DetectF45() -- Marias Pass
   if Call("*:GetControlMaximum", "RPM", 0) == 1050 and
      Call("*:ControlExists", "Strobe", 0) == 1 and
      Call("*:ControlExists", "RPM", 0) == 1 and
      Call("*:ControlExists", "Ammeter", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      Call("*:ControlExists", "MainReservoirPressurePSI", 0) == 1 and
      Call("*:ControlExists", "AirBrakePipePressurePSI", 0) == 1 and
      Call("*:ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 and
      Call("*:ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 and
      Call("*:ControlExists", "EqReservoirPressurePSI", 0) == 1 and
      Call("*:ControlExists", "EngineStart", 0) == 1 and
      Call("*:ControlExists", "EngineStop", 0) == 1 and
      Call("*:ControlExists", "Sander", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0
   then
      SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "F45 detected", 3, 0)
      return 1
   end
end
   
-- some general detections

function DetectGermanAFB(DisableNote)
   if Call("*:ControlExists", "AFB", 0) == 1
   then
      if not DisableNote then
	 SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "German AFB detected", 3, 0)
      end
      return 1
   end
end

function DetectSteam(DisableNote)
   if Call("*:ControlExists", "FireboxDoor", 0) == 1 and
      Call("*:ControlExists", "Stoking", 0) == 1
   then
      if not DisableNote then
	 SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Steam detected", 3, 0)
      end
      return 1
   end
end
   
function DetectGenericUS(DisableNote)
   if Call("*:ControlExists", "RPM", 0) == 1 and
      Call("*:ControlExists", "Ammeter", 0) == 1 and
      Call("*:ControlExists", "CompressorState", 0) == 1 and
      (
	 Call("*:ControlExists", "MainReservoirPressurePSI", 0) == 1 or
         Call("*:ControlExists", "aMainReservoirPressurePSI", 0) == 1
      ) and
      (
	 Call("*:ControlExists", "AirBrakePipePressurePSI", 0) == 1 or
	 Call("*:ControlExists", "aAirBrakePipePressurePSI", 0) == 1
      ) and
      (
	 Call("*:ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 or
         Call("*:ControlExists", "aTrainBrakeCylinderPressurePSI", 0) == 1 or
	 Call("*:ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 or
	 Call("*:ControlExists", "aLocoBrakeCylinderPressurePSI", 0) == 1 or
	 Call("*:ControlExists", "EqReservoirPressurePSI", 0) == 1 or
	 Call("*:ControlExists", "aEqReservoirPressurePSI", 0) == 1
      ) and
      Call("*:ControlExists", "Sander", 0) == 1 and
      Call("*:ControlExists", "ThrottleAndBrake", 0) == 0
   then
      if not DisableNote then
	 SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", "Generic US detected", 3, 0)
      end
      return 1
   end
end

function DetectUK() -- MPH and BAR, should be UK, hopefully, used for Gradient
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
