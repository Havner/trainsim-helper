-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
-----------------  Overlay configuration  -----------------
-----------------------------------------------------------

function ConfigureOverlay()

   -- Define strings for warning messages. You can override them per loco.
   -- Or comment out / redefine to nil if you don't want specific one.
   -- NO SPACES IN THE STRINGS ALLOWED (will fix that later, use '_')
   TextAlarm =       "AWS"
   TextVigilAlarm =  "DSD"
   TextEmergency =   "Emergency"
   TextStartup =     "Engine"
   TextDoors =       "Doors"

   -- Set UK gradient format. Can be set per loco.
   --GradientUK = 1

   if DetectInterfaceGerman() then
      TextAlarm = "PZB"
      TextVigilAlarm = "Sifa"
   end
   
   if DetectInterfaceUK() then
      --GradientUK = 1
   end

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues to display
   
   -- Units

   if Call("ControlExists", "SpeedometerMPH", 0) == 1 then
      tshStaticValues["Units"] = "M"
   elseif Call("ControlExists", "SpeedometerKPH", 0) == 1 then
      tshStaticValues["Units"] = "K"
   end

   -- Loco's controls, those are mostly low-level values so one can see what is happening
   -- under the hood. They can be overriden with high-level ones per loco when needed.

   if Call("ControlExists", "SpeedControlSpeed", 0) == 1 then        -- BR266
      tshControlValues["TargetSpeed"] = "SpeedControlSpeed"
   elseif Call("ControlExists", "AFBTargetSpeed", 0) == 1 then       -- BR442 Talent 2
      tshControlValues["TargetSpeed"] = "AFBTargetSpeed"
   elseif Call("ControlExists", "SpeedSet", 0) == 1 then             -- Class 90 AP
      tshControlValues["TargetSpeed"] = "SpeedSet"
   elseif Call("ControlExists", "CruiseControlSpeed", 0) == 1 then   -- Acela
      tshControlValues["TargetSpeed"] = "CruiseControlSpeed"
   elseif Call("ControlExists", "VSoll", 0) == 1 then                -- German
      tshControlValues["TargetSpeed"] = "VSoll"
   elseif Call("ControlExists", "SpeedTarget", 0) == 1 then          -- Class 365
      tshControlValues["TargetSpeed"] = "SpeedTarget"
      tshControlValuesFunctions["TargetSpeed"] = function(value) return value * 120 end
   elseif Call("ControlExists", "TargetSpeed", 0) == 1 then          -- Class 375/377
      tshControlValues["TargetSpeed"] = "TargetSpeed"
   end

   if Call("ControlExists", "Reverser", 0) == 1 then
      tshControlValues["Reverser"] = "Reverser"
   end

   if Call("ControlExists", "GearLever",0) == 1 then
      tshControlValues["GearLever"] = "GearLever"
   end
   
   if Call("ControlExists", "Regulator", 0) == 1 then
      tshControlValues["Throttle"] = "Regulator"
   end
   
   if Call("ControlExists", "TrainBrakeControl", 0) == 1 then
      tshControlValues["TrainBrake"] = "TrainBrakeControl"
   end

   if Call("ControlExists", "EngineBrakeControl", 0) == 1 then
      tshControlValues["LocoBrake"] = "EngineBrakeControl"
   end

   if Call("ControlExists", "DynamicBrake", 0) == 1 then
      tshControlValues["DynamicBrake"] = "DynamicBrake"
   end

   if Call("ControlExists", "HandBrake", 0) == 1 then
      tshControlValues["HandBrake"] = "HandBrake"
   elseif Call("ControlExists", "Handbrake", 0) == 1 then
      tshControlValues["HandBrake"] = "Handbrake"
   end

   -- Loco's indicators

   if Call("ControlExists", "BoilerPressureGaugePSI",0) == 1 then
      tshControlValues["BoilerPressure"] = "BoilerPressureGaugePSI"
   elseif Call("ControlExists", "BoilerPressureGauge", 0) == 1 then
      tshControlValues["BoilerPressure"] = "BoilerPressureGauge"
   end

   if Call("ControlExists", "BackPressure", 0) == 1 then  -- FEF-3
      tshControlValues["BackPressure"] = "BackPressure"
   end

   if Call("ControlExists", "SteamChestGaugePSI", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestGaugePSI"
   elseif Call("ControlExists", "SteamChestGauge", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestGauge"
   elseif Call("ControlExists", "SteamChestPressureGaugePSI", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestPressureGaugePSI"
   elseif Call("ControlExists", "SteamChestPressureGauge", 0) == 1 then
      tshControlValues["SteamChestPressure"] = "SteamChestPressureGauge"
   end

   if Call("ControlExists", "Steam Heat Gauge", 0) == 1 then  -- J50
      tshControlValues["SteamHeatingPressure"] = "Steam Heat Gauge"
   elseif Call("ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 then
      tshControlValues["SteamHeatingPressure"] = "SteamHeatingPressureGaugePSI"
   elseif Call("ControlExists", "SteamHeatGauge", 0) == 1 then
      tshControlValues["SteamHeatingPressure"] = "SteamHeatGauge"
   end

   if Call("ControlExists", "FrontSandBox", 0) == 1 then  -- 2F
      tshControlValues["Sandbox"] = "FrontSandBox"
   elseif Call("ControlExists", "SandLevel", 0) == 1 then  -- Q1
      tshControlValues["Sandbox"] = "SandLevel"
   end

   if Call("ControlExists", "RearSandBox", 0) == 1 then  -- 2F
      tshControlValues["SandboxRear"] = "RearSandBox"
   end

   if Call("ControlExists", "Voltage", 0) == 1 then  -- FEF-3
      tshControlValues["Voltage"] = "Voltage"
   end

   if Call("ControlExists", "RPM", 0) == 1 then
      tshControlValues["RPM"] = "RPM"
   end

   if Call("ControlExists", "Ammeter", 0) == 1 then
      tshControlValues["Ammeter"] = "Ammeter"
   end

   -- Brake's indicators

   if Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 then
      tshControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureINCHES"
      tshStaticValues["VacuumBrakePipeUnits"] = "Inches"
   elseif Call("ControlExists", "VacuumBrakePipePressureBAR", 0) == 1 then
      tshControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureBAR"
      tshStaticValues["VacuumBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "VacuumBrakePipePressurePSI", 0) == 1 then
      tshControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressurePSI"
      tshStaticValues["VacuumBrakePipeUnits"] = "PSI"
   end

   -- Do not add VacuumBrakeChamberPressureINCHES here, it's mostly useless
   if Call("ControlExists", "Vacuum Chamber Side", 0) == 1 then  -- J50
      tshControlValues["VacuumBrakeChamberPressure"] = "Vacuum Chamber Side"
      tshStaticValues["VacuumBrakeChamberUnits"] = "Inches"
   end

   if Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressureBAR"
      tshStaticValues["TrainBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressureBAR"
      tshStaticValues["TrainBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressurePSI"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressurePSI"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "TrainBrakeCylinderPressure", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressure"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aTrainBrakeCylinderPressure", 0) == 1 then
      tshControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressure"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   end

   if Call("ControlExists", "MyLocoBrakeCylinderPressurePSI", 0) == 1 then  -- FEF-3
      tshControlValues["LocoBrakeCylinderPressure"] = "MyLocoBrakeCylinderPressurePSI"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "BrakeCylinderDial1", 0) == 1 then  -- Class 50
      tshControlValues["TrainBrakeCylinderPressure"] = "BrakeCylinderDial1"
      tshStaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "LocoBrakeNeedle", 0) == 1 then  -- Duchess of Sutherland community patch
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeNeedle"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressureBAR"
      tshStaticValues["LocoBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressureBAR"
      tshStaticValues["LocoBrakeCylinderUnits"] = "BAR"
   elseif Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressurePSI"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressurePSI", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressurePSI"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "LocoBrakeCylinderPressure", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressure"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("ControlExists", "aLocoBrakeCylinderPressure", 0) == 1 then
      tshControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressure"
      tshStaticValues["LocoBrakeCylinderUnits"] = "PSI"
   end

   if Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "aAirBrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aAirBrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "BrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "BrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "aBrakePipePressureBAR", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aBrakePipePressureBAR"
      tshStaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aAirBrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aAirBrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "BrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "BrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aBrakePipePressurePSI", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aBrakePipePressurePSI"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "AirBrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "AirBrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aAirBrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aAirBrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "BrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "BrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("ControlExists", "aBrakePipePressure", 0) == 1 then
      tshControlValues["AirBrakePipePressure"] = "aBrakePipePressure"
      tshStaticValues["AirBrakePipeUnits"] = "PSI"
   end

   if Call("ControlExists", "HLB", 0) == 1 then  -- vR103
      tshControlValues["MainReservoirPressure"] = "HLB"
      tshStaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "MRPSI", 0) == 1 then  -- FEF-3
      tshControlValues["MainReservoirPressure"] = "MRPSI"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressureBAR"
      tshStaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "aMainReservoirPressureBAR", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "aMainReservoirPressureBAR"
      tshStaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressurePSI"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aMainReservoirPressurePSI", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "aMainReservoirPressurePSI"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "MainReservoirPressure", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "MainReservoirPressure"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aMainReservoirPressure", 0) == 1 then
      tshControlValues["MainReservoirPressure"] = "aMainReservoirPressure"
      tshStaticValues["MainReservoirUnits"] = "PSI"
   end

   if Call("ControlExists", "MyEqReservoirPressurePSI", 0) == 1 then  -- FEF-3
      tshControlValues["EqReservoirPressure"] = "MyEqReservoirPressurePSI"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "EqReservoirPressureBAR", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressureBAR"
      tshStaticValues["EqReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "aEqReservoirPressureBAR", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "aEqReservoirPressureBAR"
      tshStaticValues["EqReservoirUnits"] = "BAR"
   elseif Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressurePSI"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aEqReservoirPressurePSI", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "aEqReservoirPressurePSI"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "EqReservoirPressure", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "EqReservoirPressure"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("ControlExists", "aEqReservoirPressure", 0) == 1 then
      tshControlValues["EqReservoirPressure"] = "aEqReservoirPressure"
      tshStaticValues["EqReservoirUnits"] = "PSI"
   end

   -- Steamers (driver)
   
   if Call("ControlExists", "BlowOffCockShutOffR", 0) == 1 then  -- FEF-3
      tshControlValues["BlowOffCockShutOffRight"] = "BlowOffCockShutOffR"
   end

   if Call("ControlExists", "Dynamo", 0) == 1 then  -- FEF-3
      tshControlValues["Dynamo"] = "Dynamo"
   end
   
   if Call("ControlExists", "CompressorThrottle", 0) == 1 then  -- FEF-3
      tshControlValues["AirPump"] = "CompressorThrottle"
   elseif Call("ControlExists", "SteamShutOffL", 0) == 1 then  -- Q1
      tshControlValues["AirPump"] = "SteamShutOffL"
   elseif Call("ControlExists", "AirPumpOnOff", 0) == 1 then
      tshControlValues["AirPump"] = "AirPumpOnOff"
   end

   if Call("ControlExists", "SteamHeatShutOff", 0) == 1 then  -- Q1
      tshControlValues["SteamHeatingShutOff"] = "SteamHeatShutOff"
   end

   if Call("ControlExists", "Steam Heat Valve", 0) == 1 then  -- J50
      tshControlValues["SteamHeating"] = "Steam Heat Valve"
   elseif Call("ControlExists", "SteamHeatingValve", 0) == 1 then
      tshControlValues["SteamHeating"] = "SteamHeatingValve"
   elseif Call("ControlExists", "SteamHeat", 0) == 1 then
      tshControlValues["SteamHeating"] = "SteamHeat"
   end

   if Call("ControlExists", "MasonsValve", 0) == 1 then
      tshControlValues["MasonsValve"] = "MasonsValve"
   end

   if Call("ControlExists", "Steam Manifold", 0) == 1 then  -- 2F
      tshControlValues["SteamManifold"] = "Steam Manifold"
   end

   if Call("ControlExists", "LubricatorSteamValve", 0) == 1 then  -- 2F
      tshControlValues["LubricatorSteam"] = "LubricatorSteamValve"
   end

   if Call("ControlExists", "LubricatorOilValve", 0) == 1 then  -- 2F
      tshControlValues["Lubricator"] = "LubricatorOilValve"
   elseif Call("ControlExists", "SteamShutOffR", 0) == 1 then  -- Q1
      tshControlValues["Lubricator"] = "SteamShutOffR"
   elseif Call("ControlExists", "Lubricator", 0) == 1 then
      tshControlValues["Lubricator"] = "Lubricator"
   end

   if Call("ControlExists", "LubricatorWarming", 0) == 1 then
      tshControlValues["LubricatorWarming"] = "LubricatorWarming"
   end

   if Call("ControlExists", "SmallEjectorOnOff", 0) == 1 then
      tshControlValues["SmallEjector"] = "SmallEjectorOnOff"
   elseif Call("ControlExists", "SmallCompressorOnOff", 0) == 1 then
      tshControlValues["SmallEjector"] = "SmallCompressorOnOff"
   end

   if Call("ControlExists", "LargeEjector", 0) == 1 then  -- 3F
      tshControlValues["LargeEjector"] = "LargeEjector"
   elseif Call("ControlExists", "LargeEjectorOnOff", 0) == 1 then
      tshControlValues["LargeEjector"] = "LargeEjectorOnOff"
   end
   
   if Call("ControlExists", "SteamBrakeHook", 0) == 1 then  -- 3F
      tshControlValues["BrakeHook"] = "SteamBrakeHook"
   end

   if Call("ControlExists", "SanderSteam", 0) == 1 then  -- Q1
      tshControlValues["SanderSteam"] = "SanderSteam"
   end

   if Call("ControlExists", "FrontSander", 0) == 1 then  -- J50
      tshControlValues["Sander"] = "FrontSander"
   elseif Call("ControlExists", "VirtualSander", 0) == 1 then  -- 2F
      tshControlValues["Sander"] = "VirtualSander"
   elseif Call("ControlExists", "Sander", 0) == 1 then
      tshControlValues["Sander"] = "Sander"
   end

   if Call("ControlExists", "Sander2", 0) == 1 then  -- FEF-3
      tshControlValues["SanderRear"] = "Sander2"
   elseif Call("ControlExists", "RearSander", 0) == 1 then  -- J50
      tshControlValues["SanderRear"] = "RearSander"
   end

   if Call("ControlExists", "SandCaps", 0) == 1 then  -- Q1
      tshControlValues["SanderCaps"] = "SandCaps"
   end

   if Call("ControlExists", "SandFill", 0) == 1 then  -- Q1
      tshControlValues["SanderFill"] = "SandFill"
   end

   if Call("ControlExists", "AshpanSprinkler", 0) == 1 then
      tshControlValues["AshpanSprinkler"] = "AshpanSprinkler"
   end

   if Call("ControlExists", "CylinderCockMaster", 0) == 1 then  -- FEF-3
      tshControlValues["CylinderCockMaster"] = "CylinderCockMaster"
   end

   if Call("ControlExists", "CylinderCock", 0) == 1 then
      tshControlValues["CylinderCock"] = "CylinderCock"
   end

   if Call("ControlExists", "WaterScoopRaiseLower", 0) == 1 then
      tshControlValues["WaterScoopRaiseLower"] = "WaterScoopRaiseLower"
   end

   -- Steamers (fireman)

   if Call("ControlExists", "BlowOffCockShutOffL", 0) == 1 then  -- FEF-3
      tshControlValues["BlowOffCockShutOffLeft"] = "BlowOffCockShutOffL"
   end

   if Call("ControlExists", "FWPumpShutOff", 0) == 1 then  -- FEF-3
      tshControlValues["FeedWaterPumpShutOff"] = "FWPumpShutOff"
   end

   if Call("ControlExists", "ControlValve", 0) == 1 then  -- FEF-3
      tshControlValues["ControlValve"] = "ControlValve"
   end
   
   if Call("ControlExists", "Tender_WaterLeverR", 0) == 1 then  -- Q1
      tshControlValues["ExhaustInjectorShutOff"] = "Tender_WaterLeverR"
   end

   if Call("ControlExists", "Tender_WaterLeverL", 0) == 1 then  -- Q1
      tshControlValues["LiveInjectorShutOff"] = "Tender_WaterLeverL"
   end

   if Call("ControlExists", "Tender_WaterShutOff", 0) == 1 then  -- Q1
      tshControlValues["TenderWaterShutOff"] = "Tender_WaterShutOff"
   end

   -- FireboxMass from the functions

   if Call("ControlExists", "AtomizerPressure", 0) == 1 then  -- FEF-3
      tshControlValues["AtomizerPressure"] = "AtomizerPressure"
   end

   if Call("ControlExists", "TankTemperature", 0) == 1 then  -- FEF-3
      tshControlValues["TankTemperature"] = "TankTemperature"
   end   

   if Call("ControlExists", "FireboxDoor", 0) == 1 then
      tshControlValues["FireboxDoor"] = "FireboxDoor"
   end

   if Call("ControlExists", "Stoking", 0) == 1 then
      tshControlValues["Stoking"] = "Stoking"
   end

   if Call("ControlExists", "Firing", 0) == 1 then  -- FEF-3
      tshControlValues["OilRegulator"] = "Firing"
   end

   if Call("ControlExists", "Atomizer", 0) == 1 then  -- FEF-3
      tshControlValues["Atomizer"] = "Atomizer"
   end

   if Call("ControlExists", "TankHeater", 0) == 1 then  -- FEF-3
      tshControlValues["TankHeater"] = "TankHeater"
   end

   if Call("ControlExists", "BlowerControlValve", 0) == 1 then  -- FEF-3
      tshControlValues["Blower"] = "BlowerControlValve"
   elseif Call("ControlExists", "Blower", 0) == 1 then
      tshControlValues["Blower"] = "Blower"
   end

   if Call("ControlExists", "FiredoorDamper", 0) == 1 then  -- FEF-3
      tshControlValues["Damper"] = "FiredoorDamper"
   elseif Call("ControlExists", "VWDamper", 0) == 1 then  -- Small Prairies
      tshControlValues["Damper"] = "VWDamper"
   elseif Call("ControlExists", "Damper", 0) == 1 then
      tshControlValues["Damper"] = "Damper"
   end

   if Call("ControlExists", "DamperLeft", 0) == 1 then  -- J94
      tshControlValues["DamperLeft"] = "DamperLeft"
   end

   if Call("ControlExists", "DamperRight", 0) == 1 then  -- J94
      tshControlValues["DamperRight"] = "DamperRight"
   end

   if Call("ControlExists", "DamperFront", 0) == 1 then  -- Q1
      tshControlValues["DamperFront"] = "DamperFront"
   end

   if Call("ControlExists", "DamperRear", 0) == 1 then  -- Q1
      tshControlValues["DamperRear"] = "DamperRear"
   end

   if Call("ControlExists", "WaterGauge", 0) == 1 then
      tshControlValues["WaterGauge"] = "WaterGauge"
   end

   if Call("ControlExists", "FWHpressure", 0) == 1 then  -- FEF-3
      tshControlValues["FeedWaterPressure"] = "FWHpressure"
   end

   if Call("ControlExists", "FWPump", 0) == 1 then  -- FEF-3
      tshControlValues["FeedWaterPump"] = "FWPump"
   end

   if Call("ControlExists", "Left Steam", 0) == 1 then  -- 2F, 3F
      tshControlValues["ExhaustInjectorSteam"] = "Left Steam"
   elseif Call("ControlExists", "ExhaustInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamLever"
   elseif Call("ControlExists", "ExhaustInjectorSteamOnOff", 0) == 1 then
      tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
   end

   if Call("ControlExists", "Left Water", 0) == 1 then  -- 2F, 3F
      tshControlValues["ExhaustInjectorWater"] = "Left Water"
   elseif Call("ControlExists", "ExhaustInjectorWaterLever", 0) == 1 then  -- 14xx
      tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWaterLever"
   elseif Call("ControlExists", "ExhaustInjectorWaterFineControl", 0) == 1 then  -- Q1
      tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWaterFineControl"
   elseif Call("ControlExists", "ExhaustInjectorWater", 0) == 1 then
      tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
   end

   if Call("ControlExists", "InjectorLeverR", 0) == 1 then  -- FEF-3
      tshControlValues["LiveInjectorSteam"] = "InjectorLeverR"
   elseif Call("ControlExists", "Right Steam", 0) == 1 then  -- 2F, 3F
      tshControlValues["LiveInjectorSteam"] = "Right Steam"
   elseif Call("ControlExists", "LiveInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamLever"
   elseif Call("ControlExists", "LiveInjectorSteamOnOff", 0) == 1 then
      tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
   end

   if Call("ControlExists", "Right Water", 0) == 1 then  -- 2F
      tshControlValues["LiveInjectorWater"] = "Right Water"
   elseif Call("ControlExists", "LiveInjectorWaterLever", 0) == 1 then  -- 14xx
      tshControlValues["LiveInjectorWater"] = "LiveInjectorWaterLever"
   elseif Call("ControlExists", "LiveInjectorWaterFineControl", 0) == 1 then  -- Q1
      tshControlValues["LiveInjectorWater"] = "LiveInjectorWaterFineControl"
   elseif Call("ControlExists", "LiveInjectorWater", 0) == 1 then
      tshControlValues["LiveInjectorWater"] = "LiveInjectorWater"
   end

   if Call("ControlExists", "SafetyValveEngineer", 0) == 1 then  -- FEF-3
      tshControlValues["SafetyValve1"] = "SafetyValveEngineer"
   elseif Call("ControlExists", "SafetyValve1", 0) == 1 then
      tshControlValues["SafetyValve1"] = "SafetyValve1"
   end
   
   if Call("ControlExists", "SafetyValveFireman", 0) == 1 then  -- FEF-3
      tshControlValues["SafetyValve2"] = "SafetyValveFireman"
   elseif Call("ControlExists", "SafetyValve2", 0) == 1 then
      tshControlValues["SafetyValve2"] = "SafetyValve2"
   end

   if Call("ControlExists", "SafetyValveUnmuffled", 0) == 1 then  -- FEF-3
      tshControlValues["SafetyValve3"] = "SafetyValveUnmuffled"
   end

   -- Warning values
   
   if Call("ControlExists", "AlerterCountdown", 0) == 1 then
      tshControlValues["Alarm"] = "AlerterCountdown"
   elseif Call("ControlExists", "AWSWarnCount", 0) == 1 then
      tshControlValues["Alarm"] = "AWSWarnCount"
   end

   if Call("ControlExists", "SifaWarnung", 0) == 1 then  -- BR420, BR103, BR111
      tshControlValues["VigilAlarm"] = "SifaWarnung"
   elseif Call("ControlExists", "SiFaWarning", 0) == 1 then  -- BR442
      tshControlValues["VigilAlarm"] = "SiFaWarning"
   elseif Call("ControlExists", "DSDAlarm", 0) == 1 then
      tshControlValues["VigilAlarm"] = "DSDAlarm"
   elseif Call("ControlExists", "VigilAlarm", 0) == 1 then
      tshControlValues["VigilAlarm"] = "VigilAlarm"
   elseif Call("ControlExists", "DSD", 0) == 1 then
      tshControlValues["VigilAlarm"] = "DSD"
   end

   if Call("ControlExists", "BrakeDemandLamp", 0) == 1 then  -- CLass 37/4
      tshControlValues["EmergencyBrake"] = "BrakeDemandLamp"
   elseif Call("ControlExists", "EmergencyAlarm", 0) == 1 then
      tshControlValues["EmergencyBrake"] = "EmergencyAlarm"
   elseif Call("ControlExists", "EmergencyBrake", 0) == 1 then
      tshControlValues["EmergencyBrake"] = "EmergencyBrake"
   end

   if Call("ControlExists", "Startup", 0) == 1 then
      tshControlValues["Startup"] = "Startup"
   end

   -- Doors Values

   if Call("ControlExists", "DoorsOpenClose", 0) == 1 then
      tshDoorsValues["Doors"] = "DoorsOpenClose"
   end

   if Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 then
      tshDoorsValues["DoorsLeft"] = "DoorsOpenCloseLeft"
   end

   if Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 then
      tshDoorsValues["DoorsRight"] = "DoorsOpenCloseRight"
   end

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- Sometimes I have to do this as a loco might have a control value that is
   -- detected but it should not be displayed. E.g. it's internal to the
   -- implementation or is basically useless for this loco.

   -- Steamers

   -- Some steamers use regulator for steam chest pressure, display lever
   if DetectGenericSteam(true) then
      if Call("ControlExists", "VirtualThrottle", 0) == 1 then
         tshControlValues["Throttle"] = "VirtualThrottle"
      end
   end

   -- Things common for the ADV and HUD versions of FEF-3
   if DetectFEF3_ADV_Smokebox(true) or DetectFEF3_HUD_Smokebox(true) then
      -- Hide the internal values
      tshControlValues["SteamChestPressure"] = nil
      tshControlValues["TrainBrakeCylinderPressure"] = nil
      tshControlValues["FireboxDoor"] = nil
      tshControlValues["Stoking"] = nil
      tshControlValues["ExhaustInjectorSteam"] = nil
      tshControlValues["ExhaustInjectorWater"] = nil

      -- If you want safety valves comment out the following 3 lines
      tshControlValues["SafetyValve1"] = nil
      tshControlValues["SafetyValve2"] = nil
      tshControlValues["SafetyValve3"] = nil

      -- Firebox is 0-5%, make it full range (0-100%)
      tshControlValuesFunctions["FireboxMass"] =
         function(value)
            return value * 20
         end
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] =
         function(value)
            value = value - 0.3
            if (value < 0) then
               value = value * 100
            else
               value = value * 50
            end
            return value
         end
   end

   if DetectFEF3_ADV_Smokebox(true) then
      -- Show levers values instead of internal, they make little sense here
      -- This is only for the ADV version, not the HUD.
      tshControlValues["Reverser"] = "MyReverser"
      tshControlValues["Throttle"] = "RegulatorLever"
      tshControlValues["TrainBrake"] = "TrainBrakeHandle"
      tshControlValues["LocoBrake"] = "MyEngineBrakeControl"

   elseif Detect2FDockTank_ADV_MeshTools(true) then
      -- Lever for Train/Steam brake
      tshControlValues["TrainBrake"] = "VirtualBrake"
      -- Internal for steam brake should be hidden
      tshControlValues["LocoBrake"] = nil
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end

   elseif DetectJ50_ADV_MeshTools(true) then
      -- Vacuum Brake lever, internal should be hidden
      tshControlValues["TrainBrake"] = "VirtualBrake"
      tshControlValues["LocoBrake"] = nil
      -- It has left and right dampers, if you want to see effective damper comment out
      tshControlValues["Damper"] = nil

   elseif Detect3FJintyTrain_ADV_MeshTools(true) then
      -- Correct levers for Train and Steam (push/pull) brakes
      tshControlValues["TrainBrake"] = "VirtualBrake"
      tshControlValues["LocoBrake"] = "SteamBrakeSpindle"
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end

   elseif Detect3FJintySteam_ADV_MeshTools(true) then
      -- Steam brake lever
      tshControlValues["TrainBrake"] = "VirtualBrake"
      -- Internal should be hidden
      tshControlValues["LocoBrake"] = nil
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end
      -- It doesn't have vacuum brakes, hide
      tshControlValues["VacuumBrakePipePressure"] = nil
      tshStaticValues["VacuumBrakePipeUnits"] = nil

   elseif DetectJ94Train_ADV_MeshTools(true) then
      -- Loco/Steam Brake lever, internal should be hidden
      tshControlValues["LocoBrake"] = "VirtualLocoBrake"
      -- It has left and right dampers, if you want to see effective damper comment out
      tshControlValues["Damper"] = nil

   elseif DetectJ94Steam_ADV_MeshTools(true) then
      -- There is no TrainBrake here, use steam brake as one
      tshControlValues["TrainBrake"] = "VirtualLocoBrake"
      -- Internal should be hidden
      tshControlValues["LocoBrake"] = nil
      -- Not functional, hide
      tshControlValues["SmallEjector"] = nil
      -- It has left and right dampers, if you want to see effective damper comment out
      tshControlValues["Damper"] = nil

   elseif DetectSmallPrairies_VictoryWorks(true) then
      -- Correct lever for TrainBrake
      tshControlValues["TrainBrake"] = "VirtualBrake"

   elseif Detect14xx_VictoryWorks(true) then
      -- It has front and rear dampers, if you want to see effective damper comment out
      tshControlValues["Damper"] = nil

   elseif DetectBulleidQ1_VictoryWorks(true) then
      -- It has front and rear dampers, if you want to see effective damper comment out
      tshControlValues["Damper"] = nil
      -- Not functional, hide
      tshControlValues["WaterScoopRaiseLower"] = nil

      -- Uncomment all if you want to display simple water controls
      --tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
      --tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
      --tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
      --tshControlValues["LiveInjectorWater"] = "LiveInjectorWater"
      --tshControlValues["ExhaustInjectorShutOff"] = nil
      --tshControlValues["LiveInjectorShutOff"] = nil
      --tshControlValues["TenderWaterShutOff"] = nil

      -- Make the sander {0,1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 900 end

   elseif DetectGWRRailmotor_VictoryWorks(true) or DetectGWRRailmotorBoogie_VictoryWorks(true) then
      -- Not functional, hide
      tshControlValues["SmallEjector"] = nil

   elseif DetectBlack5_KeithRoss(true) then
      -- Not functional, hide
      tshControlValues["WaterScoopRaiseLower"] = nil

   -- UK

   elseif DetectClass90_ADV_AP(true) then
      -- Throttle is delayed significantly, show lever
      tshControlValues["Throttle"] = "VirtualThrottle"
      -- LocoBrake lever, internal should be hidden
      tshControlValues["LocoBrake"] = "VirtualEngineBrakeControl"

   elseif DetectMK3DVT_ADV_AP(true) then
      -- Throttle is delayed significantly, show lever
      tshControlValues["Throttle"] = "VirtualThrottle"

   elseif DetectClass37_Thomson(true) then
      -- Throttle is delayed significantly, show lever
      tshControlValues["Throttle"] = "VirtualThrottle"

   elseif DetectClass50_MeshTools(true) then
      -- Throttle is delayed significantly, show lever
      tshControlValues["Throttle"] = "VirtualThrottle"

   -- German

   elseif DetectBR103TEE_vRailroads_Expert(true) then
	   -- Throttle is delayed significantly, show lever
	   tshControlValues["Throttle"] = "VirtualThrottle"
	   -- Scale values to (0,1)
	   tshControlValuesFunctions["Throttle"] = function(value) return value / 39 end

   elseif DetectBR103TEE_vRailroads(true) then
	   -- Throttle is delayed significantly, show lever
	   tshControlValues["Throttle"] = "VirtualThrottle"
	   -- Scale values to (0,1)
	   tshControlValuesFunctions["Throttle"] = function(value) return value / 39 end
	   tshControlValuesFunctions["LocoBrake"] = function(value) return (value + 1) / 2 end
	   -- Not functional, hide
	   tshControlValues["TargetSpeed"] = nil

   elseif DetectBR111_vRailroads(true) or DetectDBbzf_vRailroads(true) then
	   -- Throttle is delayed significantly, show lever
	   tshControlValues["Throttle"] = "VirtualThrottle"

   elseif DetectBR442Talent2(true) then
      -- LocoBrake is actually a TrainBrake, reflect that
      tshControlValues["TrainBrake"] = tshControlValues["LocoBrake"]
      tshControlValues["LocoBrake"] = nil
      -- Not functional, hide
      tshControlValues["LocoBrakeCylinderPressure"] = nil

   elseif DetectBR266(true) then
      -- TrainBrake lever, internal should be hidden
      tshControlValues["TrainBrake"] = "VirtualBrake"

   end

   -- Set at the very end to be a mark whether the configuration has been successful.
   OverlayConfigured = 1
end

-----------------------------------------------------------
----------------  Main overlay function  ------------------
-----------------------------------------------------------

function GetOverlayData()
   local data = "" -- data storage for data to write to output file

   -- SIM values

   local Clock = SysCall("ScenarioManager:GetTimeOfDay")
   if Clock then data = data.."Clock: "..Clock.."\n" end

   local Speed = Call("GetSpeed")
   if Speed then data = data.."Speed: "..Speed.."\n" end

   local SpeedLimit = Call("GetCurrentSpeedLimit")
   if SpeedLimit then data = data.."SpeedLimit: "..SpeedLimit.."\n" end

   local NextSpeedLimitType, NextSpeedLimit, NextSpeedLimitDistance = Call("GetNextSpeedLimit", 0)
   if NextSpeedLimitType then data = data.."NextSpeedLimitType: "..NextSpeedLimitType.."\n" end
   if NextSpeedLimit then data = data.."NextSpeedLimit: "..NextSpeedLimit.."\n" end
   if NextSpeedLimitDistance then data = data.."NextSpeedLimitDistance: "..NextSpeedLimitDistance.."\n" end

   local NextSpeedLimitBackType, NextSpeedLimitBack, NextSpeedLimitBackDistance = Call("GetNextSpeedLimit", 1)
   if NextSpeedLimitBackType then data = data.."NextSpeedLimitBackType: "..NextSpeedLimitBackType.."\n" end
   if NextSpeedLimitBack then data = data.."NextSpeedLimitBack: "..NextSpeedLimitBack.."\n" end
   if NextSpeedLimitBackDistance then data = data.."NextSpeedLimitBackDistance: "..NextSpeedLimitBackDistance.."\n" end

   -- Overlay is not using this, it calculates its own that behaves a little bit better
   -- Leaving this exported though if someone is using it
   local Acceleration = Call("GetAcceleration")
   if Acceleration then data = data.."Acceleration: "..string.format("%.6f", Acceleration).."\n" end

   local Gradient = Call("GetGradient")
   if Gradient then data = data.."Gradient: "..Gradient.."\n" end

   local FireboxMass = Call("GetFireboxMass")
   if FireboxMass and tshControlValuesFunctions["FireboxMass"] then FireboxMass = tshControlValuesFunctions["FireboxMass"](FireboxMass) end
   if FireboxMass then data = data.."FireboxMass: "..FireboxMass.."\n" end

   -- Static Values loop
   for key, value in pairs(tshStaticValues) do
      data = data..key..": "..value.."\n"
   end

   -- Control Values loop
   for key, name in pairs(tshControlValues) do
      local value = Call("GetControlValue", name, 0)
      if tshControlValuesFunctions[key] then
         value = tshControlValuesFunctions[key](value)
      end
      data = data..key..": "..value.."\n"
   end

   -- Doors Values loop, doesn't matter which
   local doors = 0
   for key, name in pairs(tshDoorsValues) do
      local value = Call("GetControlValue", name, 0)
      if value ~= 0 then
         doors = value
         break
      end
   end
   data = data.."Doors: "..doors.."\n"

   -- Config values

   if TextAlarm then data = data.."TextAlarm: "..TextAlarm.."\n" end
   if TextVigilAlarm then data = data.."TextVigilAlarm: "..TextVigilAlarm.."\n" end
   if TextEmergency then data = data.."TextEmergency: "..TextEmergency.."\n" end
   if TextStartup then data = data.."TextStartup: "..TextStartup.."\n" end
   if TextDoors then data = data.."TextDoors: "..TextDoors.."\n" end
   if GradientUK then data = data.."GradientUK: "..GradientUK.."\n" end
   
   -- SimulationTime is used to show script is running as clock updates in real time
   local SimulationTime = Call("GetSimulationTime", 0)
   if SimulationTime then data = data.."SimulationTime: "..SimulationTime.."\n" end

   data = data.."\n"

   -- Write data to file
   WriteFile("trainsim-helper-overlay.txt", data)
end

-----------------------------------------------------------
------------  Detections used for Interface  --------------
-----------------------------------------------------------

function DetectInterfaceGerman(DisablePopup) -- Used for Warnings
   if Call("ControlExists", "AFB", 0) == 1 or
      Call("ControlExists", "AFBTargetSpeed", 0) == 1 or
      Call("ControlExists", "PZBFrei", 0) == 1
   then
      if not DisablePopup then DisplayPopup("German Interface") end
      return 1
   end
end

function DetectInterfaceUK(DisablePopup) -- MPH and BAR, should be UK, hopefully, used for Gradient
   if Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      (
         Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 or
         Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 or
         Call("ControlExists", "aAirBrakePipePressureBAR", 0) == 1 or
         Call("ControlExists", "BrakePipePressureBAR", 0) == 1 or
         Call("ControlExists", "aBrakePipePressureBAR", 0) == 1
      )
   then
      if not DisablePopup then DisplayPopup("UK Interface") end
      return 1
   end
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------
-----  Here be dragons, careful with modifications  -------
-----------------------------------------------------------

function WriteFile(name, data)
   local file = io.open("plugins/"..name, "w")
   file:write(data)
   file:flush()
   file:close()
end
