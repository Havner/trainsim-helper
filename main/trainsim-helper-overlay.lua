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

   -- Set UK gradient format. Can be set per loco.
   --GradientUK = 1

   -- Override defaults for custom locos. Detect functions are in the main script.

   if DetectGermanAFB(1) then
      TextVigilAlarm = "Sifa"

   elseif DetectUK(1) then
      GradientUK = 1

   end

   -----------------------------------------------------------
   -----  No need to go below for a basic configuration  -----
   -----------------------------------------------------------

   StaticValues = {}
   ControlValues = {}
   ControlValuesModifiers = {}

   -- Units

   if Call("*:ControlExists", "SpeedometerMPH", 0) == 1 then
      StaticValues["Units"] = "M"
   elseif Call("*:ControlExists", "SpeedometerKPH", 0) == 1 then
      StaticValues["Units"] = "K"
   end

   -- Loco's controls

   if Call("*:ControlExists", "SpeedSet", 0) == 1 then                 -- Class 90 AP
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

   if Call("*:ControlExists", "SteamChestPressureGaugePSI", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestPressureGaugePSI"
   elseif Call("*:ControlExists", "SteamChestGaugePSI", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestGaugePSI"
   elseif Call("*:ControlExists", "SteamChestPressureGauge", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestPressureGauge"
   elseif Call("*:ControlExists", "SteamChestGauge", 0) == 1 then
      ControlValues["SteamChestPressure"] = "SteamChestGauge"
   end

   if Call("*:ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 then
      ControlValues["SteamHeatingPressure"] = "SteamHeatingPressureGaugePSI"
   elseif Call("*:ControlExists", "SteamHeatGauge", 0) == 1 then
      ControlValues["SteamHeatingPressure"] = "SteamHeatGauge"
   end

   if Call("*:ControlExists", "Ammeter", 0) == 1 then
      ControlValues["Ammeter"] = "Ammeter"
   end

   if Call("*:ControlExists", "RPM", 0) == 1 then
      ControlValues["RPM"] = "RPM"
   end

   if Call("*:ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 then
      ControlValues["VacuumBrakePipePressure"] = "VacuumBrakePipePressureINCHES"
   end

   if Call("*:ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 then
      ControlValues["VacuumBrakeChamberPressure"] = "VacuumBrakeChamberPressureINCHES"
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

   if Call("*:ControlExists", "LocoBrakeNeedle", 0) == 1 then  -- Duchess of Sutherland community patch
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

   if Call("*:ControlExists", "MainReservoirPressureBAR", 0) == 1 then
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

   if Call("*:ControlExists", "EqReservoirPressureBAR", 0) == 1 then
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
   
   if Call("*:ControlExists", "AirPumpOnOff", 0) == 1 then
      ControlValues["AirPump"] = "AirPumpOnOff"
   end

   if Call("*:ControlExists", "VirtualLocoBrake", 0) == 1 then
      ControlValues["SteamBrake"] = "VirtualLocoBrake"
   end
   
   if Call("*:ControlExists", "SmallEjectorOnOff", 0) == 1 then
      ControlValues["SmallEjector"] = "SmallEjectorOnOff"
   elseif Call("*:ControlExists", "SmallCompressorOnOff", 0) == 1 then
      ControlValues["SmallEjector"] = "SmallCompressorOnOff"
   end

   if Call("*:ControlExists", "LargeEjectorOnOff", 0) == 1 then
      ControlValues["LargeEjector"] = "LargeEjectorOnOff"
   end

   if Call("*:ControlExists", "SteamHeatingValve", 0) == 1 then
      ControlValues["SteamHeating"] = "SteamHeatingValve"
   elseif Call("*:ControlExists", "SteamHeat", 0) == 1 then
      ControlValues["SteamHeating"] = "SteamHeat"
   elseif Call("*:ControlExists", "SteamHeatingPressureGauge", 0) == 1 then
      ControlValues["SteamHeating"] = "SteamHeatingPressureGauge"
      ControlValuesModifiers["SteamHeating"] = 0.01
   end

   if Call("*:ControlExists", "MasonsValve", 0) == 1 then
      ControlValues["MasonsValve"] = "MasonsValve"
   end

   if Call("*:ControlExists", "Lichtmaschine", 0) == 1 then
      ControlValues["Generator"] = "Lichtmaschine"
   end

   if Call("*:ControlExists", "Lubricator", 0) == 1 then
      ControlValues["Lubricator"] = "Lubricator"
   end

   if Call("*:ControlExists", "LubricatorWarming", 0) == 1 then
      ControlValues["LubricatorWarming"] = "LubricatorWarming"
   end

   if Call("*:ControlExists", "TestCock1", 0) == 1 then
      ControlValues["WaterGaugeTest1"] = "TestCock1"
   end

   if Call("*:ControlExists", "TestCock2", 0) == 1 then
      ControlValues["WaterGaugeTest2"] = "TestCock2"
   end

   if Call("*:ControlExists", "AshpanSprinkler", 0) == 1 then
      ControlValues["AshpanSprinkler"] = "AshpanSprinkler"
   end

   if Call("*:ControlExists", "Flap", 0) == 1 then
      ControlValues["FireholeFlap"] = "Flap"
   end

   if Call("*:ControlExists", "CylinderCock", 0) == 1 then
      ControlValues["CylinderCock"] = "CylinderCock"
   end

   if Call("*:ControlExists", "Damper", 0) == 1 then
      ControlValues["Damper"] = "Damper"
   end

   if Call("*:ControlExists", "WaterScoopRaiseLower", 0) == 1 then
      ControlValues["WaterScoopRaiseLower"] = "WaterScoopRaiseLower"
   end

   -- Steamers (fire-man)

   if Call("*:ControlExists", "WaterGauge", 0) == 1 then
      ControlValues["WaterGauge"] = "WaterGauge"
   end

   if Call("*:ControlExists", "ExhaustInjectorSteamOnOff", 0) == 1 then
      ControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
   end

   if Call("*:ControlExists", "ExhaustInjectorWater", 0) == 1 then
      ControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
   end

   if Call("*:ControlExists", "LiveInjectorSteamOnOff", 0) == 1 then
      ControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
   end

   if Call("*:ControlExists", "LiveInjectorWater", 0) == 1 then
      ControlValues["LiveInjectorWater"] = "LiveInjectorWater"
   end

   if Call("*:ControlExists", "FireboxDoor", 0) == 1 then
      ControlValues["FireboxDoor"] = "FireboxDoor"
   end

   if Call("*:ControlExists", "Stoking", 0) == 1 then
      ControlValues["Stoking"] = "Stoking"
   end

   if Call("*:ControlExists", "Blower", 0) == 1 then
      ControlValues["Blower"] = "Blower"
   end

   if Call("*:ControlExists", "SafetyValve1", 0) == 1 then
      ControlValues["SafetyValve1"] = "SafetyValve1"
   end
   
   if Call("*:ControlExists", "SafetyValve2", 0) == 1 then
      ControlValues["SafetyValve2"] = "SafetyValve2"
   end

   -- Warning values
   
   if Call("*:ControlExists", "AWS", 0) == 1 then
      ControlValues["Sunflower"] = "AWS"
   end

   if Call("*:ControlExists", "AWSWarnCount", 0) == 1 then
      ControlValues["AWS"] = "AWSWarnCount"
   end

   if Call("*:ControlExists", "DSDAlarm", 0) == 1 then
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
   if FireboxMass then data = data.."FireboxMass: "..FireboxMass.."\n" end

   -- Static Values loop
   for key, value in pairs(StaticValues) do
      data = data..key..": "..value.."\n"
   end

   -- Control Values loop
   for key, name in pairs(ControlValues) do
      local value = Call("*:GetControlValue", name, 0)
      if ControlValuesModifiers[key] then
         value = value * ControlValuesModifiers[key]
      end
      data = data..key..": "..value.."\n"
   end

   -- Config values

   if TextAWS then data = data.."TextAWS: "..TextAWS.."\n" end
   if TextVigilAlarm then data = data.."TextVigilAlarm: "..TextVigilAlarm.."\n" end
   if TextEmergency then data = data.."TextEmergency: "..TextEmergency.."\n" end
   if TextStartup then data = data.."TextStartup: "..TextStartup.."\n" end
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
