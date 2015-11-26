-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
------------  Control values finder functions  ------------
-----------------------------------------------------------

-----------------------------------------------------------
-----------  Those are used for joystick input,  ----------
-----  but can be used indirectly for overlay as well  ----
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
----------  Those are used for overlay display  -----------
-----------------------------------------------------------

function FindOverlay()
end

function FindOverlayUnits()
   if Call("ControlExists", "SpeedometerMPH", 0) == 1 then
      return "M"
   elseif Call("ControlExists", "SpeedometerKPH", 0) == 1 then
      return "K"
   end
end

function FindOverlayTargetSpeed()
   if Call("ControlExists", "AFB_Speed", 0) == 1 then                -- New PZB
      return "AFB_Speed"
   elseif Call("ControlExists", "SpeedControlSpeed", 0) == 1 then    -- BR266
      return "SpeedControlSpeed"
   elseif Call("ControlExists", "AFBTargetSpeed", 0) == 1 then       -- BR442 Talent 2
      return "AFBTargetSpeed"
   elseif Call("ControlExists", "SpeedSet", 0) == 1 then             -- Class 90 AP
      return "SpeedSet"
   elseif Call("ControlExists", "CruiseControlSpeed", 0) == 1 then   -- Acela
      return "CruiseControlSpeed"
   elseif Call("ControlExists", "VSoll", 0) == 1 then                -- German
      return "VSoll"
   elseif Call("ControlExists", "SpeedTarget", 0) == 1 then          -- Class 365
      return "SpeedTarget"
   elseif Call("ControlExists", "TargetSpeed", 0) == 1 then          -- Class 375/377
      return "TargetSpeed"
   end
end

function FindOverlayReverser()
   if Call("ControlExists", "UserVirtualReverser", 0) == 1 then  -- BR155, UPGasTurbine
      return "UserVirtualReverser"
   elseif Call("ControlExists", "Reverser", 0) == 1 then
      return "Reverser"
   end
end

function FindOverlayGear()
   if Call("ControlExists", "GearLever", 0) == 1 then
      return "GearLever"
   end
end

function FindOverlayPower()
   if Call("ControlExists", "PowerSelector", 0) == 1 then
      return "PowerSelector"
   end
end

function FindOverlayBoilerPressure()
   if Call("ControlExists", "BoilerPressureGaugePSI", 0) == 1 then
      return "BoilerPressureGaugePSI"
   elseif Call("ControlExists", "BoilerPressureGauge", 0) == 1 then
      return "BoilerPressureGauge"
   end
end

function FindOverlayBackPressure()
   if Call("ControlExists", "BackPressure", 0) == 1 then  -- FEF-3
      return "BackPressure"
   end
end

function FindOverlaySteamChestPressure()
   if Call("ControlExists", "RealSteamChestPressure", 0) == 1 then  -- Connie
      return "RealSteamChestPressure"
   elseif Call("ControlExists", "VWSteamChestPressureGauge", 0) == 1 then  -- K1
      return "VWSteamChestPressureGauge"
   elseif Call("ControlExists", "SteamChestGaugePSI", 0) == 1 then
      return "SteamChestGaugePSI"
   elseif Call("ControlExists", "SteamChestGauge", 0) == 1 then
      return "SteamChestGauge"
   elseif Call("ControlExists", "SteamChestPressureGaugePSI", 0) == 1 then
      return "SteamChestPressureGaugePSI"
   elseif Call("ControlExists", "SteamChestPressureGauge", 0) == 1 then
      return "SteamChestPressureGauge"
   end
end

