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
   if SpeedLimit then data = data.."SpeedLimit: "..SpeedLimit.."\n" end

   local NextSpeedLimitType, NextSpeedLimit, NextSpeedLimitDistance = Call("*:GetNextSpeedLimit", 0)
   if NextSpeedLimitType then data = data.."NextSpeedLimitType: "..NextSpeedLimitType.."\n" end
   if NextSpeedLimit then data = data.."NextSpeedLimit: "..NextSpeedLimit.."\n" end
   if NextSpeedLimitDistance then data = data.."NextSpeedLimitDistance: "..NextSpeedLimitDistance.."\n" end

   local Acceleration = Call("*:GetAcceleration")
   if Acceleration then data = data.."Acceleration: "..string.format("%.6f", Acceleration).."\n" end

   local Gradient = Call("*:GetGradient")
   if Gradient then data = data.."Gradient: "..Gradient.."\n" end

   -- Loco's controls

   local TargetSpeed
   if Call("*:ControlExists", "SpeedSet", 0) == 1 then                 -- Class 90 AP
      TargetSpeed = Call("*:GetControlValue", "SpeedSet", 0)
   elseif Call("*:ControlExists", "CruiseControlSpeed", 0) == 1 then   -- Acela
      TargetSpeed = Call("*:GetControlValue", "CruiseControlSpeed", 0)
   elseif Call("*:ControlExists", "VSoll", 0) == 1 then                -- German
      TargetSpeed = Call("*:GetControlValue", "VSoll", 0)
   elseif Call("*:ControlExists", "TargetSpeed", 0) == 1 then          -- Class 375/377
      TargetSpeed = Call("*:GetControlValue", "TargetSpeed", 0)
   end
   if TargetSpeed then data = data.."TargetSpeed: "..TargetSpeed.."\n" end
   
   local Reverser
   if Call("*:ControlExists", "Reverser", 0) == 1 then
      Reverser = Call("*:GetControlValue", "Reverser", 0)
   end
   if Reverser then data = data .."Reverser: "..Reverser.."\n" end

   local GearLever
   if Call("*:ControlExists", "GearLever",0) == 1 then
      GearLever = Call("*:GetControlValue", "GearLever",0)
   end
   if GearLever then data = data.."GearLever: "..GearLever.."\n" end
   
   local Throttle
   if Call("*:ControlExists", "Regulator", 0) == 1 then
      Throttle = Call("*:GetControlValue", "Regulator", 0)
   end
   if Throttle then data = data .."Throttle: "..Throttle.."\n" end
   
   local TrainBrake
   if Call("*:ControlExists", "TrainBrakeControl", 0) == 1 then
      TrainBrake = Call("*:GetControlValue", "TrainBrakeControl", 0)
   end
   if TrainBrake then data = data .."TrainBrake: "..TrainBrake.."\n" end

   local LocoBrake
   if Call("*:ControlExists", "EngineBrakeControl", 0) == 1 then
      LocoBrake = Call("*:GetControlValue", "EngineBrakeControl", 0)
   end
   if LocoBrake then data = data .."LocoBrake: "..LocoBrake.."\n" end
   
   local DynamicBrake
   if Call("*:ControlExists", "DynamicBrake", 0) == 1 then
      DynamicBrake = Call("*:GetControlValue", "DynamicBrake", 0)
   end
   if DynamicBrake then data = data .."DynamicBrake: "..DynamicBrake.."\n" end

   local HandBrake
   if Call("*:ControlExists", "HandBrake", 0) == 1 then
      HandBrake = Call("*:GetControlValue", "HandBrake", 0)
   elseif Call("*:ControlExists", "Handbrake", 0) == 1 then
      HandBrake = Call("*:GetControlValue", "Handbrake", 0)
   end
   if HandBrake then data = data .."HandBrake: "..HandBrake.."\n" end

   -- Loco's indicators
   
   local BoilerPressure
   if Call("*:ControlExists", "BoilerPressureGaugePSI",0) == 1 then
      BoilerPressure = Call("*:GetControlValue", "BoilerPressureGaugePSI",0)
   elseif Call("*:ControlExists", "BoilerPressureGauge",0) == 1 then
      BoilerPressure = Call("*:GetControlValue", "BoilerPressureGauge",0)
   end
   if BoilerPressure then data = data.."BoilerPressure: "..BoilerPressure.."\n" end

   local SteamChestPressure
   if Call("*:ControlExists", "SteamChestPressureGaugePSI",0) == 1 then
      SteamChestPressure = Call("*:GetControlValue", "SteamChestPressureGaugePSI",0)
   elseif Call("*:ControlExists", "SteamChestGaugePSI",0) == 1 then
      SteamChestPressure = Call("*:GetControlValue", "SteamChestGaugePSI",0)
   elseif Call("*:ControlExists", "SteamChestPressureGauge",0) == 1 then
      SteamChestPressure = Call("*:GetControlValue", "SteamChestPressureGauge",0)
   elseif Call("*:ControlExists", "SteamChestGauge",0) == 1 then
      SteamChestPressure = Call("*:GetControlValue", "SteamChestGauge",0)
   end
   if SteamChestPressure then data = data.."SteamChestPressure: "..SteamChestPressure.."\n" end

   local Ammeter   
   if Call("*:ControlExists", "Ammeter", 0) == 1 then
      Ammeter = Call("*:GetControlValue", "Ammeter", 0)
   end
   if Ammeter then data = data.."Ammeter: "..Ammeter.."\n" end

   local RPM
   if Call("*:ControlExists", "RPM", 0) == 1 then
      RPM = Call("*:GetControlValue", "RPM", 0)
   end
   if RPM then data = data.."RPM: "..RPM.."\n" end

   local VacuumBrakePipePressure
   if Call("*:ControlExists", "VacuumBrakePipePressureINCHES",0) == 1 then
      VacuumBrakePipePressure = Call("*:GetControlValue", "VacuumBrakePipePressureINCHES",0)
   end
   if VacuumBrakePipePressure then data = data.."VacuumBrakePipePressure: "..VacuumBrakePipePressure.."\n" end

   local VacuumBrakeChamberPressure
   if Call("*:ControlExists", "VacuumBrakeChamberPressureINCHES",0) == 1 then
      VacuumBrakeChamberPressure = Call("*:GetControlValue", "VacuumBrakeChamberPressureINCHES",0)
   end
   if VacuumBrakeChamberPressure then data = data.."VacuumBrakeChamberPressure: "..VacuumBrakeChamberPressure.."\n" end

   local BrakeUnits

   local TrainBrakeCylinderPressure
   if Call("*:ControlExists", "TrainBrakeCylinderPressureBAR",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "TrainBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressureBAR",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aTrainBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "TrainBrakeCylinderPressurePSI",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "TrainBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressurePSI",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aTrainBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "TrainBrakeCylinderPressure",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "TrainBrakeCylinderPressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aTrainBrakeCylinderPressure",0) == 1 then
      TrainBrakeCylinderPressure = Call("*:GetControlValue", "aTrainBrakeCylinderPressure",0)
      BrakeUnits = "PSI"
   end
   if TrainBrakeCylinderPressure then data = data.."TrainBrakeCylinderPressure: "..TrainBrakeCylinderPressure.."\n" end

   local LocoBrakeCylinderPressure
   if Call("*:ControlExists", "LocoBrakeCylinderPressureBAR",0) == 1 then
      LocoBrakeCylinderPressure = Call("*:GetControlValue", "LocoBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressureBAR",0) == 1 then
      LocoBrakeCylinderPressure = Call("*:GetControlValue", "aLocoBrakeCylinderPressureBAR",0)
      BrakeUnits = "BAR"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressurePSI",0) == 1 then
      LocoBrakeCylinderPressure = Call("*:GetControlValue", "LocoBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressurePSI",0) == 1 then
      LocoBrakeCylinderPressure = Call("*:GetControlValue", "aLocoBrakeCylinderPressurePSI",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "LocoBrakeCylinderPressure",0) == 1 then
      LocoBrakeCylinderPressure = Call("*:GetControlValue", "LocoBrakeCylinderPressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aLocoBrakeCylinderPressure",0) == 1 then
      LocoBrakeCylinderPressure = Call("*:GetControlValue", "aLocoBrakeCylinderPressure",0)
      BrakeUnits = "PSI"
   end
   if LocoBrakeCylinderPressure then data = data.."LocoBrakeCylinderPressure: "..LocoBrakeCylinderPressure.."\n" end


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
   elseif Call("*:ControlExists", "AirBrakePipePressure",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "AirBrakePipePressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aAirBrakePipePressure",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "aAirBrakePipePressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "BrakePipePressure",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "BrakePipePressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aBrakePipePressure",0) == 1 then
      AirBrakePipePressure = Call("*:GetControlValue", "aBrakePipePressure",0)
      BrakeUnits = "PSI"
   end
   if AirBrakePipePressure then data = data.."AirBrakePipePressure: "..AirBrakePipePressure.."\n" end

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
   elseif Call("*:ControlExists", "MainReservoirPressure",0) == 1 then
      MainReservoirPressure = Call("*:GetControlValue", "MainReservoirPressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aMainReservoirPressure",0) == 1 then
      MainReservoirPressure = Call("*:GetControlValue", "aMainReservoirPressure",0)
      BrakeUnits = "PSI"
   end
   if MainReservoirPressure then data = data.."MainReservoirPressure: "..MainReservoirPressure.."\n" end

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
   elseif Call("*:ControlExists", "EqReservoirPressure",0) == 1 then
      EqReservoirPressure = Call("*:GetControlValue", "EqReservoirPressure",0)
      BrakeUnits = "PSI"
   elseif Call("*:ControlExists", "aEqReservoirPressure",0) == 1 then
      EqReservoirPressure = Call("*:GetControlValue", "aEqReservoirPressure",0)
      BrakeUnits = "PSI"
   end
   if EqReservoirPressure then data = data.."EqReservoirPressure: "..EqReservoirPressure.."\n" end

   if BrakeUnits then data = data.."BrakeUnits: "..BrakeUnits.."\n" end

   -- Steamers (driver)
   
   local AirPump
   if Call("*:ControlExists", "AirPumpOnOff",0) == 1 then
      AirPump = Call("*:GetControlValue", "AirPumpOnOff",0)
   end
   if AirPump then data = data.."AirPump: "..AirPump.."\n" end
   
   local SmallEjector
   if Call("*:ControlExists", "SmallCompressorOnOff",0) == 1 then
      SmallEjector = Call("*:GetControlValue", "SmallCompressorOnOff",0)
   elseif Call("*:ControlExists", "SmallEjectorOnOff",0) == 1 then
      SmallEjector = Call("*:GetControlValue", "SmallEjectorOnOff",0)
   end
   if SmallEjector then data = data.."SmallEjector: "..SmallEjector.."\n" end

   local LargeEjector
   if Call("*:ControlExists", "LargeEjectorOnOff",0) == 1 then
      LargeEjector = Call("*:GetControlValue", "LargeEjectorOnOff",0)
   end
   if LargeEjector then data = data.."LargeEjector: "..LargeEjector.."\n" end   

   local SteamHeating
   if Call("*:ControlExists", "SteamHeat",0) == 1 then
      SteamHeating = Call("*:GetControlValue", "SteamHeat",0)
   elseif Call("*:ControlExists", "SteamHeatingPressureGauge",0) == 1 then
      SteamHeating = Call("*:GetControlValue", "SteamHeatingPressureGauge",0) / 100
   end
   if SteamHeating then data = data.."SteamHeating: "..SteamHeating.."\n" end

   local MasonsValve
   if Call("*:ControlExists", "MasonsValve",0) == 1 then
      MasonsValve = Call("*:GetControlValue", "MasonsValve",0)
   end
   if MasonsValve then data = data.."MasonsValve: "..MasonsValve.."\n" end

   local Generator
   if Call("*:ControlExists", "Lichtmaschine",0) == 1 then
      Generator = Call("*:GetControlValue", "Lichtmaschine",0)
   end
   if Generator then data = data.."Generator: "..Generator.."\n" end

   local Lubricator
   if Call("*:ControlExists", "Lubricator",0) == 1 then
      Lubricator = Call("*:GetControlValue", "Lubricator",0)
   end
   if Lubricator then data = data.."Lubricator: "..Lubricator.."\n" end

   local LubricatorWarming
   if Call("*:ControlExists", "LubricatorWarming",0) == 1 then
      LubricatorWarming = Call("*:GetControlValue", "LubricatorWarming",0)
   end
   if LubricatorWarming then data = data.."LubricatorWarming: "..LubricatorWarming.."\n" end

   local WaterGaugeTest1
   if Call("*:ControlExists", "TestCock1",0) == 1 then
      WaterGaugeTest1 = Call("*:GetControlValue", "TestCock1",0)
   end
   if WaterGaugeTest1 then data = data.."WaterGaugeTest1: "..WaterGaugeTest1.."\n" end

   local WaterGaugeTest2
   if Call("*:ControlExists", "TestCock2",0) == 1 then
      WaterGaugeTest2 = Call("*:GetControlValue", "TestCock2",0)
   end
   if WaterGaugeTest2 then data = data.."WaterGaugeTest2: "..WaterGaugeTest2.."\n" end

   local AshpanSprinkler
   if Call("*:ControlExists", "AshpanSprinkler",0) == 1 then
      AshpanSprinkler = Call("*:GetControlValue", "AshpanSprinkler",0)
   end
   if AshpanSprinkler then data = data.."AshpanSprinkler: "..AshpanSprinkler.."\n" end

   local FireholeFlap
   if Call("*:ControlExists", "Flap",0) == 1 then
      FireholeFlap = Call("*:GetControlValue", "Flap",0)
   end
   if FireholeFlap then data = data.."FireholeFlap: "..FireholeFlap.."\n" end

   local CylinderCock
   if Call("*:ControlExists", "CylinderCock",0) == 1 then
      CylinderCock = Call("*:GetControlValue", "CylinderCock",0)
   end
   if CylinderCock then data = data.."CylinderCock: "..CylinderCock.."\n" end

   local Damper
   if Call("*:ControlExists", "Damper",0) == 1 then
      Damper = Call("*:GetControlValue", "Damper",0)
   end
   if Damper then data = data.."Damper: "..Damper.."\n" end

   local WaterScoopRaiseLower
   if Call("*:ControlExists", "WaterScoopRaiseLower",0) == 1 then
      WaterScoopRaiseLower = Call("*:GetControlValue", "WaterScoopRaiseLower",0)
   end
   if WaterScoopRaiseLower then data = data.."WaterScoopRaiseLower: "..WaterScoopRaiseLower.."\n" end

   -- Steamers (fire-man)

   local WaterGauge
   if Call("*:ControlExists", "WaterGauge",0) == 1 then
      WaterGauge = Call("*:GetControlValue", "WaterGauge",0)
   end
   if WaterGauge then data = data.."WaterGauge: "..WaterGauge.."\n" end

   local ExhaustInjectorSteam
   if Call("*:ControlExists", "ExhaustInjectorSteamOnOff",0) == 1 then
      ExhaustInjectorSteam = Call("*:GetControlValue", "ExhaustInjectorSteamOnOff",0)
   end
   if ExhaustInjectorSteam then data = data.."ExhaustInjectorSteam: "..ExhaustInjectorSteam.."\n" end

   local ExhaustInjectorWater
   if Call("*:ControlExists", "ExhaustInjectorWater",0) == 1 then
      ExhaustInjectorWater = Call("*:GetControlValue", "ExhaustInjectorWater",0)
   end
   if ExhaustInjectorWater then data = data.."ExhaustInjectorWater: "..ExhaustInjectorWater.."\n" end

   local LiveInjectorSteam
   if Call("*:ControlExists", "LiveInjectorSteamOnOff",0) == 1 then
      LiveInjectorSteam = Call("*:GetControlValue", "LiveInjectorSteamOnOff",0)
   end
   if LiveInjectorSteam then data = data.."LiveInjectorSteam: "..LiveInjectorSteam.."\n" end

   local LiveInjectorWater
   if Call("*:ControlExists", "LiveInjectorWater",0) == 1 then
      LiveInjectorWater = Call("*:GetControlValue", "LiveInjectorWater",0)
   end
   if LiveInjectorWater then data = data.."LiveInjectorWater: "..LiveInjectorWater.."\n" end

   local FireboxMass
   FireboxMass = Call("*:GetFireboxMass")
   if FireboxMass then data = data.."FireboxMass: "..FireboxMass.."\n" end

   local FireboxDoor
   if Call("*:ControlExists", "FireboxDoor",0) == 1 then
      FireboxDoor = Call("*:GetControlValue", "FireboxDoor",0)
   end
   if FireboxDoor then data = data.."FireboxDoor: "..FireboxDoor.."\n" end

   local Stoking
   if Call("*:ControlExists", "Stoking",0) == 1 then
      Stoking = Call("*:GetControlValue", "Stoking",0)
   end
   if Stoking then data = data.."Stoking: "..Stoking.."\n" end

   local Blower
   if Call("*:ControlExists", "Blower",0) == 1 then
      Blower = Call("*:GetControlValue", "Blower",0)
   end
   if Blower then data = data.."Blower: "..Blower.."\n" end

   local SafetyValve1
   if Call("*:ControlExists", "SafetyValve1",0) == 1 then
      SafetyValve1 = Call("*:GetControlValue", "SafetyValve1",0)
   end
   if SafetyValve1 then data = data.."SafetyValve1: "..SafetyValve1.."\n" end
   
   local SafetyValve2
   if Call("*:ControlExists", "SafetyValve2",0) == 1 then
      SafetyValve2 = Call("*:GetControlValue", "SafetyValve2",0)
   end
   if SafetyValve2 then data = data.."SafetyValve2: "..SafetyValve2.."\n" end

   -- Warning values
   
   local Sunflower
   if Call("*:ControlExists", "AWS", 0) == 1 then
      Sunflower = Call( "*:GetControlValue", "AWS", 0 )
   end
   if Sunflower then data = data.."Sunflower: "..Sunflower.."\n" end

   local AWS
   if Call("*:ControlExists", "AWSWarnCount", 0) == 1 then
      AWS = Call("*:GetControlValue", "AWSWarnCount", 0)
   end
   if AWS then data = data.."AWS: "..AWS.."\n" end

   local VigilAlarm
   if Call("*:ControlExists", "DSDAlarm", 0) == 1 then
      VigilAlarm = Call("*:GetControlValue", "DSDAlarm", 0)
   elseif Call("*:ControlExists", "VigilAlarm", 0) == 1 then
      VigilAlarm = Call("*:GetControlValue", "VigilAlarm", 0)
   elseif Call("*:ControlExists", "DSD", 0) == 1 then
      VigilAlarm = Call("*:GetControlValue", "DSD", 0)
   end
   if VigilAlarm then data = data.."VigilAlarm: "..VigilAlarm.."\n" end

   local EmergencyBrake
   if Call("*:ControlExists", "EmergencyAlarm", 0) == 1 then
      EmergencyBrake = Call("*:GetControlValue", "EmergencyAlarm", 0)
   elseif Call("*:ControlExists", "EmergencyBrake", 0) == 1 then
      EmergencyBrake = Call( "*:GetControlValue", "EmergencyBrake", 0)
   end
   if EmergencyBrake then data = data.."EmergencyBrake: "..EmergencyBrake.."\n" end

   local Startup
   if Call("*:ControlExists", "Startup", 0) == 1 then
      Startup = Call( "*:GetControlValue", "Startup", 0 )
   end
   if Startup then data = data.."Startup: "..Startup.."\n" end

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
