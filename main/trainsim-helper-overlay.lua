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

   tshStaticValues["Units"] = FindOverlayUnits()

   -- Loco's controls

   tshControlValues["TargetSpeed"]      = FindOverlayTargetSpeed()
   tshControlValues["Reverser"]         = FindOverlayReverser()
   tshControlValues["Gear"]             = FindOverlayGear()
   tshControlValues["Power"]            = FindOverlayPower()
   -- Shamelessly use Joystick configuration, it should be adapted per loco already
   tshControlValues["CombinedThrottle"] = tshControl["CombinedThrottle"]
   tshControlValues["Throttle"]         = tshControl["Throttle"]
   tshControlValues["TrainBrake"]       = tshControl["TrainBrake"]
   tshControlValues["LocoBrake"]        = tshControl["LocoBrake"]
   tshControlValues["DynamicBrake"]     = tshControl["DynamicBrake"]
   tshControlValues["HandBrake"]        = tshControl["HandBrake"]

   -- Loco's indicators

   tshControlValues["BoilerPressure"]       = FindOverlayBoilerPressure()
   tshControlValues["BackPressure"]         = FindOverlayBackPressure()
   tshControlValues["SteamChestPressure"]   = FindOverlaySteamChestPressure()
   tshControlValues["SteamHeatingPressure"] = FindOverlaySteamHeatingPressure()
   tshControlValues["Sandbox"]              = FindOverlaySandbox()
   tshControlValues["SandboxRear"]          = FindOverlaySandboxRear()
   tshControlValues["Voltage"]              = FindOverlayVoltage()
   tshControlValues["RPM"]                  = FindOverlayRPM()
   tshControlValues["Ammeter"]              = FindOverlayAmmeter()

   -- Brake's indicators

   tshControlValues["VacuumBrakePipePressure"],
   tshStaticValues["VacuumBrakePipeUnits"]         = FindOverlayVacuumBrakePipe()
   tshControlValues["VacuumBrakeChamberPressure"],
   tshStaticValues["VacuumBrakeChamberUnits"]      = FindOverlayVacuumBrakeChamber()
   tshControlValues["TrainBrakeCylinderPressure"],
   tshStaticValues["TrainBrakeCylinderUnits"]      = FindOverlayTrainBrakeCylinder()
   tshControlValues["LocoBrakeCylinderPressure"],
   tshStaticValues["LocoBrakeCylinderUnits"]       = FindOverlayLocoBrakeCylinder()
   tshControlValues["AirBrakePipePressure"],
   tshStaticValues["AirBrakePipeUnits"]            = FindOverlayAirBrakePipe()
   tshControlValues["MainReservoirPressure"],
   tshStaticValues["MainReservoirUnits"]           = FindOverlayMainReservoir()
   tshControlValues["EqReservoirPressure"],
   tshStaticValues["EqReservoirUnits"]             = FindOverlayEqReservoir()

   -- Steamers (driver)

   tshControlValues["BlowOffCockShutOffRight"] = FindOverlayBlowOffCockShutOffRight()
   tshControlValues["Dynamo"]                  = FindOverlayDynamo()
   tshControlValues["AirPump"]                 = FindOverlayAirPump()
   tshControlValues["SteamHeatingShutOff"]     = FindOverlaySteamHeatingShutOff()
   tshControlValues["SteamHeating"]            = FindOverlaySteamHeating()
   tshControlValues["MasonsValve"]             = FindOverlayMasonsValve()
   tshControlValues["SteamManifold"]           = FindOverlaySteamManifold()
   tshControlValues["LubricatorSteam"]         = FindOverlayLubricatorSteam()
   tshControlValues["LubricatorValve"]         = FindOverlayLubricatorValve()
   tshControlValues["Lubricator"]              = FindOverlayLubricator()
   tshControlValues["LubricatorWarming"]       = FindOverlayLubricatorWarming()
   tshControlValues["SmallEjector"]            = tshControl["SmallEjector"]
   tshControlValues["LargeEjector"]            = tshControl["LargeEjector"]
   tshControlValues["BrakeHook"]               = FindOverlayBrakeHook()
   tshControlValues["SanderSteam"]             = FindOverlaySanderSteam()
   tshControlValues["Sander"]                  = FindOverlaySander()
   tshControlValues["SanderRear"]              = FindOverlaySanderRear()
   tshControlValues["SanderCaps"]              = FindOverlaySanderCaps()
   tshControlValues["SanderFill"]              = FindOverlaySanderFill()
   tshControlValues["AshpanSprinkler"]         = FindOverlayAshpanSprinkler()
   tshControlValues["CylinderCockMaster"]      = FindOverlayCylinderCockMaster()
   tshControlValues["CylinderCock"]            = FindOverlayCylinderCock()
   tshControlValues["WaterScoop"]              = FindOverlayWaterScoop()

   -- Steamers (fireman)

   tshControlValues["BlowOffCockShutOffLeft"] = FindOverlayBlowOffCockShutOffLeft()
   tshControlValues["FeedWaterPumpShutOff"]   = FindOverlayFeedWaterPumpShutOff()
   tshControlValues["ControlValve"]           = FindOverlayControlValve()
   tshControlValues["BlowerSteam"]            = FindOverlayBlowerSteam()
   tshControlValues["ExhaustInjectorShutOff"] = FindOverlayExhaustInjectorShutOff()
   tshControlValues["LiveInjectorShutOff"]    = FindOverlayLiveInjectorShutOff()
   tshControlValues["TenderWaterShutOff"]     = FindOverlayTenderWaterShutOff()

   -- FireboxMass from the functions

   tshControlValues["AtomizerPressure"]     = FindOverlayAtomizerPressure()
   tshControlValues["TankTemperature"]      = FindOverlayTankTemperature()
   tshControlValues["FireboxDoor"]          = FindOverlayFireboxDoor()
   tshControlValues["Stoking"]              = FindOverlayStoking()
   tshControlValues["OilRegulator"]         = FindOverlayOilRegulator()
   tshControlValues["Atomizer"]             = FindOverlayAtomizer()
   tshControlValues["TankHeater"]           = FindOverlayTankHeater()
   tshControlValues["Blower"]               = tshControl["Blower"]
   tshControlValues["Damper"]               = FindOverlayDamper()
   tshControlValues["DamperLeft"]           = FindOverlayDamperLeft()
   tshControlValues["DamperRight"]          = FindOverlayDamperRight()
   tshControlValues["DamperFront"]          = FindOverlayDamperFront()
   tshControlValues["DamperRear"]           = FindOverlayDamperRear()
   tshControlValues["WaterGauge"]           = FindOverlayWaterGauge()
   tshControlValues["FeedWaterPressure"]    = FindOverlayFeedWaterPressure()
   tshControlValues["FeedWaterPump"]        = FindOverlayFeedWaterPump()
   tshControlValues["ExhaustInjectorSteam"] = FindOverlayExhaustInjectorSteam()
   tshControlValues["ExhaustInjectorWater"] = FindOverlayExhaustInjectorWater()
   tshControlValues["LiveInjectorSteam"]    = FindOverlayLiveInjectorSteam()
   tshControlValues["LiveInjectorWater"]    = FindOverlayLiveInjectorWater()
   tshControlValues["SafetyValve1"]         = FindOverlaySafetyValve1()
   tshControlValues["SafetyValve2"]         = FindOverlaySafetyValve2()

   -- Warning values

   tshControlValues["Alarm"] = FindOverlayAlarm()
   tshControlValues["VigilAlarm"] = FindOverlayVigilAlarm()
   tshControlValues["EmergencyBrake"] = FindOverlayEmergencyBrake()
   tshControlValues["Startup"] = FindOverlayStartup()

   -- Doors Values

   tshDoorsValues["Doors"] = FindOverlayDoors()
   tshDoorsValues["DoorsLeft"] = FindOverlayDoorsLeft()
   tshDoorsValues["DoorsRight"] = FindOverlayDoorsRight()

   -----------------------------------------------------------
   -- Do some common automagic, this way we don't need to do that per loco
   -- This section tries to autodetect several commonly used things
   -- based on the ControlValues detected above
   -----------------------------------------------------------

   -- For SmokeBox brakes (FEF-3, Connie and US Advanced), TrainBrake pressures are internal
   if tshUSAdvancedBrakes then  -- set by FindOverlayLocoBrakeCylinder()
      tshControlValues["TrainBrakeCylinderPressure"] = nil
      tshStaticValues["TrainBrakeCylinderUnits"] = nil
   end

   -- Rescale CombinedThrottle to (-1,1) if it's (0,1) or to (-x/y,1) if it's (-x,y)
   if tshControlValues["CombinedThrottle"] then
      tshRescaleCombinedThrottle = GetControlRange(tshControlValues["CombinedThrottle"])
      if not tshRescaleCombinedThrottle[1] then  -- Meaning it's (0,1)
         tshControlValuesFunctions["CombinedThrottle"] = function(value) return value * 2 - 1 end
      elseif tshRescaleCombinedThrottle[1] < 0 and tshRescaleCombinedThrottle[2] >= 2 then
         tshControlValuesFunctions["CombinedThrottle"] = function(value) return value / tshRescaleCombinedThrottle[2] end
      end
   end

   -- Rescale Throttle to (x,1)
   if tshControlValues["Throttle"] then
      tshRescaleThrottle = GetControlRange(tshControlValues["Throttle"])
      if tshRescaleThrottle[1] and tshRescaleThrottle[2] >= 2 then
         tshControlValuesFunctions["Throttle"] = function(value) return value / tshRescaleThrottle[2] end
      end
   end

   -- Disable regular damper if it's split (l/r or f/r)
   if tshControlValues["DamperLeft"] or tshControlValues["DamperRight"] or tshControlValues["DamperFront"] or tshControlValues["DamperRear"] then
      tshControlValues["Damper"] = nil
   end

   -- For CombinedThrottleSplit hide the other element
   if tshControlValues["TrainBrake"] == tshControlValues["CombinedThrottle"] then
      tshControlValues["TrainBrake"] = nil
   end
   if tshControlValues["DynamicBrake"] == tshControlValues["CombinedThrottle"] then
      tshControlValues["DynamicBrake"] = nil
   end   

   -----------------------------------------------------------
   -- Override defaults for custom locos. Detect functions are in the main script.
   -- Sometimes I have to do this as a loco might have a control value that is
   -- detected but it should not be displayed. E.g. it's internal to the
   -- implementation or is basically useless for this loco.
   -----------------------------------------------------------

   -- Steamers

   if DetectFEF3_ADV_Smokebox(true) or DetectFEF3_HUD_Smokebox(true) then
      -- Hide the internal values
      tshControlValues["SteamChestPressure"] = nil
      tshControlValues["FireboxDoor"] = nil
      tshControlValues["Stoking"] = nil
      tshControlValues["ExhaustInjectorSteam"] = nil
      tshControlValues["ExhaustInjectorWater"] = nil
      -- Fix the Sander
      tshControlValues["Sander"] = "Sander"
      -- Firebox is 0-5%, make it full range (0-100%)
      tshControlValuesFunctions["FireboxMass"] = function(value) return value * 20 end
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] = function(value)
         value = value - 0.3
         if (value < 0) then value = value * 100 else value = value * 50 end
         return value
      end

   elseif DetectConnie_ADV_Smokebox(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value * 2 - 1 end
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] = function(value)
         value = value - 0.3332
         if (value < 0) then value = value * 90 else value = value * 45 end
         return value
      end

   elseif DetectConnie_HUD_Smokebox(true) then
      -- BackPressure needs to be converted
      tshControlValuesFunctions["BackPressure"] = function(value)
         value = value - 0.3332
         if (value < 0) then value = value * 90 else value = value * 45 end
         return value
      end

   elseif DetectEE3B_ADV_MeshTools(true) then
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 720 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 720 end

   elseif DetectAusterity_ADV_MeshTools(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 2700 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 2700 end
      -- Blueprint garbage
      tshControlValues["SteamHeatingPressure"] = nil
      tshControlValues["VacuumBrakePipePressure"] = nil
      tshControlValues["SteamHeating"] = nil
      tshControlValues["SteamManifold"] = nil
      tshControlValues["Lubricator"] = nil
      tshControlValues["BrakeHook"] = nil

   elseif Detect2FDockTank_ADV_MeshTools(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end

   elseif Detect3FJintyTrain_ADV_MeshTools(true) then
      -- Correct levers for steam (push/pull) brake
      tshControlValues["LocoBrake"] = "SteamBrakeSpindle"
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end

   elseif Detect3FJintySteam_ADV_MeshTools(true) then
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 1200 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 900 end
      -- It doesn't have vacuum brakes, hide
      tshControlValues["VacuumBrakePipePressure"] = nil
      tshStaticValues["VacuumBrakePipeUnits"] = nil

   elseif DetectBulleidQ1_VictoryWorks(true) then
      -- Make the sandbox {0,1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 900 end

      -- Uncomment all if you want to display simple water controls
      -- Keyboard controls those, advanced are controlled from the cab
      --tshControlValues["ExhaustInjectorSteam"] = "ExhaustInjectorSteamOnOff"
      --tshControlValues["ExhaustInjectorWater"] = "ExhaustInjectorWater"
      --tshControlValues["LiveInjectorSteam"] = "LiveInjectorSteamOnOff"
      --tshControlValues["LiveInjectorWater"] = "LiveInjectorWater"
      --tshControlValues["ExhaustInjectorShutOff"] = nil
      --tshControlValues["LiveInjectorShutOff"] = nil
      --tshControlValues["TenderWaterShutOff"] = nil

   elseif DetectGWRRailmotor_VictoryWorks(true) or DetectGWRRailmotorBoogie_VictoryWorks(true) then
      -- Not functional, hide
      tshControlValues["SmallEjector"] = nil

   elseif DetectDRBR86(true) then
      -- Hide the internal values
      tshControlValues["LiveInjectorSteam"] = nil
      tshControlValues["LiveInjectorWater"] = nil
      tshControlValues["TrainBrakeCylinderPressure"] = nil
      tshControlValues["EqReservoirPressure"] = nil
      -- Make the Sander {-1, 1}
      tshControlValuesFunctions["Sander"] = function(value) return value - 1 end
      -- Make the Sanboxes {0, 1}
      tshControlValuesFunctions["Sandbox"] = function(value) return value / 2700 end
      tshControlValuesFunctions["SandboxRear"] = function(value) return value / 2700 end

   -- UK

   elseif DetectClass365(true) then
      -- Make the CruiseCtl {0, 120}
      tshControlValuesFunctions["TargetSpeed"] = function(value) return value * 120 end

   -- German

   elseif DetectBR103TEE_vRailroads(true) then
      -- Not functional, hide
      tshControlValues["TargetSpeed"] = nil

   elseif DetectBR261(true) then
      -- Hide the internal values
      tshControlValues["EqReservoirPressure"] = nil

   -- US


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