function FindOverlaySteamHeatingPressure()
   if Call("ControlExists", "VWSteamHeatingPressureGauge", 0) == 1 then  -- K1
      return "VWSteamHeatingPressureGauge"
   elseif Call("ControlExists", "Steam Heat Gauge", 0) == 1 then  -- J50
      return "Steam Heat Gauge"
   elseif Call("ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 then
      return "SteamHeatingPressureGaugePSI"
   elseif Call("ControlExists", "SteamHeatGauge", 0) == 1 then
      return "SteamHeatGauge"
   end
end

function FindOverlaySandbox()
   if Call("ControlExists", "FrontSandBox", 0) == 1 then  -- 2F
      return "FrontSandBox"
   elseif Call("ControlExists", "SandLevel", 0) == 1 then  -- Q1
      return "SandLevel"
   end
end

function FindOverlaySandboxRear()
   if Call("ControlExists", "RearSandBox", 0) == 1 then  -- 2F
      return "RearSandBox"
   end
end

function FindOverlayVoltage()
   if Call("ControlExists", "Voltage", 0) == 1 then  -- FEF-3
      return "Voltage"
   end
end

function FindOverlayRPM()
   if Call("ControlExists", "VirtualRPM", 0) == 1 then  -- GT3
      return "VirtualRPM"
   elseif Call("ControlExists", "RPM", 0) == 1 then
      return "RPM"
   end
end

function FindOverlayAmmeter()
   if Call("ControlExists", "Ammeter", 0) == 1 then
      return "Ammeter"
   end
end

function FindOverlayVacuumBrakePipe()
   if Call("ControlExists", "VacuumTest", 0) == 1 then  -- 5700 Pannier DA
      return "VacuumTest", "Inches"
   elseif Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 then
      return "VacuumBrakePipePressureINCHES", "Inches"
   elseif Call("ControlExists", "VacuumBrakePipePressureBAR", 0) == 1 then
      return "VacuumBrakePipePressureBAR", "BAR"
   elseif Call("ControlExists", "VacuumBrakePipePressurePSI", 0) == 1 then
      return "VacuumBrakePipePressurePSI", "PSI"
   end
end

function FindOverlayVacuumBrakeChamber()
   -- Do not add VacuumBrakeChamberPressureINCHES here, it's mostly useless
   if Call("ControlExists", "VacuumChamberSide", 0) == 1 then  -- 5700 Pannier DA
      return "VacuumChamberSide", "Inches"
   elseif Call("ControlExists", "Vacuum Chamber Side", 0) == 1 then  -- J50
      return "Vacuum Chamber Side", "Inches"
   end
end

function FindOverlayTrainBrakeCylinder()
   if Call("ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 then
      return "aTrainBrakeCylinderPressureBAR", "BAR"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressurePSI", 0) == 1 then
      return "aTrainBrakeCylinderPressurePSI", "PSI"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressure", 0) == 1 then
      return "aTrainBrakeCylinderPressure", "PSI"
   elseif Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 then
      return "TrainBrakeCylinderPressureBAR", "BAR"
   elseif Call("ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 then
      return "TrainBrakeCylinderPressurePSI", "PSI"
   elseif Call("ControlExists", "TrainBrakeCylinderPressure", 0) == 1 then
      return "TrainBrakeCylinderPressure", "PSI"
   end
end

function FindOverlayLocoBrakeCylinder()
   if Call("ControlExists", "MyLocoBrakeCylinderPressurePSI", 0) == 1 then  -- FEF-3
      tshUSAdvancedBrakes = true
      return "MyLocoBrakeCylinderPressurePSI", "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSIDisplayed", 0) == 1 then  -- US Advanced, Connie
      tshUSAdvancedBrakes = true
      return "LocoBrakeCylinderPressurePSIDisplayed", "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSIAdvanced", 0) == 1 then  -- US Advanced, Connie
      tshUSAdvancedBrakes = true
      return "LocoBrakeCylinderPressurePSIAdvanced", "PSI"
   elseif Call("ControlExists", "BrakeCylinderDial1", 0) == 1 then  -- Class 50
      return "BrakeCylinderDial1", "PSI"
   elseif Call("ControlExists", "LocoBrakeNeedle", 0) == 1 then  -- Duchess of Sutherland community patch
      return "LocoBrakeNeedle", "PSI"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 then
      return "aLocoBrakeCylinderPressureBAR", "BAR"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressurePSI", 0) == 1 then
      return "aLocoBrakeCylinderPressurePSI", "PSI"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressure", 0) == 1 then
      return "aLocoBrakeCylinderPressure", "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 then
      return "LocoBrakeCylinderPressureBAR", "BAR"
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 then
      return "LocoBrakeCylinderPressurePSI", "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressure", 0) == 1 then
      return "LocoBrakeCylinderPressure", "PSI"
   end
end

