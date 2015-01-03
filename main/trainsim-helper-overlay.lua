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
   TextAWS =         "AWS"
   TextVigilAlarm =  "DSD"
   TextEmergency =   "Emergency"
   TextStartup =     "Engine"
   TextDoors =       "Doors"

   -- Set UK gradient format. Can be set per loco.
   --GradientUK = 1

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   -- Find ControlValues to display
   
   StaticValues = {}
   ControlValues = {}
   DoorsValues = {}
   ControlValuesFunctions = {}
   ControlValuesModifiers = {}

   -- Units

   if Call("*:ControlExists", "SpeedometerMPH", 0) == 1 then
      StaticValues["Units"] = "M"
   elseif Call("*:ControlExists", "SpeedometerKPH", 0) == 1 then
      StaticValues["Units"] = "K"
   end

   -- Loco's controls, those are mostly low-level values so one can see what is happening
   -- under the hood. They can be overriden with high-level ones per loco when needed.

   if Call("*:ControlExists", "AFBTargetSpeed", 0) == 1 then           -- BR442 Talent 2
      ControlValues["TargetSpeed"] = "AFBTargetSpeed"
   elseif Call("*:ControlExists", "SpeedSet", 0) == 1 then             -- Class 90 AP
      ControlValues["TargetSpeed"] = "SpeedSet"
   elseif Call("*:ControlExists", "CruiseControlSpeed", 0) == 1 then   -- Acela
      ControlValues["TargetSpeed"] = "CruiseControlSpeed"
   elseif Call("*:ControlExists", "VSoll", 0) == 1 then                -- German
      ControlValues["TargetSpeed"] = "VSoll"
   elseif Call("*:ControlExists", "TargetSpeed", 0) == 1 then          -- Class 375/377
      ControlValues["TargetSpeed"] = "TargetSpeed"
   end

   if Call("*:ControlExists", "Reverser", 0) == 1 then
      ControlValues["Reverser"] = "Reverser"
   end

   if Call("*:ControlExists", "GearLever",0) == 1 then
      ControlValues["GearLever"] = "GearLever"
   end
   
   if Call("*:ControlExists", "Regulator", 0) == 1 then
      ControlValues["Throttle"] = "Regulator"
   end
   
   if Call("*:ControlExists", "TrainBrakeControl", 0) == 1 then
      ControlValues["TrainBrake"] = "TrainBrakeControl"
   end

   if Call("*:ControlExists", "EngineBrakeControl", 0) == 1 then
      ControlValues["LocoBrake"] = "EngineBrakeControl"
   end
   
   if Call("*:ControlExists", "DynamicBrake", 0) == 1 then
      ControlValues["DynamicBrake"] = "DynamicBrake"
   end

   if Call("*:ControlExists", "HandBrake", 0) == 1 then
      ControlValues["HandBrake"] = "HandBrake"
   elseif Call("*:ControlExists", "Handbrake", 0) == 1 then
      ControlValues["HandBrake"] = "Handbrake"
   end

   -- Loco's indicators
   
   if Call("*:ControlExists", "BoilerPressureGaugePSI",0) == 1 then
      ControlValues["BoilerPressure"] = "BoilerPressureGaugePSI"
   elseif Call("*:ControlExists", "BoilerPressureGauge", 0) == 1 then
      ControlValues["BoilerPressure"] = "BoilerPressureGauge"
   end

   if Call("*:ControlExists", "BackPressure", 0) == 1 then  -- FEF-3
      ControlValues["BackPressure"] = "BackPressure"
   end

   if Call("*:ControlExists", "SteamChestGaugePSI", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestGaugePSI"
   elseif Call("*:ControlExists", "SteamChestGauge", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestGauge"
   elseif Call("*:ControlExists", "SteamChestPressureGaugePSI", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestPressureGaugePSI"
   elseif Call("*:ControlExists", "SteamChestPressureGauge", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestPressureGauge"
   end

   if Call("*:ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 then
      ControlValues["SteamHeatingPressure"] = "SteamHeatingPressureGaugePSI"
   elseif Call("*:ControlExists", "SteamHeatGauge", 0) == 1 then
      ControlValues["SteamHeatingPressure"] = "SteamHeatGauge"
   end

   if Call("*:ControlExists", "SandLevel", 0) == 1 then  -- Q1
      ControlValues["SanderLevel"] = "SandLevel"
      ControlValuesModifiers["SanderLevel"] = 0.001111111111
   end

   if Call("*:ControlExists", "Voltage", 0) == 1 then  -- FEF-3
      ControlValues["Voltage"] = "Voltage"
   end

   if Call("*:ControlExists", "RPM", 0) == 1 then
      ControlValues["RPM"] = "RPM"
   end

   if Call("*:ControlExists", "Ammeter", 0) == 1 then
      ControlValues["Ammeter"] = "Ammeter"
   end

   -- Brake's indicators

   if Call("*:ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 then
      ControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureINCHES"
      StaticValues["VacuumBrakePipeUnits"] = "Inches"
   elseif Call("*:ControlExists", "VacuumBrakePipePressureBAR", 0) == 1 then
      ControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureBAR"
      StaticValues["VacuumBrakePipeUnits"] = "BAR"
   elseif Call("*:ControlExists", "VacuumBrakePipePressurePSI", 0) == 1 then
      ControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressurePSI"
      StaticValues["VacuumBrakePipeUnits"] = "PSI"
   end

   if Call("*:ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 then
      ControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressureBAR"
      StaticValues["TrainBrakeCylinderUnits"] = "BAR"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressureBAR", 0) == 1 then
      ControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressureBAR"
      StaticValues["TrainBrakeCylinderUnits"] = "BAR"
   elseif Call("*:ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 then
      ControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressurePSI"
      StaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressurePSI", 0) == 1 then
      ControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressurePSI"
      StaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "TrainBrakeCylinderPressure", 0) == 1 then
      ControlValues["TrainBrakeCylinderPressure"] = "TrainBrakeCylinderPressure"
      StaticValues["TrainBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressure", 0) == 1 then
      ControlValues["TrainBrakeCylinderPressure"] = "aTrainBrakeCylinderPressure"
      StaticValues["TrainBrakeCylinderUnits"] = "PSI"
   end

   if Call("*:ControlExists", "MyLocoBrakeCylinderPressurePSI", 0) == 1 then  -- FEF-3
      ControlValues["LocoBrakeCylinderPressure"] = "MyLocoBrakeCylinderPressurePSI"
      StaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "LocoBrakeNeedle", 0) == 1 then  -- Duchess of Sutherland community patch
      ControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeNeedle"
      StaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 then
      ControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressureBAR"
      StaticValues["LocoBrakeCylinderUnits"] = "BAR"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressureBAR", 0) == 1 then
      ControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressureBAR"
      StaticValues["LocoBrakeCylinderUnits"] = "BAR"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 then
      ControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressurePSI"
      StaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressurePSI", 0) == 1 then
      ControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressurePSI"
      StaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressure", 0) == 1 then
      ControlValues["LocoBrakeCylinderPressure"] = "LocoBrakeCylinderPressure"
      StaticValues["LocoBrakeCylinderUnits"] = "PSI"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressure", 0) == 1 then
      ControlValues["LocoBrakeCylinderPressure"] = "aLocoBrakeCylinderPressure"
      StaticValues["LocoBrakeCylinderUnits"] = "PSI"
   end

   if Call("*:ControlExists", "AirBrakePipePressureBAR", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "AirBrakePipePressureBAR"
      StaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("*:ControlExists", "aAirBrakePipePressureBAR", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "aAirBrakePipePressureBAR"
      StaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("*:ControlExists", "BrakePipePressureBAR", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "BrakePipePressureBAR"
      StaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("*:ControlExists", "aBrakePipePressureBAR", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "aBrakePipePressureBAR"
      StaticValues["AirBrakePipeUnits"] = "BAR"
   elseif Call("*:ControlExists", "AirBrakePipePressurePSI", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "AirBrakePipePressurePSI"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "aAirBrakePipePressurePSI", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "aAirBrakePipePressurePSI"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "BrakePipePressurePSI", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "BrakePipePressurePSI"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "aBrakePipePressurePSI", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "aBrakePipePressurePSI"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "AirBrakePipePressure", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "AirBrakePipePressure"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "aAirBrakePipePressure", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "aAirBrakePipePressure"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "BrakePipePressure", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "BrakePipePressure"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   elseif Call("*:ControlExists", "aBrakePipePressure", 0) == 1 then
      ControlValues["AirBrakePipePressure"] = "aBrakePipePressure"
      StaticValues["AirBrakePipeUnits"] = "PSI"
   end

   if Call("*:ControlExists", "MRPSI", 0) == 1 then  -- FEF-3
      ControlValues["MainReservoirPressure"] = "MRPSI"
      StaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "MainReservoirPressureBAR", 0) == 1 then
      ControlValues["MainReservoirPressure"] = "MainReservoirPressureBAR"
      StaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("*:ControlExists", "aMainReservoirPressureBAR", 0) == 1 then
      ControlValues["MainReservoirPressure"] = "aMainReservoirPressureBAR"
      StaticValues["MainReservoirUnits"] = "BAR"
   elseif Call("*:ControlExists", "MainReservoirPressurePSI", 0) == 1 then
      ControlValues["MainReservoirPressure"] = "MainReservoirPressurePSI"
      StaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "aMainReservoirPressurePSI", 0) == 1 then
      ControlValues["MainReservoirPressure"] = "aMainReservoirPressurePSI"
      StaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "MainReservoirPressure", 0) == 1 then
      ControlValues["MainReservoirPressure"] = "MainReservoirPressure"
      StaticValues["MainReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "aMainReservoirPressure", 0) == 1 then
      ControlValues["MainReservoirPressure"] = "aMainReservoirPressure"
      StaticValues["MainReservoirUnits"] = "PSI"
   end

   if Call("*:ControlExists", "MyEqReservoirPressurePSI", 0) == 1 then  -- FEF-3
      ControlValues["EqReservoirPressure"] = "MyEqReservoirPressurePSI"
      StaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "EqReservoirPressureBAR", 0) == 1 then
      ControlValues["EqReservoirPressure"] = "EqReservoirPressureBAR"
      StaticValues["EqReservoirUnits"] = "BAR"
   elseif Call("*:ControlExists", "aEqReservoirPressureBAR", 0) == 1 then
      ControlValues["EqReservoirPressure"] = "aEqReservoirPressureBAR"
      StaticValues["EqReservoirUnits"] = "BAR"
   elseif Call("*:ControlExists", "EqReservoirPressurePSI", 0) == 1 then
      ControlValues["EqReservoirPressure"] = "EqReservoirPressurePSI"
      StaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "aEqReservoirPressurePSI", 0) == 1 then
      ControlValues["EqReservoirPressure"] = "aEqReservoirPressurePSI"
      StaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "EqReservoirPressure", 0) == 1 then
      ControlValues["EqReservoirPressure"] = "EqReservoirPressure"
      StaticValues["EqReservoirUnits"] = "PSI"
   elseif Call("*:ControlExists", "aEqReservoirPressure", 0) == 1 then
      ControlValues["EqReservoirPressure"] = "aEqReservoirPressure"
      StaticValues["EqReservoirUnits"] = "PSI"
   end

   -- Steamers (driver)
   
   if Call("*:ControlExists", "BlowOffCockShutOffR", 0) == 1 then  -- FEF-3
      ControlValues["BlowOffCockShutOffRight"] = "BlowOffCockShutOffR"
   end

   if Call("*:ControlExists", "Dynamo", 0) == 1 then  -- FEF-3
      ControlValues["Dynamo"] = "Dynamo"
   end
   
   if Call("*:ControlExists", "CompressorThrottle", 0) == 1 then  -- FEF-3
      ControlValues["AirPump"] = "CompressorThrottle"
   elseif Call("*:ControlExists", "SteamShutOffL", 0) == 1 then  -- Q1
      ControlValues["AirPump"] = "SteamShutOffL"
   elseif Call("*:ControlExists", "AirPumpOnOff", 0) == 1 then
      ControlValues["AirPump"] = "AirPumpOnOff"
   end

   if Call("*:ControlExists", "SteamHeatShutOff", 0) == 1 then  -- Q1
      ControlValues["SteamHeatingShutOff"] = "SteamHeatShutOff"
   end

   if Call("*:ControlExists", "SteamHeatingValve", 0) == 1 then
      ControlValues["SteamHeating"] = "SteamHeatingValve"
   elseif Call("*:ControlExists", "SteamHeat", 0) == 1 then
      ControlValues["SteamHeating"] = "SteamHeat"
   end

   if Call("*:ControlExists", "MasonsValve", 0) == 1 then
      ControlValues["MasonsValve"] = "MasonsValve"
   end

   if Call("*:ControlExists", "SteamShutOffR", 0) == 1 then  -- Q1
      ControlValues["Lubricator"] = "SteamShutOffR"
   elseif Call("*:ControlExists", "Lubricator", 0) == 1 then
      ControlValues["Lubricator"] = "Lubricator"
   end

   if Call("*:ControlExists", "LubricatorWarming", 0) == 1 then
      ControlValues["LubricatorWarming"] = "LubricatorWarming"
   end

   if Call("*:ControlExists", "SmallEjectorOnOff", 0) == 1 then
      ControlValues["SmallEjector"] = "SmallEjectorOnOff"
   elseif Call("*:ControlExists", "SmallCompressorOnOff", 0) == 1 then
      ControlValues["SmallEjector"] = "SmallCompressorOnOff"
   end

   if Call("*:ControlExists", "LargeEjectorOnOff", 0) == 1 then
      ControlValues["LargeEjector"] = "LargeEjectorOnOff"
   end

   if Call("*:ControlExists", "SanderSteam", 0) == 1 then  -- Q1
      ControlValues["SanderSteam"] = "SanderSteam"
   end

   if Call("*:ControlExists", "Sander", 0) == 1 then
      ControlValues["Sander"] = "Sander"
   end

   if Call("*:ControlExists", "Sander2", 0) == 1 then  -- FEF-3
      ControlValues["SanderRear"] = "Sander2"
   end

   if Call("*:ControlExists", "SandCaps", 0) == 1 then  -- Q1
      ControlValues["SanderCaps"] = "SandCaps"
   end

   if Call("*:ControlExists", "SandFill", 0) == 1 then  -- Q1
      ControlValues["SanderFill"] = "SandFill"
   end

   if Call("*:ControlExists", "AshpanSprinkler", 0) == 1 then
      ControlValues["AshpanSprinkler"] = "AshpanSprinkler"
   end

   if Call("*:ControlExists", "CylinderCockMaster", 0) == 1 then  -- FEF-3
      ControlValues["CylinderCockMaster"] = "CylinderCockMaster"
   end

   if Call("*:ControlExists", "CylinderCock", 0) == 1 then
      ControlValues["CylinderCock"] = "CylinderCock"
   end

   if Call("*:ControlExists", "WaterScoopRaiseLower", 0) == 1 then
      ControlValues["WaterScoopRaiseLower"] = "WaterScoopRaiseLower"
   end

   -- Steamers (fire-man)

   if Call("*:ControlExists", "BlowOffCockShutOffL", 0) == 1 then  -- FEF-3
      ControlValues["BlowOffCockShutOffLeft"] = "BlowOffCockShutOffL"
   end

   if Call("*:ControlExists", "FWPumpShutOff", 0) == 1 then  -- FEF-3
      ControlValues["FeedWaterPumpShutOff"] = "FWPumpShutOff"
   end

   if Call("*:ControlExists", "ControlValve", 0) == 1 then  -- FEF-3
      ControlValues["ControlValve"] = "ControlValve"
   end
   
   if Call("*:ControlExists", "Tender_WaterLeverR", 0) == 1 then  -- Q1
      ControlValues["ExhaustInjectorShutOff"] = "Tender_WaterLeverR"
   end

   if Call("*:ControlExists", "Tender_WaterLeverL", 0) == 1 then  -- Q1
      ControlValues["LiveInjectorShutOff"] = "Tender_WaterLeverL"
   end

   if Call("*:ControlExists", "Tender_WaterShutOff", 0) == 1 then  -- Q1
      ControlValues["TenderWaterShutOff"] = "Tender_WaterShutOff"
   end

   -- FireboxMass from the functions

   if Call("*:ControlExists", "AtomizerPressure", 0) == 1 then  -- FEF-3
      ControlValues["AtomizerPressure"] = "AtomizerPressure"
   end

   if Call("*:ControlExists", "TankTemperature", 0) == 1 then  -- FEF-3
      ControlValues["TankTemperature"] = "TankTemperature"
   end   

   if Call("*:ControlExists", "FireboxDoor", 0) == 1 then
      ControlValues["FireboxDoor"] = "FireboxDoor"
   end

   if Call("*:ControlExists", "Stoking", 0) == 1 then
      ControlValues["Stoking"] = "Stoking"
   end

   if Call("*:ControlExists", "Firing", 0) == 1 then  -- FEF-3
      ControlValues["OilRegulator"] = "Firing"
   end

   if Call("*:ControlExists", "BlowerControlValve", 0) == 1 then  -- FEF-3
      ControlValues["Blower"] = "BlowerControlValve"
   elseif Call("*:ControlExists", "Blower", 0) == 1 then
      ControlValues["Blower"] = "Blower"
   end

   if Call("*:ControlExists", "TankHeater", 0) == 1 then  -- FEF-3
      ControlValues["TankHeater"] = "TankHeater"
   end

   if Call("*:ControlExists", "Atomizer", 0) == 1 then  -- FEF-3
      ControlValues["Atomizer"] = "Atomizer"
   end

   if Call("*:ControlExists", "FiredoorDamper", 0) == 1 then  -- FEF-3
      ControlValues["Damper"] = "FiredoorDamper"
   elseif Call("*:ControlExists", "Damper", 0) == 1 then
      ControlValues["Damper"] = "Damper"
   end

   if Call("*:ControlExists", "DamperLeft", 0) == 1 then  -- J94
      ControlValues["DamperLeft"] = "DamperLeft"
   end

   if Call("*:ControlExists", "DamperRight", 0) == 1 then  -- J94
      ControlValues["DamperRight"] = "DamperRight"
   end

   if Call("*:ControlExists", "DamperFront", 0) == 1 then  -- Q1
      ControlValues["DamperFront"] = "DamperFront"
   end

   if Call("*:ControlExists", "DamperRear", 0) == 1 then  -- Q1
      ControlValues["DamperRear"] = "DamperRear"
   end

   if Call("*:ControlExists", "WaterGauge", 0) == 1 then
      ControlValues["WaterGauge"] = "WaterGauge"
   end

   if Call("*:ControlExists", "FWHpressure", 0) == 1 then  -- FEF-3
      ControlValues["FeedWaterPressure"] = "FWHpressure"
   end

   if Call("*:ControlExists", "FWPump", 0) == 1 then  -- FEF-3
      ControlValues["FeedWaterPump"] = "FWPump"
   end

   if Call("*:ControlExists", "ExhaustInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      ControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamLever"
   elseif Call("*:ControlExists", "ExhaustInjectorSteamOnOff", 0) == 1 then
      ControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
   end

   if Call("*:ControlExists", "ExhaustInjectorWaterLever", 0) == 1 then  -- 14xx
      ControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWaterLever"
   elseif Call("*:ControlExists", "ExhaustInjectorWaterFineControl", 0) == 1 then  -- Q1
      ControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWaterFineControl"
   elseif Call("*:ControlExists", "ExhaustInjectorWater", 0) == 1 then
      ControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
   end

   if Call("*:ControlExists", "InjectorLeverR", 0) == 1 then  -- FEF-3
      ControlValues["LiveInjectorSteam"] = "InjectorLeverR"
   elseif Call("*:ControlExists", "LiveInjectorSteamLever", 0) == 1 then  -- 14xx, Q1
      ControlValues["LiveInjectorSteam"] = "LiveInjectorSteamLever"
   elseif Call("*:ControlExists", "LiveInjectorSteamOnOff", 0) == 1 then
      ControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
   end

   if Call("*:ControlExists", "LiveInjectorWaterLever", 0) == 1 then  -- 14xx
      ControlValues["LiveInjectorWater"] = "LiveInjectorWaterLever"
   elseif Call("*:ControlExists", "LiveInjectorWaterFineControl", 0) == 1 then  -- Q1
      ControlValues["LiveInjectorWater"] = "LiveInjectorWaterFineControl"
   elseif Call("*:ControlExists", "LiveInjectorWater", 0) == 1 then
      ControlValues["LiveInjectorWater"] = "LiveInjectorWater"
   end

   if Call("*:ControlExists", "SafetyValveEngineer", 0) == 1 then  -- FEF-3
      ControlValues["SafetyValve1"] = "SafetyValveEngineer"
   elseif Call("*:ControlExists", "SafetyValve1", 0) == 1 then
      ControlValues["SafetyValve1"] = "SafetyValve1"
   end
   
   if Call("*:ControlExists", "SafetyValveFireman", 0) == 1 then  -- FEF-3
      ControlValues["SafetyValve2"] = "SafetyValveFireman"
   elseif Call("*:ControlExists", "SafetyValve2", 0) == 1 then
      ControlValues["SafetyValve2"] = "SafetyValve2"
   end

   if Call("*:ControlExists", "SafetyValveUnmuffled", 0) == 1 then  -- FEF-3
      ControlValues["SafetyValve3"] = "SafetyValveUnmuffled"
   end

   -- Warning values
   
   if Call("*:ControlExists", "AWS", 0) == 1 then
      ControlValues["Sunflower"] = "AWS"
   end

   if Call("*:ControlExists", "AlerterCountdown", 0) == 1 then
      ControlValues["AWS"] = "AlerterCountdown"
   elseif Call("*:ControlExists", "AWSWarnCount", 0) == 1 then
      ControlValues["AWS"] = "AWSWarnCount"
   end

   if Call("*:ControlExists", "SifaLampe", 0) == 1 then  -- BR420
      ControlValues["VigilAlarm"] = "SifaLampe"
   elseif Call("*:ControlExists", "SiFaWarning", 0) == 1 then  -- BR442
      ControlValues["VigilAlarm"] = "SiFaWarning"
   elseif Call("*:ControlExists", "DSDAlarm", 0) == 1 then
      ControlValues["VigilAlarm"] = "DSDAlarm"
   elseif Call("*:ControlExists", "VigilAlarm", 0) == 1 then
      ControlValues["VigilAlarm"] = "VigilAlarm"
   elseif Call("*:ControlExists", "DSD", 0) == 1 then
      ControlValues["VigilAlarm"] = "DSD"
   end

   if Call("*:ControlExists", "BrakeDemandLamp", 0) == 1 then
      ControlValues["EmergencyBrake"] = "BrakeDemandLamp"
   elseif Call("*:ControlExists", "EmergencyAlarm", 0) == 1 then
      ControlValues["EmergencyBrake"] = "EmergencyAlarm"
   elseif Call("*:ControlExists", "EmergencyBrake", 0) == 1 then
      ControlValues["EmergencyBrake"] = "EmergencyBrake"
   end

   if Call("*:ControlExists", "Startup", 0) == 1 then
      ControlValues["Startup"] = "Startup"
   end

   -- Doors Values

   if Call("*:ControlExists", "DoorsOpenClose", 0) == 1 then
      DoorsValues["Doors"] = "DoorsOpenClose"
   end

   if Call("*:ControlExists", "DoorsOpenCloseLeft", 0) == 1 then
      DoorsValues["DoorsLeft"] = "DoorsOpenCloseLeft"
   end

   if Call("*:ControlExists", "DoorsOpenCloseRight", 0) == 1 then
      DoorsValues["DoorsRight"] = "DoorsOpenCloseRight"
   end

   -- Override defaults for custom locos. Detect functions are in the main script.
   -- Sometimes I have to do this as a loco might have a control value that is
   -- detected but it should not be displayed. E.g. it's internal to the
   -- implementation or is basically useless for this loco.

   if DetectSteam(true) then
      -- Some steamers use regulator for steam chest pressure, display lever
      if Call("*:ControlExists", "VirtualThrottle", 0) == 1 then
         ControlValues["Throttle"] = "VirtualThrottle"
      end
   end

   if DetectGermanAFB(true) then
      TextVigilAlarm = "Sifa"
   end
   
   if DetectGenericUK(true) then
      GradientUK = 1
   end

   -- Things common for the ADV and HUD versions of FEF-3
   if DetectFEF3_ADV_Smokebox(true) or DetectFEF3_HUD_Smokebox(true) then
      -- Hide the internal values
      ControlValues["SteamChestPressure"] = nil
      ControlValues["TrainBrakeCylinderPressure"] = nil
      ControlValues["FireboxDoor"] = nil
      ControlValues["Stoking"] = nil
      ControlValues["ExhaustInjectorSteam"] = nil
      ControlValues["ExhaustInjectorWater"] = nil

      -- If you want safety valves comment out the following 3 lines
      ControlValues["SafetyValve1"] = nil
      ControlValues["SafetyValve2"] = nil
      ControlValues["SafetyValve3"] = nil

      -- Firebox is 0-5%, make it full range (0-100%)
      ControlValuesModifiers["FireboxMass"] = 20
      -- BackPressure needs to be converted
      ControlValuesFunctions["BackPressure"] =
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
      ControlValues["Reverser"] = "MyReverser"
      ControlValues["Throttle"] = "RegulatorLever"
      ControlValues["TrainBrake"] = "TrainBrakeHandle"
      ControlValues["LocoBrake"] = "MyEngineBrakeControl"

   elseif DetectJ94_ADV_MeshTools(true) then
      -- Loco/Steam Brake lever, internal should be hidden
      ControlValues["LocoBrake"] = "VirtualLocoBrake"
      -- It has left and right dampers, if you want to see effective damper comment out
      ControlValues["Damper"] = nil

   elseif DetectBulleidQ1_VictoryWorks(true) then
      -- It has front and rear dampers, if you want to see effective damper comment out
      ControlValues["Damper"] = nil
      -- Not functional, hide
      ControlValues["WaterScoopRaiseLower"] = nil

      -- Uncomment all if you want to display simple water controls
      --ControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
      --ControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
      --ControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
      --ControlValues["LiveInjectorWater"] = "LiveInjectorWater"
      --ControlValues["ExhaustInjectorShutOff"] = nil
      --ControlValues["LiveInjectorShutOff"] = nil
      --ControlValues["TenderWaterShutOff"] = nil

   elseif DetectGWRRailmotor_VictoryWorks(true) or DetectGWRRailmotorBoogie_VictoryWorks(true) then
      -- Not functional, hide
      ControlValues["SmallEjector"] = nil

   elseif Detect14xx_VictoryWorks(true) then
      -- It has front and rear dampers, if you want to see effective damper comment out
      ControlValues["Damper"] = nil

   elseif DetectClass37_Thomson(true) or DetectClass50_MeshTools(true) then
      -- Throttle is delayed significantly, show lever
      ControlValues["Throttle"] = "VirtualThrottle"

   elseif DetectBR420_Influenzo(true) then
      TextAWS = "PZB"
      TextVigilAlarm = "Sifa"

   elseif DetectBR442Talent2(true) then
      -- LocoBrake is actually a TrainBrake, reflect that
      ControlValues["TrainBrake"] = "EngineBrakeControl"
      ControlValues["LocoBrake"] = nil
      -- Not functional, hide
      ControlValues["Sunflower"] = nil
      ControlValues["LocoBrakeCylinderPressure"] = nil

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

   local Speed = Call("*:GetSpeed")
   if Speed then data = data.."Speed: "..Speed.."\n" end

   local SpeedLimit = Call("*:GetCurrentSpeedLimit")
   if SpeedLimit then data = data.."SpeedLimit: "..SpeedLimit.."\n" end

   local NextSpeedLimitType, NextSpeedLimit, NextSpeedLimitDistance = Call("*:GetNextSpeedLimit", 0)
   if NextSpeedLimitType then data = data.."NextSpeedLimitType: "..NextSpeedLimitType.."\n" end
   if NextSpeedLimit then data = data.."NextSpeedLimit: "..NextSpeedLimit.."\n" end
   if NextSpeedLimitDistance then data = data.."NextSpeedLimitDistance: "..NextSpeedLimitDistance.."\n" end

   local NextSpeedLimitBackType, NextSpeedLimitBack, NextSpeedLimitBackDistance = Call("*:GetNextSpeedLimit", 1)
   if NextSpeedLimitBackType then data = data.."NextSpeedLimitBackType: "..NextSpeedLimitBackType.."\n" end
   if NextSpeedLimitBack then data = data.."NextSpeedLimitBack: "..NextSpeedLimitBack.."\n" end
   if NextSpeedLimitBackDistance then data = data.."NextSpeedLimitBackDistance: "..NextSpeedLimitBackDistance.."\n" end

   local Acceleration = Call("*:GetAcceleration")
   if Acceleration then data = data.."Acceleration: "..string.format("%.6f", Acceleration).."\n" end

   local Gradient = Call("*:GetGradient")
   if Gradient then data = data.."Gradient: "..Gradient.."\n" end

   local FireboxMass = Call("*:GetFireboxMass")
   if FireboxMass and ControlValuesModifiers["FireboxMass"] then FireboxMass = FireboxMass * ControlValuesModifiers["FireboxMass"] end
   if FireboxMass then data = data.."FireboxMass: "..FireboxMass.."\n" end

   -- Static Values loop
   for key, value in pairs(StaticValues) do
      data = data..key..": "..value.."\n"
   end

   -- Control Values loop
   for key, name in pairs(ControlValues) do
      local value = Call("*:GetControlValue", name, 0)
      if ControlValuesFunctions[key] then
         value = ControlValuesFunctions[key](value)
      elseif ControlValuesModifiers[key] then
         value = value * ControlValuesModifiers[key]
      end
      data = data..key..": "..value.."\n"
   end

   -- Doors Values loop, doesn't matter which
   local doors = 0
   for key, name in pairs(DoorsValues) do
      local value = Call("*:GetControlValue", name, 0)
      if value ~= 0 then
         doors = value
         break
      end
   end
   data = data.."Doors: "..doors.."\n"

   -- Config values

   if TextAWS then data = data.."TextAWS: "..TextAWS.."\n" end
   if TextVigilAlarm then data = data.."TextVigilAlarm: "..TextVigilAlarm.."\n" end
   if TextEmergency then data = data.."TextEmergency: "..TextEmergency.."\n" end
   if TextStartup then data = data.."TextStartup: "..TextStartup.."\n" end
   if TextDoors then data = data.."TextDoors: "..TextDoors.."\n" end
   if GradientUK then data = data.."GradientUK: "..GradientUK.."\n" end
   
   -- SimulationTime is used to show script is running as clock updates in real time
   local SimulationTime = Call("*:GetSimulationTime", 0)
   if SimulationTime then data = data.."SimulationTime: "..SimulationTime.."\n" end

   data = data.."\n"

   -- Write data to file
   WriteFile("trainsim-helper-overlay.txt", data)
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------
-----  Here be dragons, careful with modifications  -------
-----------------------------------------------------------

function TryGetControlValue(control)
   if Call("*:ControlExists", control, 0) == 1 then
      return Call("*:GetControlValue", control, 0)
   end
end

function WriteFile(name, data)
   local file = io.open("plugins/"..name, "w")
   file:write(data)
   file:flush()
   file:close()
end
