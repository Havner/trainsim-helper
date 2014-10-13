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

   if DetectGermanAFB() then
      TextVigilAlarm = "Sifa"

   elseif DetectUK() then
      GradientUK = 1

   end

   -- set at the very end to be a mark whether the configuration has been successful
   OverlayConfigured = 1
end

-----------------------------------------------------------
----------------  Main overlay function  ------------------
-----------------------------------------------------------

function GetOverlayData()
   local data = "" -- data storage for data to write to output file
   local FloatFormat = "%.6f"

   -- SIM values

   local Clock = SysCall("ScenarioManager:GetTimeOfDay")
   if Clock then data = data.."Clock: "..string.format(FloatFormat,Clock).."\n" end

   local Units
   if Call("*:ControlExists", "SpeedometerMPH", 0) == 1 then
      Units = "M"
   elseif Call("*:ControlExists", "SpeedometerKPH", 0) == 1 then
      Units = "K"
   end
   if Units then data = data.."Units: "..Units.."\n" end

   local Speed = Call("*:GetSpeed")
   if Speed then data = data.."Speed: "..Speed.."\n" end

   local SpeedLimit = Call("*:GetCurrentSpeedLimit")
   if SpeedLimit then data = data.."SpeedLimit: "..string.format(FloatFormat,SpeedLimit).."\n" end

   local NextSpeedLimitType, NextSpeedLimit, NextSpeedLimitDistance = Call("*:GetNextSpeedLimit", 0)
   if NextSpeedLimitType then data = data.."NextSpeedLimitType: "..NextSpeedLimitType.."\n" end
   if NextSpeedLimit then data = data.."NextSpeedLimit: "..string.format(FloatFormat,NextSpeedLimit).."\n" end
   if NextSpeedLimitDistance then data = data.."NextSpeedLimitDistance: "..string.format(FloatFormat,NextSpeedLimitDistance).."\n" end

   local Acceleration = Call("*:GetAcceleration")
   if Acceleration then data = data.."Acceleration: "..string.format(FloatFormat,Acceleration).."\n" end

   local Gradient = Call("*:GetGradient")
   if Gradient then data = data.."Gradient: "..string.format(FloatFormat,Gradient).."\n" end

   -- Loco's values

   local TargetSpeed
   if Call("*:ControlExists", "TargetSpeed", 0) == 1 then
      TargetSpeed = Call("*:GetControlValue", "TargetSpeed", 0)
   elseif Call("*:ControlExists", "TargetSpeed100", 0) == 1 or
      Call("*:ControlExists", "TargetSpeed10", 0) == 1 or
      Call("*:ControlExists", "TargetSpeed1", 0) == 1
   then
      local ts = {}
      ts[100] = TryGetControlValue("TargetSpeed100")
      ts[10] = TryGetControlValue("TargetSpeed10")
      ts[1] = TryGetControlValue("TargetSpeed1")
      TargetSpeed = 0
      if ts[100] and ts[100] > 0 then
	 TargetSpeed = TargetSpeed + ts[100] * 100
      end
      if ts[10] and ts[10] > 0 then
	 TargetSpeed = TargetSpeed + ts[10] * 10
      end
      if ts[1] and ts[1] > 0 then
	 TargetSpeed = TargetSpeed + ts[1]
      end
   end
   if TargetSpeed then data = data.."TargetSpeed: "..string.format(FloatFormat,TargetSpeed).."\n" end
   
   local Reverser
   if Call("*:ControlExists", "Reverser", 0) == 1 then
      Reverser = Call("*:GetControlValue", "Reverser", 0)
   end
   if Reverser then data = data .."Reverser: "..string.format(FloatFormat,Reverser).."\n" end

   local GearLever
   if Call("*:ControlExists", "GearLever",0) == 1 then
      GearLever = Call("*:GetControlValue", "GearLever",0)
   end
   if GearLever then data = data.."GearLever: "..string.format(FloatFormat,GearLever).."\n" end
   
   local Throttle
   if Call("*:ControlExists", "Regulator", 0) == 1 then
      Throttle = Call("*:GetControlValue", "Regulator", 0)
   end
   if Throttle then data = data .."Throttle: "..string.format(FloatFormat,Throttle).."\n" end
   
   local TrainBrake
   if Call("*:ControlExists", "TrainBrakeControl", 0) == 1 then
      TrainBrake = Call("*:GetControlValue", "TrainBrakeControl", 0)
   end
   if TrainBrake then data = data .."TrainBrake: "..string.format(FloatFormat,TrainBrake).."\n" end

   local LocoBrake
   if Call("*:ControlExists", "EngineBrakeControl", 0) == 1 then
      LocoBrake = Call("*:GetControlValue", "EngineBrakeControl", 0)
   end
   if LocoBrake then data = data .."LocoBrake: "..string.format(FloatFormat,LocoBrake).."\n" end
   
   local DynamicBrake
   if Call("*:ControlExists", "DynamicBrake", 0) == 1 then
      DynamicBrake = Call("*:GetControlValue", "DynamicBrake", 0)
   end
   if DynamicBrake then data = data .."DynamicBrake: "..string.format(FloatFormat,DynamicBrake).."\n" end

   local Ammeter   
   if Call("*:ControlExists", "Ammeter", 0) == 1 then
      Ammeter = Call("*:GetControlValue", "Ammeter", 0)
   end
   if Ammeter then data = data.."Ammeter: "..string.format(FloatFormat,Ammeter).."\n" end

   local RPM
   if Call("*:ControlExists", "RPM", 0) == 1 then
      RPM = Call("*:GetControlValue", "RPM", 0)
   end
   if RPM then data = data.."RPM: "..string.format(FloatFormat,RPM).."\n" end

   local VacuumBrakePipePressure
   if Call("*:ControlExists", "VacuumBrakePipePressureINCHES",0) == 1 then
      VacuumBrakePipePressure = Call("*:GetControlValue", "VacuumBrakePipePressureINCHES",0)
   end
   if VacuumBrakePipePressure then data = data.."VacuumBrakePipePressure: "..string.format(FloatFormat,VacuumBrakePipePressure).."\n" end

   local BrakeUnits

   local TrainBrakeCylinderPressure
   if Call("*:ControlExists", "TrainBrakeCylinderPressureBAR",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "TrainBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressureBAR",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aTrainBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressureBAR",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "LocoBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressureBAR",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aLocoBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "TrainBrakeCylinderPressurePSI",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "TrainBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressurePSI",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aTrainBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressurePSI",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "LocoBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressurePSI",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aLocoBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   end
   if TrainBrakeCylinderPressure then data = data.."TrainBrakeCylinderPressure: "..string.format(FloatFormat,TrainBrakeCylinderPressure).."\n" end

   local AirBrakePipePressure
   if Call("*:ControlExists", "AirBrakePipePressureBAR",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "AirBrakePipePressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aAirBrakePipePressureBAR",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "aAirBrakePipePressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "BrakePipePressureBAR",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "BrakePipePressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aBrakePipePressureBAR",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "aBrakePipePressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "AirBrakePipePressurePSI",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "AirBrakePipePressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aAirBrakePipePressurePSI",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "aAirBrakePipePressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "BrakePipePressurePSI",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "BrakePipePressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aBrakePipePressurePSI",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "aBrakePipePressurePSI",0)
      BrakeUnits = "PSI"
   end
   if AirBrakePipePressure then data = data.."AirBrakePipePressure: "..string.format(FloatFormat,AirBrakePipePressure).."\n" end

   local MainReservoirPressure
   if Call("*:ControlExists", "MainReservoirPressureBAR",0) == 1 then
      MainReservoirPressure = Call("*:GetControlValue", "MainReservoirPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aMainReservoirPressureBAR",0) == 1 then
      MainReservoirPressure = Call("*:GetControlValue", "aMainReservoirPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "MainReservoirPressurePSI",0) == 1 then
      MainReservoirPressure = Call("*:GetControlValue", "MainReservoirPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aMainReservoirPressurePSI",0) == 1 then
      MainReservoirPressure = Call("*:GetControlValue", "aMainReservoirPressurePSI",0)
      BrakeUnits = "PSI"
   end
   if MainReservoirPressure then data = data.."MainReservoirPressure: "..string.format(FloatFormat,MainReservoirPressure).."\n" end

   local EqReservoirPressure
   if Call("*:ControlExists", "EqReservoirPressureBAR",0) == 1 then
      EqReservoirPressure = Call("*:GetControlValue", "EqReservoirPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aEqReservoirPressureBAR",0) == 1 then
      EqReservoirPressure = Call("*:GetControlValue", "aEqReservoirPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "EqReservoirPressurePSI",0) == 1 then
      EqReservoirPressure = Call("*:GetControlValue", "EqReservoirPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aEqReservoirPressurePSI",0) == 1 then
      EqReservoirPressure = Call("*:GetControlValue", "aEqReservoirPressurePSI",0)
      BrakeUnits = "PSI"
   end
   if EqReservoirPressure then data = data.."EqReservoirPressure: "..string.format(FloatFormat,EqReservoirPressure).."\n" end

   if BrakeUnits then data = data.."BrakeUnits: "..BrakeUnits.."\n" end

   local Sunflower
   if Call("*:ControlExists", "AWS", 0) == 1 then
      Sunflower = Call( "*:GetControlValue", "AWS", 0 )
   end
   if Sunflower then data = data.."Sunflower: "..string.format(FloatFormat,Sunflower).."\n" end

   local AWS
   if Call("*:ControlExists", "AWSWarnCount", 0) == 1 then
      AWS = Call("*:GetControlValue", "AWSWarnCount", 0)
   end
   if AWS then data = data.."AWS: "..string.format(FloatFormat,AWS).."\n" end

   local VigilAlarm
   if Call("*:ControlExists", "DSDAlarm", 0) == 1 then
      VigilAlarm = Call("*:GetControlValue", "DSDAlarm", 0)
   elseif Call("*:ControlExists", "VigilAlarm", 0) == 1 then
      VigilAlarm = Call("*:GetControlValue", "VigilAlarm", 0)
   end
   if VigilAlarm then data = data.."VigilAlarm: "..string.format(FloatFormat,VigilAlarm).."\n" end

   local EmergencyBrake
   if Call("*:ControlExists", "EmergencyAlarm", 0) == 1 then
      EmergencyBrake = Call("*:GetControlValue", "EmergencyAlarm", 0)
   elseif Call("*:ControlExists", "EmergencyBrake", 0) == 1 then
      EmergencyBrake = Call( "*:GetControlValue", "EmergencyBrake", 0)
   end
   if EmergencyBrake then data = data.."EmergencyBrake: "..string.format(FloatFormat,EmergencyBrake).."\n" end

   local Startup
   if Call("*:ControlExists", "Startup", 0) == 1 then
      Startup = Call( "*:GetControlValue", "Startup", 0 )
   end
   if Startup then data = data.."Startup: "..string.format(FloatFormat,Startup).."\n" end

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