function FindOverlayAirBrakePipe()
   if Call("ControlExists", "AirBrakePipePressurePSIDisplayed", 0) == 1 then  -- US Advanced
      return "AirBrakePipePressurePSIDisplayed", "PSI"
   elseif Call("ControlExists", "aAirBrakePipePressureBAR", 0) == 1 then
      return "aAirBrakePipePressureBAR", "BAR"
   elseif Call("ControlExists", "aBrakePipePressureBAR", 0) == 1 then
      return "aBrakePipePressureBAR", "BAR"
   elseif Call("ControlExists", "aAirBrakePipePressurePSI", 0) == 1 then
      return "aAirBrakePipePressurePSI", "PSI"
   elseif Call("ControlExists", "aBrakePipePressurePSI", 0) == 1 then
      return "aBrakePipePressurePSI", "PSI"
   elseif Call("ControlExists", "aAirBrakePipePressure", 0) == 1 then
      return "aAirBrakePipePressure", "PSI"
   elseif Call("ControlExists", "aBrakePipePressure", 0) == 1 then
      return "aBrakePipePressure", "PSI"
   elseif Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 then
      return "AirBrakePipePressureBAR", "BAR"
   elseif Call("ControlExists", "BrakePipePressureBAR", 0) == 1 then
      return "BrakePipePressureBAR", "BAR"
   elseif Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1 then
      return "AirBrakePipePressurePSI", "PSI"
   elseif Call("ControlExists", "BrakePipePressurePSI", 0) == 1 then
      return "BrakePipePressurePSI", "PSI"
   elseif Call("ControlExists", "AirBrakePipePressure", 0) == 1 then
      return "AirBrakePipePressure", "PSI"
   elseif Call("ControlExists", "BrakePipePressure", 0) == 1 then
      return "BrakePipePressure", "PSI"
   end
end

function FindOverlayMainReservoir()
   if Call("ControlExists", "HLB", 0) == 1 then  -- vR103
      return "HLB", "BAR"
   elseif Call("ControlExists", "MRPSI", 0) == 1 then  -- FEF-3
      return "MRPSI", "PSI"
   elseif Call("ControlExists", "MainReservoirPressurePSIDisplayed", 0) == 1 then  -- US Advanced
      return "MainReservoirPressurePSIDisplayed", "PSI"
   elseif Call("ControlExists", "aMainReservoirPressureBAR", 0) == 1 then
      return "aMainReservoirPressureBAR", "BAR"
   elseif Call("ControlExists", "aMainReservoirPressurePSI", 0) == 1 then
      return "aMainReservoirPressurePSI", "PSI"
   elseif Call("ControlExists", "aMainReservoirPressure", 0) == 1 then
      return "aMainReservoirPressure", "PSI"
   elseif Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 then
      return "MainReservoirPressureBAR", "BAR"
   elseif Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 then
      return "MainReservoirPressurePSI", "PSI"
   elseif Call("ControlExists", "MainReservoirPressure", 0) == 1 then
      return "MainReservoirPressure", "PSI"
   end
end

function FindOverlayEqReservoir()
   if Call("ControlExists", "MyEqReservoirPressurePSI", 0) == 1 then  -- FEF-3
      return "MyEqReservoirPressurePSI", "PSI"
   elseif Call("ControlExists", "EqReservoirPressurePSIAdvanced", 0) == 1 then  -- US Advanced
      return "EqReservoirPressurePSIAdvanced", "PSI"
   elseif Call("ControlExists", "aEqReservoirPressureBAR", 0) == 1 then
      return "aEqReservoirPressureBAR", "BAR"
   elseif Call("ControlExists", "aEqReservoirPressurePSI", 0) == 1 then
      return "aEqReservoirPressurePSI", "PSI"
   elseif Call("ControlExists", "aEqReservoirPressure", 0) == 1 then
      return "aEqReservoirPressure", "PSI"
   elseif Call("ControlExists", "EqReservoirPressureBAR", 0) == 1 then
      return "EqReservoirPressureBAR", "BAR"
   elseif Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 then
      return "EqReservoirPressurePSI", "PSI"
   elseif Call("ControlExists", "EqReservoirPressure", 0) == 1 then
      return "EqReservoirPressure", "PSI"
   end
end

function FindOverlayBlowOffCockShutOffRight()
   if Call("ControlExists", "BlowOffCockShutOffR", 0) == 1 then  -- FEF-3
      return "BlowOffCockShutOffR"
   end
end

function FindOverlayDynamo()
   if Call("ControlExists", "Dynamo", 0) == 1 then  -- FEF-3
      return "Dynamo"
   elseif Call("ControlExists", "GeneratorThrottle", 0) == 1 then  -- Connie
      return "GeneratorThrottle"
   end
end

function FindOverlayAirPump()
   if Call("ControlExists", "CompressorThrottle", 0) == 1 then  -- FEF-3
      return "CompressorThrottle"
   elseif Call("ControlExists", "SteamShutOffL", 0) == 1 then  -- Q1
      return "SteamShutOffL"
   elseif Call("ControlExists", "AirPumpOnOff", 0) == 1 then
      return "AirPumpOnOff"
   end
end

function FindOverlaySteamHeatingShutOff()
   if Call("ControlExists", "SteamHeatShutOff", 0) == 1 then  -- Q1
      return "SteamHeatShutOff"
   end
end

function FindOverlaySteamHeating()
   if Call("ControlExists", "Steam Heat Valve", 0) == 1 then  -- J50
      return "Steam Heat Valve"
   elseif Call("ControlExists", "SteamHeatingValve", 0) == 1 then
      return "SteamHeatingValve"
   elseif Call("ControlExists", "SteamHeat", 0) == 1 then
      return "SteamHeat"
   end
end

function FindOverlayMasonsValve()
   if Call("ControlExists", "MasonsValve", 0) == 1 then
      return "MasonsValve"
   end
end

function FindOverlaySteamManifold()
   if Call("ControlExists", "Steam Manifold", 0) == 1 then  -- 2F
      return "Steam Manifold"
   end
end

function FindOverlayLubricatorSteam()
   if Call("ControlExists", "LubricatorSteamThrottle", 0) == 1 then  -- Connie
      return "LubricatorSteamThrottle"
   elseif Call("ControlExists", "LubricatorSteamValve", 0) == 1 then  -- 2F
      return "LubricatorSteamValve"
   end
end

function FindOverlayLubricatorValve()
   if Call("ControlExists", "LubricatorMainValve", 0) == 1 then  -- Connie
      return "LubricatorMainValve"
   end
end

function FindOverlayLubricator()
   if Call("ControlExists", "LubricatorOpenClose", 0) == 1 then  -- Connie
      return "LubricatorOpenClose"
   elseif Call("ControlExists", "LubricatorOilValve", 0) == 1 then  -- 2F
      return "LubricatorOilValve"
   elseif Call("ControlExists", "SteamShutOffR", 0) == 1 then  -- Q1
      return "SteamShutOffR"
   elseif Call("ControlExists", "Lubricator", 0) == 1 then
      return "Lubricator"
   end
end

function FindOverlayLubricatorWarming()
   if Call("ControlExists", "LubricatorWarming", 0) == 1 then
      return "LubricatorWarming"
   end
end

function FindOverlayBrakeHook()
   if Call("ControlExists", "SteamBrakeHook", 0) == 1 then  -- 3F
      return "SteamBrakeHook"
   end
end

function FindOverlaySanderSteam()
   if Call("ControlExists", "SanderSteam", 0) == 1 then  -- Q1
      return "SanderSteam"
   end
end

function FindOverlaySander()
   if Call("ControlExists", "SanderLever", 0) == 1 then  -- Connie
      return "SanderLever"
   elseif Call("ControlExists", "FrontSander", 0) == 1 then  -- J50
      return "FrontSander"
   elseif Call("ControlExists", "VirtualSander", 0) == 1 then  -- 2F
      return "VirtualSander"
   elseif Call("ControlExists", "Sander", 0) == 1 then
      return "Sander"
   end
end

function FindOverlaySanderRear()
   if Call("ControlExists", "Sander2", 0) == 1 then  -- FEF-3
      return "Sander2"
   elseif Call("ControlExists", "RearSander", 0) == 1 then  -- J50
      return "RearSander"
   end
end

function FindOverlaySanderCaps()
   if Call("ControlExists", "SandCaps", 0) == 1 then  -- Q1
      return "SandCaps"
   end
end

function FindOverlaySanderFill()
   if Call("ControlExists", "SandFill", 0) == 1 then  -- Q1
      return "SandFill"
   end
end

function FindOverlayAshpanSprinkler()
   if Call("ControlExists", "AshpanSprinkler", 0) == 1 then  -- Castle Class
      return "AshpanSprinkler"
   end
end

function FindOverlayCylinderCockMaster()
   if Call("ControlExists", "CylinderCockMaster", 0) == 1 then  -- FEF-3
      return "CylinderCockMaster"
   end
end

function FindOverlayCylinderCock()
   if Call("ControlExists", "CylinderCock", 0) == 1 then
      return "CylinderCock"
   end
end

function FindOverlayWaterScoop()
   if Call("ControlExists", "WaterScoop", 0) == 1 then
      return "WaterScoop"
   elseif Call("ControlExists", "WaterScoopRaiseLower", 0) == 1 then  -- I think this one was never functional
      return "WaterScoopRaiseLower"
   end
end

function FindOverlayBlowOffCockShutOffLeft()
   if Call("ControlExists", "BlowOffCockShutOffL", 0) == 1 then  -- FEF-3
      return "BlowOffCockShutOffL"
   end
end

function FindOverlayFeedWaterPumpShutOff()
   if Call("ControlExists", "FWPumpShutOff", 0) == 1 then  -- FEF-3
      return "FWPumpShutOff"
   end
end

function FindOverlayControlValve()
   if Call("ControlExists", "ControlValve", 0) == 1 then  -- FEF-3
      return "ControlValve"
   end
end

function FindOverlayBlowerSteam()
   if Call("ControlExists", "BlowerSteamThrottle", 0) == 1 then  -- Connie
      return "BlowerSteamThrottle"
   end
end

function FindOverlayExhaustInjectorShutOff()
   if Call("ControlExists", "InjectorSteamThrottleL", 0) == 1 then  -- Connie
      return "InjectorSteamThrottleL"
   elseif Call("ControlExists", "Tender_WaterLeverR", 0) == 1 then  -- Q1
      return "Tender_WaterLeverR"
   end
end

function FindOverlayLiveInjectorShutOff()
   if Call("ControlExists", "InjectorSteamThrottleR", 0) == 1 then  -- Connie
      return "InjectorSteamThrottleR"
   elseif Call("ControlExists", "Tender_WaterLeverL", 0) == 1 then  -- Q1
      return "Tender_WaterLeverL"
   end
end

function FindOverlayTenderWaterShutOff()
   if Call("ControlExists", "Tender_WaterShutOff", 0) == 1 then  -- Q1
      return "Tender_WaterShutOff"
   end
end

function FindOverlayAtomizerPressure()
   if Call("ControlExists", "AtomizerPressure", 0) == 1 then  -- FEF-3
      return "AtomizerPressure"
   end
end

function FindOverlayTankTemperature()
   if Call("ControlExists", "TankTemperature", 0) == 1 then  -- FEF-3
      return "TankTemperature"
   end
end

function FindOverlayFireboxDoor()
   if Call("ControlExists", "FireboxDoor", 0) == 1 then
      return "FireboxDoor"
   end
end

function FindOverlayStoking()
   if Call("ControlExists", "Stoking", 0) == 1 then
      return "Stoking"
   end
end

function FindOverlayOilRegulator()
   if Call("ControlExists", "Firing", 0) == 1 then  -- FEF-3
      return "Firing"
   end
end

function FindOverlayAtomizer()
   if Call("ControlExists", "Atomizer", 0) == 1 then  -- FEF-3
      return "Atomizer"
   end
end

function FindOverlayTankHeater()
   if Call("ControlExists", "TankHeater", 0) == 1 then  -- FEF-3
      return "TankHeater"
   end
end

function FindOverlayDamper()
   if Call("ControlExists", "FiredoorDamper", 0) == 1 then  -- FEF-3
      return "FiredoorDamper"
   elseif Call("ControlExists", "VWDamper", 0) == 1 then  -- Small Prairies
      return "VWDamper"
   elseif Call("ControlExists", "Damper", 0) == 1 then
      return "Damper"
   end
end

function FindOverlayDamperLeft()
   if Call("ControlExists", "DamperLeft", 0) == 1 then  -- J94
      return "DamperLeft"
   end
end

function FindOverlayDamperRight()
   if Call("ControlExists", "DamperRight", 0) == 1 then  -- J94
      return "DamperRight"
   end
end

function FindOverlayDamperFront()
   if Call("ControlExists", "DamperFront", 0) == 1 then  -- Q1
      return "DamperFront"
   end
end

function FindOverlayDamperRear()
   if Call("ControlExists", "DamperRear", 0) == 1 then  -- Q1
      return "DamperRear"
   end
end

function FindOverlayWaterGauge()
   if Call("ControlExists", "WaterGauge", 0) == 1 then
      return "WaterGauge"
   end
end

function FindOverlayFeedWaterPressure()
   if Call("ControlExists", "FWHpressure", 0) == 1 then  -- FEF-3
      return "FWHpressure"
   end
end

function FindOverlayFeedWaterPump()
   if Call("ControlExists", "FWPump", 0) == 1 then  -- FEF-3
      return "FWPump"
   end
end

function FindOverlayExhaustInjectorSteam()
   if Call("ControlExists", "InjectorLeverL", 0) == 1 then  -- Connie
      return "InjectorLeverL"
   elseif Call("ControlExists", "Left Steam", 0) == 1 then  -- 2F, 3F
      return "Left Steam"
   elseif Call("ControlExists", "ExhaustInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      return "ExhaustInjectorSteamLever"
   elseif Call("ControlExists", "ExhaustInjectorSteamOnOff", 0) == 1 then
      return "ExhaustInjectorSteamOnOff"
   end
end

function FindOverlayExhaustInjectorWater()
   if Call("ControlExists", "Left Water", 0) == 1 then  -- 2F, 3F
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

function FindOverlayLiveInjectorSteam()
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

function FindOverlayLiveInjectorWater()
   if Call("ControlExists", "Right Water", 0) == 1 then  -- 2F
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

function FindOverlaySafetyValve1()
   if Call("ControlExists", "SafetyValveEngineer", 0) == 1 then  -- FEF-3
      return "SafetyValveEngineer"
   elseif Call("ControlExists", "SafetyValveVolume", 0) == 1 then  -- Connie
      return "SafetyValveVolume"
   elseif Call("ControlExists", "SafetyValve1", 0) == 1 then
      return "SafetyValve1"
   end
end

function FindOverlaySafetyValve2()
   if Call("ControlExists", "SafetyValveFireman", 0) == 1 then  -- FEF-3
      return "SafetyValveFireman"
   elseif Call("ControlExists", "SafetyValve2", 0) == 1 then
      return "SafetyValve2"
   end
end

function FindOverlayAlarm()
   if Call("ControlExists", "AlerterCountdown", 0) == 1 then
      return "AlerterCountdown"
   elseif Call("ControlExists", "AWSWarnCount", 0) == 1 then
      return "AWSWarnCount"
   end
end

function FindOverlayVigilAlarm()
   if Call("ControlExists", "SifaWarnung", 0) == 1 then  -- BR420, BR103, BR111
      return "SifaWarnung"
   elseif Call("ControlExists", "SiFaWarning", 0) == 1 then  -- BR442
      return "SiFaWarning"
   elseif Call("ControlExists", "DSDAlarm", 0) == 1 then
      return "DSDAlarm"
   elseif Call("ControlExists", "VigilAlarm", 0) == 1 then
      return "VigilAlarm"
   elseif Call("ControlExists", "DSD", 0) == 1 then
      return "DSD"
   end
end

function FindOverlayEmergencyBrake()
   if Call("ControlExists", "BrakeDemandLamp", 0) == 1 then  -- Class 37/4
      return "BrakeDemandLamp"
   elseif Call("ControlExists", "EmergencyAlarm", 0) == 1 then
      return "EmergencyAlarm"
   elseif Call("ControlExists", "EmergencyBrake", 0) == 1 then
      return "EmergencyBrake"
   end
end

function FindOverlayStartup()
   if Call("ControlExists", "Startup", 0) == 1 then
      return "Startup"
   end
end

function FindOverlayDoors()
   if Call("ControlExists", "DoorsOpenClose", 0) == 1 then
      return "DoorsOpenClose"
   end
end

function FindOverlayDoorsLeft()
   if Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 then
      return "DoorsOpenCloseLeft"
   end
end

function FindOverlayDoorsRight()
   if Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 then
      return "DoorsOpenCloseRight"
   end
end
