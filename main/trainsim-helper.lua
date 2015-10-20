-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

-----------------------------------------------------------
----------------  Locos detect functions  -----------------
-----------------------------------------------------------
--  Can be used for both, Overlay and Joystick modules  ---
-----------------------------------------------------------

-- Steamers

function DetectFEF3_ADV_Smokebox(DisablePopup) -- Sherman Hill addon
   if Call("ControlExists", "MarsLight", 0) == 1 and
      Call("ControlExists", "WhistlePull", 0) == 1 and
      Call("ControlExists", "RegulatorLever", 0) == 1 and
      Call("ControlExists", "TrainBrakeHandle", 0) == 1 and
      Call("ControlExists", "FWPump", 0) == 1 and
      Call("ControlExists", "RegulatorClutch", 0) == 1 and
      Call("ControlExists", "ReverserClutch", 0) == 1 and
      Call("ControlExists", "MRPSI", 0) == 1 and
      Call("ControlExists", "HideDetail", 0) == 1 and
      Call("ControlExists", "Dynamo", 0) == 1 and
      Call("ControlExists", "WheelAngularSpeed", 0) == 1 and
      Call("ControlExists", "WheelslipDamage", 0) == 1 and
      Call("ControlExists", "SafetyValveEngineer", 0) == 1 and
      Call("ControlExists", "TenderFrontToolbox", 0) == 1 and
      Call("ControlExists", "BlowerControlValve", 0) == 1 and
      Call("ControlExists", "RealSteamChestPressure", 0) == 1 and
      Call("ControlExists", "SludgeRemoverL", 0) == 1 and
      Call("ControlExists", "HTDPressure1s", 0) == 1 and
      Call("ControlExists", "MUvisibility", 0) == 1
   then
      if not DisablePopup then DisplayPopup("FEF-3 (ADV, Smokebox) detected") end
      return 1
   end
end

function DetectFEF3_HUD_Smokebox(DisablePopup) -- Sherman Hill addon
   if Call("ControlExists", "MarsLight", 0) == 1 and
      Call("ControlExists", "WhistlePull", 0) == 0 and
      Call("ControlExists", "RegulatorLever", 0) == 0 and
      Call("ControlExists", "TrainBrakeHandle", 0) == 0 and
      Call("ControlExists", "FWPump", 0) == 1 and
      Call("ControlExists", "RegulatorClutch", 0) == 1 and
      Call("ControlExists", "ReverserClutch", 0) == 1 and
      Call("ControlExists", "MRPSI", 0) == 1 and
      Call("ControlExists", "HideDetail", 0) == 1 and
      Call("ControlExists", "Dynamo", 0) == 1 and
      Call("ControlExists", "WheelAngularSpeed", 0) == 1 and
      Call("ControlExists", "WheelslipDamage", 0) == 1 and
      Call("ControlExists", "SafetyValveEngineer", 0) == 1 and
      Call("ControlExists", "TenderFrontToolbox", 0) == 1 and
      Call("ControlExists", "BlowerControlValve", 0) == 1 and
      Call("ControlExists", "RealSteamChestPressure", 0) == 1 and
      Call("ControlExists", "SludgeRemoverL", 0) == 1 and
      Call("ControlExists", "HTDPressure1s", 0) == 1 and
      Call("ControlExists", "MUvisibility", 0) == 1
   then
      if not DisablePopup then DisplayPopup("FEF-3 (HUD, Smokebox) detected") end
      return 1
   end
end

function DetectConnie_ADV_Smokebox(DisablePopup) -- Horseshoe Curve addon
   if Call("ControlExists", "LubricatorMainValve", 0) == 1 and
      Call("ControlExists", "LubricatorSteamThrottle", 0) == 1 and
      Call("ControlExists", "CabLightOn", 0) == 1 and
      Call("ControlExists", "Vent", 0) == 1 and
      Call("ControlExists", "BellSound", 0) == 1 and
      Call("ControlExists", "FireboxPedal", 0) == 1 and
      Call("ControlExists", "TenderLight", 0) == 1 and
      Call("ControlExists", "LocoHeadlight", 0) == 1 and
      Call("ControlExists", "WaterSightGlass", 0) == 1 and
      Call("ControlExists", "BlowerControlValve", 0) == 1 and
      Call("ControlExists", "MaxCylCondensation", 0) == 1 and
      Call("ControlExists", "Friction", 0) == 1 and
      Call("ControlExists", "MRPSI", 0) == 1 and
      Call("ControlExists", "SafetyValveVolume", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Consolidation (HUD, Smokebox) detected") end
      return 1
   end
end

function DetectConnie_HUD_Smokebox(DisablePopup) -- Horseshoe Curve addon
   if Call("ControlExists", "LubricatorMainValve", 0) == 1 and
      Call("ControlExists", "LubricatorSteamThrottle", 0) == 1 and
      Call("ControlExists", "CabLightOn", 0) == 1 and
      Call("ControlExists", "Vent", 0) == 1 and
      Call("ControlExists", "BellSound", 0) == 1 and
      Call("ControlExists", "FireboxPedal", 0) == 1 and
      Call("ControlExists", "TenderLight", 0) == 1 and
      Call("ControlExists", "LocoHeadlight", 0) == 1 and
      Call("ControlExists", "WaterSightGlass", 0) == 0 and
      Call("ControlExists", "BlowerControlValve", 0) == 0 and
      Call("ControlExists", "MaxCylCondensation", 0) == 0 and
      Call("ControlExists", "Friction", 0) == 0 and
      Call("ControlExists", "MRPSI", 0) == 1 and
      Call("ControlExists", "SafetyValveVolume", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Consolidation (HUD, Smokebox) detected") end
      return 1
   end
end

function Detect2FDockTank_ADV_MeshTools(DisablePopup) -- Falmouth Branch addon
   if Call("ControlExists", "Headcode1", 0) == 1 and
      Call("ControlExists", "MiddleLeftWindow", 0) == 1 and
      Call("ControlExists", "Left Steam", 0) == 1 and
      Call("ControlExists", "MixtureL", 0) == 1 and
      Call("ControlExists", "FrontSandBox", 0) == 1 and
      Call("ControlExists", "LubricatorDrip", 0) == 1 and
      Call("ControlExists", "VirtualSander", 0) == 1 and
      Call("ControlExists", "Steam Manifold", 0) == 1 and
      Call("ControlExists", "LeftGaugeGlassDrain", 0) == 1 and
      Call("ControlExists", "WhistleBlast", 0) == 1 and
      Call("ControlExists", "Brokeness", 0) == 1 and
      Call("ControlExists", "WeightThingy", 0) == 1 and
      Call("ControlExists", "ComputatedTE", 0) == 1 and
      Call("ControlExists", "RainB", 0) == 1
   then
      if not DisablePopup then DisplayPopup("2F Dock Tank (ADV, MeshTools) detected") end
      return 1
   end
end   

function DetectJ50_ADV_MeshTools(DisablePopup) -- Western Lines of Scotland addon
   if Call("ControlExists", "Headcode1", 0) == 1 and
      Call("ControlExists", "Headcode4", 0) == 1 and
      Call("ControlExists", "WindowLeft", 0) == 1 and
      Call("ControlExists", "ReverserLock", 0) == 1 and
      Call("ControlExists", "DamperLeft", 0) == 1 and
      Call("ControlExists", "Seat", 0) == 1 and
      Call("ControlExists", "WhistleBlast", 0) == 1 and
      Call("ControlExists", "GaurdsWhistle", 0) == 1 and
      Call("ControlExists", "RearSander", 0) == 1 and
      Call("ControlExists", "SmallBrakeValve", 0) == 1 and
      Call("ControlExists", "Vacuum Chamber Side", 0) == 1 and
      Call("ControlExists", "Steam Heat Valve", 0) == 1 and
      Call("ControlExists", "Right Door", 0) == 1 and
      Call("ControlExists", "DFO", 0) == 1 and
      Call("ControlExists", "WheelVelocity", 0) == 1
   then
      if not DisablePopup then DisplayPopup("J50 (ADV, MeshTools) detected") end
      return 1
   end
end

function Detect3FJintyTrain_ADV_MeshTools(DisablePopup) -- Western Lines of Scotland addon
   if Call("ControlExists", "Headcode1", 0) == 1 and
      Call("ControlExists", "MiddleLeftWindow", 0) == 1 and
      Call("ControlExists", "ReverserLock", 0) == 1 and
      Call("ControlExists", "Left Steam", 0) == 1 and
      Call("ControlExists", "MixtureL", 0) == 1 and
      Call("ControlExists", "SteamBrakePush", 0) == 1 and
      Call("ControlExists", "SteamBrakePull", 0) == 1 and
      Call("ControlExists", "VacuumSpindle", 0) == 1 and
      Call("ControlExists", "SteamBrakeHook", 0) == 1 and
      Call("ControlExists", "SteamBrakeSpindle", 0) == 1 and
      Call("ControlExists", "RearSandBox", 0) == 1 and
      Call("ControlExists", "VirtualDamper", 0) == 1 and
      Call("ControlExists", "RightGaugeGlassIsolatingHandle", 0) == 1 and
      Call("ControlExists", "BafflePlate", 0) == 1 and
      Call("ControlExists", "Right Cab Door", 0) == 1 and
      Call("ControlExists", "Water fuel", 0) == 1 and
      Call("ControlExists", "Priming", 0) == 1 and
      Call("ControlExists", "CylinderWear", 0) == 1
   then
      if not DisablePopup then DisplayPopup("3F Jinty TrainBrake (ADV, MeshTools) detected") end
      return 1
   end
end   

function Detect3FJintySteam_ADV_MeshTools(DisablePopup) -- Western Lines of Scotland addon
   if Call("ControlExists", "Headcode1", 0) == 1 and
      Call("ControlExists", "MiddleLeftWindow", 0) == 1 and
      Call("ControlExists", "ReverserLock", 0) == 1 and
      Call("ControlExists", "Left Steam", 0) == 1 and
      Call("ControlExists", "MixtureL", 0) == 1 and
      Call("ControlExists", "SteamBrakePush", 0) == 0 and
      Call("ControlExists", "SteamBrakePull", 0) == 0 and
      Call("ControlExists", "VacuumSpindle", 0) == 0 and
      Call("ControlExists", "SteamBrakeHook", 0) == 0 and
      Call("ControlExists", "SteamBrakeSpindle", 0) == 0 and
      Call("ControlExists", "RearSandBox", 0) == 1 and
      Call("ControlExists", "VirtualDamper", 0) == 1 and
      Call("ControlExists", "RightGaugeGlassIsolatingHandle", 0) == 1 and
      Call("ControlExists", "BafflePlate", 0) == 1 and
      Call("ControlExists", "Right Cab Door", 0) == 1 and
      Call("ControlExists", "Water fuel", 0) == 1 and
      Call("ControlExists", "Priming", 0) == 1 and
      Call("ControlExists", "CylinderWear", 0) == 1
   then
      if not DisablePopup then DisplayPopup("3F Jinty SteamBrake (ADV, MeshTools) detected") end
      return 1
   end
end   

function DetectJ94Train_ADV_MeshTools(DisablePopup) -- Memories of Maerdy
   if Call("ControlExists", "Headcode1", 0) == 1 and
      Call("ControlExists", "Headcode4", 0) == 1 and
      Call("ControlExists", "WindowLeft", 0) == 1 and
      Call("ControlExists", "CabVent", 0) == 1 and
      Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "DamperLeft", 0) == 1 and
      Call("ControlExists", "DamperRight", 0) == 1 and
      Call("ControlExists", "WhistleToot", 0) == 1 and
      Call("ControlExists", "GaurdsWhistle", 0) == 1 and
      Call("ControlExists", "VirtualLocoBrake", 0) == 1 and
      Call("ControlExists", "CabLamp", 0) == 1 and
      Call("ControlExists", "TrainBrakeControl", 0) == 1
   then
      if not DisablePopup then DisplayPopup("J94 TrainBrake (ADV, MeshTools) detected") end
      return 1
   end
end

function DetectJ94Steam_ADV_MeshTools(DisablePopup) -- Memories of Maerdy
   if Call("ControlExists", "Headcode1", 0) == 1 and
      Call("ControlExists", "Headcode4", 0) == 1 and
      Call("ControlExists", "WindowLeft", 0) == 1 and
      Call("ControlExists", "CabVent", 0) == 1 and
      Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "DamperLeft", 0) == 1 and
      Call("ControlExists", "DamperRight", 0) == 1 and
      Call("ControlExists", "WhistleToot", 0) == 1 and
      Call("ControlExists", "GaurdsWhistle", 0) == 1 and
      Call("ControlExists", "VirtualLocoBrake", 0) == 1 and
      Call("ControlExists", "CabLamp", 0) == 1 and
      Call("ControlExists", "TrainBrakeControl", 0) == 0
   then
      if not DisablePopup then DisplayPopup("J94 SteamBrake (ADV, MeshTools) detected") end
      return 1
   end
end

-- UNUSED
function DetectSmallPrairies_VictoryWorks(DisablePopup) -- Falmouth Branch addon
   if Call("ControlExists", "TestValue1", 0) == 1 and
      Call("ControlExists", "TractiveEffortSpeedCalculated", 0) == 1 and
      Call("ControlExists", "SpinExtra", 0) == 1 and
      Call("ControlExists", "CurrentRotation", 0) == 1 and
      Call("ControlExists", "BeatChuff1", 0) == 1 and
      Call("ControlExists", "ConsistRegulator", 0) == 1 and
      Call("ControlExists", "ExhaustInjectorWaterLever", 0) == 1 and
      Call("ControlExists", "VWDamper", 0) == 1 and
      Call("ControlExists", "Whistle2", 0) == 1 and
      Call("ControlExists", "VWWaterGauge", 0) == 1 and
      Call("ControlExists", "RoofHatch", 0) == 1 and
      Call("ControlExists", "HideATC", 0) == 1 and
      Call("ControlExists", "HideBunkerGuard", 0) == 1 and
      Call("ControlExists", "HideRearTopLampR", 0) == 1 and
      Call("ControlExists", "Audio_SteamChestRegulator", 0) == 1 and
      Call("ControlExists", "Audio_ConsistEnd", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Small Prairies (VictoryWorks) detected") end
      return 1
   end
end

-- UNUSED
function Detect14xx_VictoryWorks(DisablePopup) -- Falmouth Branch addon
   if Call("ControlExists", "TractiveEffortSpeedCalculated", 0) == 1 and
      Call("ControlExists", "SpinExtra", 0) == 1 and
      Call("ControlExists", "CurrentRotation", 0) == 1 and
      Call("ControlExists", "BeatChuff1", 0) == 1 and
      Call("ControlExists", "ConsistRegulator", 0) == 1 and
      Call("ControlExists", "ExhaustInjectorWaterLever", 0) == 1 and
      Call("ControlExists", "Whistle2", 0) == 1 and
      Call("ControlExists", "VWFakeWaterGauge", 0) == 1 and
      Call("ControlExists", "RoofHatch", 0) == 1 and
      Call("ControlExists", "HideBonnet", 0) == 1 and
      Call("ControlExists", "Audio_SteamChestRegulator", 0) == 1 and
      Call("ControlExists", "AutoControl_Front", 0) == 1
   then
      if not DisablePopup then DisplayPopup("14xx/48xx/58xx (VictoryWorks) detected") end
      return 1
   end
end

-- UNUSED
function DetectAutocoachA31_VictoryWorks(DisablePopup) -- Falmouth Branch addon
   if Call("ControlExists", "CabControlLock", 0) == 1 and
      Call("ControlExists", "HornAnimation", 0) == 1 and
      Call("ControlExists", "WhistleChain", 0) == 1 and
      Call("ControlExists", "Gong", 0) == 1 and
      Call("ControlExists", "V_DoorLeft", 0) == 1 and
      Call("ControlExists", "V_DoorWindowRight", 0) == 1 and
      Call("ControlExists", "BellReply1", 0) == 1 and
      Call("ControlExists", "Audio_InCab", 0) == 1 and
      Call("ControlExists", "Audio_Connected", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Autocoach A31 (VictoryWorks) detected") end
      return 1
   end
end

-- UNUSED
function DetectBulleidQ1_VictoryWorks(DisablePopup) -- Sommerset and Dorset addon
   if Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "Stoking", 0) == 1 and
      Call("ControlExists", "TractiveEffortCalculated", 0) == 1 and
      Call("ControlExists", "AvgGradient", 0) == 1 and
      Call("ControlExists", "ExcessTE", 0) == 1 and
      Call("ControlExists", "BeatNumber", 0) == 1 and
      Call("ControlExists", "BeatChuff1", 0) == 1 and
      Call("ControlExists", "VirtualWaterGaugeL", 0) == 1 and
      Call("ControlExists", "WaterGauge_BottomValveL", 0) == 1 and
      Call("ControlExists", "C_CoalLevel", 0) == 1 and
      Call("ControlExists", "C_HideMechLub", 0) == 1 and
      Call("ControlExists", "Audio_WheelSlipSqueal", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Bulleid Q1 (VictoryWorks) detected") end
      return 1
   end
end

-- UNUSED
function DetectGWRRailmotor_VictoryWorks(DisablePopup) -- West Somerset Railway addon
   if Call("ControlExists", "AdvancedMode", 0) == 1 and
      Call("ControlExists", "CabControlLock", 0) == 1 and
      Call("ControlExists", "CabSwap", 0) == 1 and
      Call("ControlExists", "V_DoorLeft", 0) == 1 and
      Call("ControlExists", "V_DoorWindowLeft", 0) == 1 and
      Call("ControlExists", "C_WindowHorizLeft", 0) == 1 and
      Call("ControlExists", "C_WindowHorizRight", 0) == 1 and
      Call("ControlExists", "C_RoofHatch", 0) == 1 and
      Call("ControlExists", "CV_Bulbs", 0) == 1 and
      Call("ControlExists", "BellReply1", 0) == 1 and
      Call("ControlExists", "LocationAudioControl", 0) == 1 and
      Call("ControlExists", "Boom", 0) == 1 and
      Call("ControlExists", "DupeRev", 0) == 1
   then
      if not DisablePopup then DisplayPopup("GWR Railmotor (VictoryWorks) detected") end
      return 1
   end
end

-- UNUSED
function DetectGWRRailmotorBoogie_VictoryWorks(DisablePopup) -- West Somerset Railway addon
   if Call("ControlExists", "AdvancedMode", 0) == 1 and
      Call("ControlExists", "CabControlLock", 0) == 1 and
      Call("ControlExists", "VirtualThrottle", 0) == 1 and
      Call("ControlExists", "VirtualBrake", 0) == 1 and
      Call("ControlExists", "SteamFlow", 0) == 1 and
      Call("ControlExists", "LocationAudioControl", 0) == 1 and
      Call("ControlExists", "WaterInCylinders", 0) == 1 and
      Call("ControlExists", "Boom", 0) == 1 and
      Call("ControlExists", "Motion_InternalView", 0) == 1
   then
      if not DisablePopup then DisplayPopup("GWR Railmotor Boogie (VictoryWorks) detected") end
      return 1
   end
end

-- UNUSED
function Detect56xx_VictoryWorks(DisablePopup) -- Memories of Maerdy addon
   if Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "Stoking", 0) == 1 and
      Call("ControlExists", "PantographControl", 0) == 1 and
      Call("ControlExists", "gCocksWaterLevel", 0) == 1 and
      Call("ControlExists", "gStationaryTime", 0) == 1 and
      Call("ControlExists", "CylinderCocksClear", 0) == 1 and
      Call("ControlExists", "CylinderCocksFilled", 0) == 1 and
      Call("ControlExists", "gExtraCoal", 0) == 1 and
      Call("ControlExists", "gSmokeColour", 0) == 1 and
      Call("ControlExists", "LampBracket", 0) == 1 and
      Call("ControlExists", "ToolBoxLid", 0) == 1 and
      Call("ControlExists", "SafetyFeather", 0) == 1
   then
      if not DisablePopup then DisplayPopup("56xx (VictoryWorks) detected") end
      return 1
   end
end

function Detect5700Pannier(DisablePopup) -- Riviera Line addon
   if Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "VacuumChamberSide", 0) == 1 and
      Call("ControlExists", "VacuumTest", 0) == 1 and
      Call("ControlExists", "InFlow", 0) == 1 and
      Call("ControlExists", "VolumeEvacuated", 0) == 1 and
      Call("ControlExists", "VacuumResRelease", 0) == 1 and
      Call("ControlExists", "Whistle_2", 0) == 1 and
      Call("ControlExists", "SideShutter2", 0) == 1 and
      Call("ControlExists", "Pasty", 0) == 1 and
      Call("ControlExists", "SafetyValve2", 0) == 0
   then
      if not DisablePopup then DisplayPopup("5700 Pannier (DA) detected") end
      return 1
   end
end      

function DetectCastle(DisablePopup) -- Riviera Line addon
   if Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "Stoking", 0) == 1 and
      Call("ControlExists", "SteamFlow", 0) == 1 and
      Call("ControlExists", "Flap", 0) == 1 and
      Call("ControlExists", "HeadBoard", 0) == 1 and
      Call("ControlExists", "Lamp1", 0) == 1 and
      Call("ControlExists", "Lamp4", 0) == 1 and
      Call("ControlExists", "SteamHeat", 0) == 1 and
      Call("ControlExists", "SteamHeatGauge", 0) == 1 and
      Call("ControlExists", "MasonsValve", 0) == 1 and
      Call("ControlExists", "TestCock1", 0) == 1 and
      Call("ControlExists", "TestCock2", 0) == 1 and
      Call("ControlExists", "Lubricator", 0) == 1 and
      Call("ControlExists", "LubricatorWarming", 0) == 1 and
      Call("ControlExists", "AshpanSprinkler", 0) == 1 and
      Call("ControlExists", "SeatDriver", 0) == 1 and
      Call("ControlExists", "SeatFireman", 0) == 1 and
      Call("ControlExists", "CastleThunder", 0) == 1 and
      Call("ControlExists", "LargeEjector", 0) == 0 and
      Call("ControlExists", "VirtualSmallCompressorOnOff", 0) == 0      
   then
      if not DisablePopup then DisplayPopup("Castle (Old) detected") end
      return 1
   end
end

-- UNUSED
function DetectBlack5_KeithRoss(DisablePopup) -- Western Lines of Scotland
   if Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "Headlamp4", 0) == 1 and
      Call("ControlExists", "Headlamp1", 0) == 1 and
      Call("ControlExists", "PerformanceLogging", 0) == 1 and
      Call("ControlExists", "VirtualThrottle", 0) == 1 and
      Call("ControlExists", "SteamChestGaugePSI", 0) == 1 and
      Call("ControlExists", "SteamFlow", 0) == 1 and
      Call("ControlExists", "Wheelslip", 0) == 1 and
      Call("ControlExists", "FireboxDoor", 0) == 1 and
      Call("ControlExists", "EmergencyBrake", 0) == 1 and
      Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 and
      Call("ControlExists", "WaterGauge", 0) == 1 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "WaterScoopRaiseLower", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "SafetyValve2", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Black 5 (Keith Ross) detected") end
      return 1
   end
end

-- UK

function DetectClass365(DisablePopup) -- London - Peterborough
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "Thingy", 0) == 1 and
      Call("ControlExists", "SpeedTriangle", 0) == 1 and
      Call("ControlExists", "SpeedTarget", 0) == 1 and
      Call("ControlExists", "DashLights", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 365 detected") end
      return 1
   end
end

function DetectHST(DisablePopup) -- London - Peterborough, Riviera Line, EU Pack
   if Call("ControlExists", "RpmDial", 0) == 1 and
      Call("ControlExists", "HandBrakeOff", 0) == 1 and
      Call("ControlExists", "Headlightsmarker", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "EmergencyValve", 0) == 1
   then
      if not DisablePopup then DisplayPopup("HST detected") end
      return 1
   end
end

function DetectClass801(DisablePopup) -- London - Peterborough
   if Call("ControlExists", "SpeedoUnits", 0) == 1 and
      Call("ControlExists", "SpeedoTens", 0) == 1 and
      Call("ControlExists", "SpeedoHundreds", 0) == 1 and
      Call("ControlExists", "MotorLowPitch", 0) == 1 and
      Call("ControlExists", "MotorHighPitch", 0) == 1 and
      Call("ControlExists", "MotorVolume", 0) == 1 and
      Call("ControlExists", "CamInCab", 0) == 1 and
      Call("ControlExists", "Table", 0) == 1 and
      Call("ControlExists", "ATPBox", 0) == 1 and
      Call("ControlExists", "Coat1", 0) == 1 and
      Call("ControlExists", "ForwardPreparation", 0) == 1 and
      Call("ControlExists", "RearPreparation", 0) == 1 and
      Call("ControlExists", "ReadingLight", 0) == 1 and
      Call("ControlExists", "DeskIllumination", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 801 detected") end
      return 1
   end
end   

function DetectClass375Class377(DisablePopup) -- London - Faversham, London - Brighton
   if Call("ControlExists", "Buzzer", 0) == 1 and
      Call("ControlExists", "BrakeHold", 0) == 1 and
      Call("ControlExists", "CarSlider", 0) == 1 and
      Call("ControlExists", "ShoesUp", 0) == 1 and
      Call("ControlExists", "PanUp", 0) == 1 and
      Call("ControlExists", "TaillightSwitch", 0) == 1 and
      Call("ControlExists", "SpeedSetUp", 0) == 1 and
      Call("ControlExists", "SideBlind", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 375/377 detected") end
      return 1
   end
end

function DetectClass450(DisablePopup) -- London - Brighton
   if Call("ControlExists", "SimulationJustSetup", 0) == 1 and
      Call("ControlExists", "CoachID", 0) == 1 and
      Call("ControlExists", "RegenerativeSound", 0) == 1 and
      Call("ControlExists", "MotorSound", 0) == 1 and
      Call("ControlExists", "InputDisabler", 0) == 1 and
      Call("ControlExists", "SignalBell", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 450 detected") end
      return 1
   end
end

function DetectClass395(DisablePopup) -- London - Faversham
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("GetControlMinimum", "ThrottleAndBrake", 0) == -1.5 and
      Call("ControlExists", "PanUpShoesDown", 0) == 1 and
      Call("ControlExists", "VirtualReverser", 0) == 1 and
      Call("ControlExists", "DC", 0) == 1 and
      Call("ControlExists", "CTRL", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 395 detected") end
      return 1
   end
end

function DetectClass360(DisablePopup) -- London - Ipswich
   if Call("ControlExists", "LineVolts", 0) == 1 and
      Call("ControlExists", "CoachType", 0) == 1 and
      Call("ControlExists", "CamInCab", 0) == 1 and
      Call("ControlExists", "FanSound", 0) == 1 and
      Call("ControlExists", "MotorLowPitch", 0) == 1 and
      Call("ControlExists", "MotorHighPitch1", 0) == 1 and
      Call("ControlExists", "MotorVolume", 0) == 1 and
      Call("ControlExists", "AuxMotors", 0) == 1 and
      Call("ControlExists", "SideR", 0) == 1 and
      Call("ControlExists", "SideL", 0) == 1 and
      Call("ControlExists", "Instruments", 0) == 1 and
      Call("ControlExists", "Fuerza", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 360 detected") end
      return 1
   end
end

function DetectClass90_ADV_AP(DisablePopup) -- London - Ipswich addon
   if Call("ControlExists", "VisualAids", 0) == 1 and
      Call("ControlExists", "CabAmbience", 0) == 1 and
      Call("ControlExists", "AirCon", 0) == 1 and
      Call("ControlExists", "IntFanTimer", 0) == 1 and
      Call("ControlExists", "ExtFanTimer", 0) == 1 and
      Call("ControlExists", "BIS", 0) == 1 and
      Call("ControlExists", "swGuardWiper", 0) == 1 and
      Call("ControlExists", "GuardWiper", 0) == 1 and
      Call("ControlExists", "TPWS", 0) == 1 and
      Call("ControlExists", "DSDPedal", 0) == 1 and
      Call("ControlExists", "VirtualEngineBrakeControl", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 90 (ADV, AP) detected") end
      return 1
   end
end

function DetectMK3DVT_ADV_AP(DisablePopup) -- London - Ipswich addon
   if Call("ControlExists", "VisualAids", 0) == 1 and
      Call("ControlExists", "CabAmbience", 0) == 1 and
      Call("ControlExists", "AirCon", 0) == 1 and
      Call("ControlExists", "IntFanTimer", 0) == 1 and
      Call("ControlExists", "ExtFanTimer", 0) == 1 and
      Call("ControlExists", "BIS", 0) == 1 and
      Call("ControlExists", "swGuardWiper", 0) == 1 and
      Call("ControlExists", "GuardWiper", 0) == 1 and
      Call("ControlExists", "TPWS", 0) == 1 and
      Call("ControlExists", "DSDPedal", 0) == 1 and
      Call("ControlExists", "DVTTraction", 0) == 1
   then
      if not DisablePopup then DisplayPopup("MK3 DVT (ADV, AP) detected") end
      return 1
   end
end

function DetectClass158(DisablePopup) -- Liverpool - Manchester
   if Call("ControlExists", "SptEngineStartLight", 0) == 1 and
      Call("ControlExists", "VirtualBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "SptDoorInterlock", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "Instrument Lights", 0) == 1 and
      Call("ControlExists", "Blower", 0) == 1 and
      Call("ControlExists", "DRA", 0) == 1 and
      Call("ControlExists", "DSDEnabled", 0) == 1 and
      Call("ControlExists", "AWSReady", 0) == 1 and
      Call("ControlExists", "AWSTesting", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 158 detected") end
      return 1
   end
end   

function DetectClass08(DisablePopup) -- Weardale - Teesdale
   if Call("ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "GearLever", 0) == 0 and
      Call("ControlExists", "CompessorState", 0) == 1 and
      Call("ControlExists", "DummyWaterPressure", 0) == 1 and
      Call("ControlExists", "DummyBatteryAmps", 0) == 1 and
      Call("ControlExists", "DummyOilPressure", 0) == 1 and
      Call("ControlExists", "DummyFuelGauge", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "Bell", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 0
   then
      if not DisablePopup then DisplayPopup("Class 08 detected") end
      return 1
   end
end

function DetectClass105(DisablePopup) -- Weardale - Teesdale addon
   if Call("ControlExists", "VacuumChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "GearLever", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "Bell", 0) == 1 and
      Call("ControlExists", "Instruments", 0) == 1 and
      Call("ControlExists", "RouteNumberLight", 0) == 1 and
      Call("ControlExists", "DestinationsLight", 0) == 1 and
      Call("ControlExists", "Destination", 0) == 1 and
      Call("ControlExists", "DestinationK", 0) == 1 and
      Call("ControlExists", "DestinationH", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 105 detected") end
      return 1
   end
end

function DetectClass101(DisablePopup) -- Liverpool - Manchester addon, Weardale - Teesdale
   if Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "ReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "VacuumChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "GearLever", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "Bell", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "InstrumentLights", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 101 detected") end
      return 1
   end
end   

function DetectClass143(DisablePopup) -- Riviera Line
   if Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("ControlExists", "VirtualBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "DashLights", 0) == 1 and
      Call("ControlExists", "DRA", 0) == 1 and
      Call("ControlExists", "Fan", 0) == 1 and
      Call("ControlExists", "Buzzer", 0) == 1 and
      Call("ControlExists", "AWSReady", 0) == 1 and
      Call("ControlExists", "AWSTesting", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 143 detected") end
      return 1
   end
end

function DetectClass35(DisablePopup) -- Riviera Line addon
   if Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "Oven", 0) == 1 and
      Call("ControlExists", "HotPlate", 0) == 1 and
      Call("ControlExists", "InstrumentLights", 0) == 1 and
      Call("ControlExists", "Pasty", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 35 detected") end
      return 1
   end
end

-- UNUSED
function DetectClass03(DisablePopup) -- West Somerset Railway addon
   if Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "OilPressure", 0) == 1 and
      Call("ControlExists", "FuelGauge", 0) == 1 and
      Call("ControlExists", "WaterTemperatureGauge", 0) == 1 and
      Call("ControlExists", "GearBoxPressure", 0) == 1 and
      Call("ControlExists", "OldAirBrakePipePressurePSI", 0) == 1 and
      Call("ControlExists", "GearLever", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 03 detected") end
      return 1
   end
end

function DetectClass47(DisablePopup) -- West Somerset Railway addon only, older have no notches
   if Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 and
      Call("ControlExists", "SteamHeatingPressureGaugePSI", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 47 detected") end
      return 1
   end
end

function DetectClass117(DisablePopup) -- West Somerset Railway addon
   if Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "GearLever", 0) == 1 and
      Call("ControlExists", "VacuumBrakePipePressureINCHES", 0) == 1 and
      Call("ControlExists", "VacuumBrakeChamberPressureINCHES", 0) == 1 and
      Call("ControlExists", "Current", 0) == 1 and
      Call("ControlExists", "AbsoluteSpeedMPH", 0) == 1 and
      Call("ControlExists", "Sander", 0) == 1 and
      Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "Startup", 0) == 1 and
      Call("ControlExists", "AWSWarnCount", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 117 detected") end
      return 1
   end
end

function DetectClass170(DisablePopup) -- Academy
   if Call("ControlExists", "Buzzer", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "GlareScreen", 0) == 1 and
      Call("ControlExists", "DRA", 0) == 1 and
      Call("ControlExists", "DSDEnabled", 0) == 1 and
      Call("ControlExists", "InteriorCamera", 0) == 1 and
      Call("ControlExists", "Loco", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 170 detected") end
      return 1
   end
end

function DetectClass321_AP(DisablePopup)
   if Call("ControlExists", "desind", 0) == 1 and
      Call("ControlExists", "Destination", 0) == 1 and
      Call("ControlExists", "Bogie1Flat", 0) == 1 and
      Call("ControlExists", "RoofCabLight", 0) == 1 and
      Call("ControlExists", "Linelightdimmer", 0) == 1 and
      Call("ControlExists", "Linelightglow", 0) == 1 and
      Call("ControlExists", "Linelight", 0) == 1 and
      Call("ControlExists", "DSHeater", 0) == 1 and
      Call("ControlExists", "NDSHeater", 0) == 1 and
      Call("ControlExists", "WheelLock", 0) == 1 and
      Call("ControlExists", "VirtualResPressureNeedle", 0) == 1 and
      Call("ControlExists", "DialLightSwitch", 0) == 1 and
      Call("ControlExists", "VCB", 0) == 1 and
      Call("ControlExists", "TPWS", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 321 (AP) detected") end
      return 1
   end
end

function DetectClass156_Oovee(DisablePopup)
   if Call("ControlExists", "VirtualRPM", 0) == 1 and
      Call("ControlExists", "VirtualFluid", 0) == 1 and
      Call("ControlExists", "Surge", 0) == 1 and
      Call("ControlExists", "GuardSignal", 0) == 1 and
      Call("ControlExists", "Destination", 0) == 1 and
      Call("ControlExists", "GearBoxFault", 0) == 1 and
      Call("ControlExists", "DriverSignal", 0) == 1 and
      Call("ControlExists", "DestinationLight", 0) == 1 and
      Call("ControlExists", "HeaterFan", 0) == 1 and
      Call("ControlExists", "SunblindLeft", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 156 (Oovee) detected") end
      return 1
   end
end

function DetectClass37_Thomson(DisablePopup) -- West Highland Line 
   if Call("ControlExists", "ScenarioRunning", 0) == 1 and
      Call("ControlExists", "VirtualRPM", 0) == 1 and
      Call("ControlExists", "S1", 0) == 1 and
      Call("ControlExists", "CoolingFan01", 0) == 1 and
      Call("ControlExists", "VirtualAmmeter", 0) == 1 and
      Call("ControlExists", "Primer", 0) == 1 and
      Call("ControlExists", "BrakeDemandLamp", 0) == 1 and
      Call("ControlExists", "radiomodecurrent", 0) == 1 and
      Call("ControlExists", "retbkey", 0) == 1 and
      Call("ControlExists", "nextsectionclear", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 37/4 (Thomson) detected") end
      return 1
   end
end

function DetectClass76(DisablePopup) -- Woodhead
   if Call("ControlExists", "Prueba", 0) == 1 and
      Call("ControlExists", "Prueba2", 0) == 1 and
      Call("ControlExists", "RegBrake", 0) == 1 and
      Call("ControlExists", "SelPanto", 0) == 1 and
      Call("ControlExists", "MarkerLight04", 0) == 1 and
      Call("ControlExists", "ShiftLights", 0) == 1 and
      Call("ControlExists", "CabLightControl", 0) == 1 and
      Call("ControlExists", "Gatillo", 0) == 1 and
      Call("ControlExists", "FreighTransfer", 0) == 1 and
      Call("ControlExists", "LineVoltimeter", 0) == 1 and
      Call("ControlExists", "ArmatureAmp", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 76 detected") end
      return 1
   end
end

function DetectClass50_MeshTools(DisablePopup) -- Settle to Carlisle addon
   if Call("ControlExists", "rightvisor", 0) == 1 and
      Call("ControlExists", "LeftVisor", 0) == 1 and
      Call("ControlExists", "HighAndLow", 0) == 1 and
      Call("ControlExists", "BrakeCylinderDial2", 0) == 1 and
      Call("ControlExists", "BrakeMode", 0) == 1 and
      Call("ControlExists", "Thirdtone", 0) == 1 and
      Call("ControlExists", "firetest", 0) == 1 and
      Call("ControlExists", "WaterTemperature", 0) == 1 and
      Call("ControlExists", "Revtemp", 0) == 1 and
      Call("ControlExists", "Vents", 0) == 1 and
      Call("ControlExists", "CoolingFan", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Class 50 (MeshTools) detected") end
      return 1
   end
end

function DetectClass158_Old(DisablePopup) -- Settle to Carlisle
   if Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 and
      Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      Call("ControlExists", "SptEngineStartLight", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSClearCount", 0) == 1 and
      Call("ControlExists", "SptDoorInterlock", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "Blower", 0) == 1 and
      Call("GetControlMaximum", "RPM", 0) == 2400 and
      Call("GetControlMaximum", "MainReservoirPressureBAR", 0) == 10 and
      Call("GetControlMaximum", "SpeedometerMPH", 0) == 100 and
      Call("GetControlMaximum", "Blower", 0) == 17
   then
      if not DisablePopup then DisplayPopup("Class 158 (Old) detected") end
      return 1
   end
end

function DetectClass66(DisablePopup) -- Settle to Carlisle
   if Call("ControlExists", "BrakePipePressureBAR", 0) == 1 and
      Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 and
      Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "Wheelslip", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("GetControlMaximum", "BrakePipePressureBAR", 0) == 14 and
      Call("GetControlMaximum", "AirBrakePipePressureBAR", 0) == 6 and
      Call("GetControlMaximum", "TrainBrakeCylinderPressureBAR", 0) == 7 and
      Call("GetControlMaximum", "Ammeter", 0) == 8000 and
      Call("GetControlMaximum", "RPM", 0) == 900
   then
      if not DisablePopup then DisplayPopup("Class 66 detected") end
      return 1
   end
end

function DetectClass166(DisablePopup) -- EU Pack
   if Call("ControlExists", "Active", 0) == 1 and
      Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("ControlExists", "TrainBrakeCylinderPressureBAR", 0) == 1 and
      Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSClearCount", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DRAButton", 0) == 1 and
      Call("GetControlMinimum", "TractiveEffort", 0) == -1000 and
      Call("GetControlMaximum", "TractiveEffort", 0) == 1000 and
      Call("GetControlMaximum", "RPM", 0) == 2400 and
      Call("GetControlMaximum", "MainReservoirPressureBAR", 0) == 10 and
      Call("GetControlMaximum", "TrainBrakeCylinderPressureBAR", 0) == 7 and
      Call("GetControlMaximum", "SpeedometerMPH", 0) == 100
   then
      if not DisablePopup then DisplayPopup("Class 166 detected") end
      return 1
   end
end

-- German

function DetectBR103TEE_vRailroads_Expert(DisablePopup) -- Expert Line
   if Call("ControlExists", "InstrBelTaster", 0) == 1 and
      Call("ControlExists", "ZZAauf", 0) == 1 and
      Call("ControlExists", "Fahrstufe", 0) == 1 and
      Call("ControlExists", "FahrschalterAuf", 0) == 1 and
      Call("ControlExists", "vAccelerometer", 0) == 1 and
      Call("ControlExists", "Wischer1", 0) == 1 and
      Call("ControlExists", "Hauptschalter", 0) == 1 and
      Call("ControlExists", "Fahrdrahtspannung", 0) == 1 and
      Call("ControlExists", "Trennschuetz", 0) == 1 and
      Call("ControlExists", "ConsistTotalMass", 0) == 1 and
      Call("ControlExists", "HauptLichtRegler", 0) == 1 and
      Call("ControlExists", "HelpNeedle", 0) == 1 and
      Call("ControlExists", "FMLSchalter", 0) == 1 and
      Call("ControlExists", "BatterieSchalter", 0) == 1 and
      Call("ControlExists", "PantoAufAb", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR103 TEE (vRailroads, Expert) detected") end
      return 1
   end
end

function DetectBR103TEE_vRailroads(DisablePopup) -- Hamburg - Hannover addon
   if Call("ControlExists", "InstrBelTaster", 0) == 1 and
      Call("ControlExists", "ZZAauf", 0) == 1 and
      Call("ControlExists", "Fahrstufe", 0) == 1 and
      Call("ControlExists", "FahrschalterAuf", 0) == 1 and
      Call("ControlExists", "vAccelerometer", 0) == 1 and
      Call("ControlExists", "Wischer1", 0) == 1 and
      Call("ControlExists", "Hauptschalter", 0) == 1 and
      Call("ControlExists", "Fahrdrahtspannung", 0) == 1 and
      Call("ControlExists", "Trennschuetz", 0) == 1 and
      Call("ControlExists", "ConsistTotalMass", 0) == 1 and
      Call("ControlExists", "HauptLichtRegler", 0) == 1 and
      Call("ControlExists", "HelpNeedle", 0) == 1 and
      Call("ControlExists", "FMLSchalter", 0) == 0 and
      Call("ControlExists", "BatterieSchalter", 0) == 0 and
      Call("ControlExists", "PantoAufAb", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR103 TEE (vRailroads) detected") end
      return 1
   end
end

function DetectBR111_vRailroads(DisablePopup) -- Hamburg - Hannover addon
   if Call("ControlExists", "RolloR", 0) == 1 and
      Call("ControlExists", "RolloRR", 0) == 0 and
      Call("ControlExists", "ZZAauf", 0) == 1 and
      Call("ControlExists", "PZBBefehl", 0) == 1 and
      Call("ControlExists", "StMelder", 0) == 1 and
      Call("ControlExists", "HoheAbbremsungLM", 0) == 1 and
      Call("ControlExists", "Fahrstufe", 0) == 1 and
      Call("ControlExists", "PZBWachsamTaster", 0) == 1 and
      Call("ControlExists", "HSLM", 0) == 1 and
      Call("ControlExists", "Schleudermelder", 0) == 1 and
      Call("ControlExists", "Trennschuetz", 0) == 1 and
      Call("ControlExists", "Stoerung", 0) == 1 and
      Call("ControlExists", "engineWithKey", 0) == 0 and
      Call("ControlExists", "driverActiveCab", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR111 (vRailroads) detected") end
      return 1
   end
end

function DetectDBbzf_vRailroads(DisablePopup) -- Hamburg - Hannover addon
   if Call("ControlExists", "RolloR", 0) == 1 and
      Call("ControlExists", "RolloRR", 0) == 1 and
      Call("ControlExists", "ZZAauf", 0) == 1 and
      Call("ControlExists", "PZBBefehl", 0) == 1 and
      Call("ControlExists", "StMelder", 0) == 1 and
      Call("ControlExists", "HoheAbbremsungLM", 0) == 1 and
      Call("ControlExists", "Fahrstufe", 0) == 1 and
      Call("ControlExists", "PZBWachsamTaster", 0) == 1 and
      Call("ControlExists", "HSLM", 0) == 1 and
      Call("ControlExists", "Schleudermelder", 0) == 1 and
      Call("ControlExists", "Trennschuetz", 0) == 1 and
      Call("ControlExists", "Stoerung", 0) == 1 and
      Call("ControlExists", "engineWithKey", 0) == 1 and
      Call("ControlExists", "driverActiveCab", 0) == 1
   then
      if not DisablePopup then DisplayPopup("DBbzf (vRailroads) detected") end
      return 1
   end
end

function DetectBR420_Influenzo(DisablePopup) -- Munich - Augsburg addon
   if Call("ControlExists", "ZZAauf", 0) == 1 and
      Call("ControlExists", "SifaLampe", 0) == 1 and
      Call("ControlExists", "SifaWarnung", 0) == 1 and
      Call("ControlExists", "RearPantographControl", 0) == 1 and
      Call("ControlExists", "SunblindL", 0) == 1 and
      Call("ControlExists", "InterlockRight", 0) == 1 and
      Call("ControlExists", "Bremsschuetz", 0) == 1 and
      Call("ControlExists", "Trennschuetz", 0) == 1 and
      Call("ControlExists", "AICabVolume", 0) == 1 and
      Call("ControlExists", "PZBWachsamTaster", 0) == 1 and
      Call("ControlExists", "Zwangsbremse", 0) == 1 and
      Call("ControlExists", "PZBZugart", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR420 (Influenzo) detected") end
      return 1
   end
end

function DetectBR155(DisablePopup) -- Cologne - Koblenz addon
   if Call("ControlExists", "TractionSelect", 0) == 1 and
      Call("ControlExists", "TractionBlowerSwitch", 0) == 1 and
      Call("ControlExists", "PowerSelector", 0) == 1 and
      Call("ControlExists", "TapChangerT", 0) == 1 and
      Call("ControlExists", "TapChangerFault", 0) == 1 and
      Call("ControlExists", "UserVirtualReverser", 0) == 1 and
      Call("ControlExists", "AxleClearance", 0) == 1 and
      Call("ControlExists", "MainBatterySwitch", 0) == 1 and
      Call("ControlExists", "VirtualStartup", 0) == 1 and
      Call("ControlExists", "WipersLever", 0) == 1 and
      Call("ControlExists", "TestLED", 0) == 1 and
      Call("ControlExists", "GSMRButtonsLit", 0) == 1 and
      Call("ControlExists", "SunVisorRearLeft", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR155 detected") end
      return 1
   end
end

function DetectBR442Talent2(DisablePopup) -- Munich - Garmisch addon
   if Call("ControlExists", "CabEQNeedle", 0) == 1 and
      Call("ControlExists", "CabTBNeedle", 0) == 1 and
      Call("ControlExists", "HornLow", 0) == 1 and
      Call("ControlExists", "BellSoft", 0) == 1 and
      Call("ControlExists", "PassGoods", 0) == 1 and
      Call("ControlExists", "TEUnits", 0) == 1 and
      Call("ControlExists", "PZB_85_2", 0) == 1 and
      Call("ControlExists", "AFBTargetSpeed", 0) == 1 and
      Call("ControlExists", "AFBSet", 0) == 1 and
      Call("ControlExists", "SiFaAudioWarning", 0) == 1 and
      Call("ControlExists", "MegaPhone", 0) == 1 and
      Call("ControlExists", "EffortGraphs", 0) == 1 and
      Call("ControlExists", "BrakeGraphBar", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR442 Talent 2 detected") end
      return 1
   end
end

function DetectBR232(DisablePopup) -- Munich - Augsburg addon
   if Call("ControlExists", "SifaLampe", 0) == 1 and
      Call("ControlExists", "SifaWarnung", 0) == 1 and
      Call("ControlExists", "vAmmeter", 0) == 1 and
      Call("ControlExists", "Kraftstoffpumpe", 0) == 1 and
      Call("ControlExists", "FahrenOnOff", 0) == 1 and
      Call("ControlExists", "VirtualDynamicBrake", 0) == 1 and
      Call("ControlExists", "Wassertemperatur", 0) == 1 and
      Call("ControlExists", "Treibstoffleitungsdruck", 0) == 1 and
      Call("ControlExists", "Batterie", 0) == 1 and
      Call("ControlExists", "Turbolader", 0) == 1 and
      Call("ControlExists", "coolerFan1", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR232 detected") end
      return 1
   end
end

function DetectBR266(DisablePopup) -- Cologne - Koblenz addon
   if Call("ControlExists", "CabEQNeedle", 0) == 1 and
      Call("ControlExists", "CabTBNeedle", 0) == 1 and
      Call("ControlExists", "HornSoft", 0) == 1 and
      Call("ControlExists", "BellSoft", 0) == 1 and
      Call("ControlExists", "Wipers2", 0) == 1 and
      Call("ControlExists", "PassGoods", 0) == 1 and
      Call("ControlExists", "BrakeAirFlow", 0) == 1 and
      Call("ControlExists", "TrainLength", 0) == 1 and
      Call("ControlExists", "WindowLeft", 0) == 1 and
      Call("ControlExists", "TETens", 0) == 1 and
      Call("ControlExists", "SpeedControlEnabled", 0) == 1 and
      Call("ControlExists", "SpeedControlSpeed", 0) == 1 and
      Call("ControlExists", "gnTB", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR266 detected") end
      return 1
   end
end

function DetectBR1460(DisablePopup) -- Cologne - Koblenz
   if Call("ControlExists", "RawSpeedTarget", 0) == 1 and
      Call("ControlExists", "TractionBug", 0) == 1 and
      Call("ControlExists", "AFB_Speed", 0) == 1 and
      Call("ControlExists", "CMD_Free", 0) == 1 and
      Call("ControlExists", "VirtualPantographControl", 0) == 1 and
      Call("ControlExists", "PantographID", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "PZB_500Hz_Control", 0) == 1 and
      Call("ControlExists", "GlarePanel_L", 0) == 1 and
      Call("ControlExists", "LZB_Buzzer", 0) == 1 and
      Call("ControlExists", "PZB_DistantPassed", 0) == 1 and
      Call("ControlExists", "DynamicBrakeFanSound", 0) == 1 and
      Call("ControlExists", "Destination", 0) == 1 and
      Call("ControlExists", "InstrumentLights", 0) == 1 and
      Call("ControlExists", "ForceBar", 0) == 0 and
      Call("ControlExists", "BrakeBar", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR146.0 (New PZB) detected") end
      return 1
   end
end

function DetectBR1462(DisablePopup) -- Cologne - Koblenz
   if Call("ControlExists", "RawSpeedTarget", 0) == 1 and
      Call("ControlExists", "TractionBug", 0) == 1 and
      Call("ControlExists", "AFB_Speed", 0) == 1 and
      Call("ControlExists", "CMD_Free", 0) == 1 and
      Call("ControlExists", "VirtualPantographControl", 0) == 1 and
      Call("ControlExists", "PantographID", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "PZB_500Hz_Control", 0) == 1 and
      Call("ControlExists", "GlarePanel_L", 0) == 1 and
      Call("ControlExists", "LZB_Buzzer", 0) == 1 and
      Call("ControlExists", "PZB_DistantPassed", 0) == 1 and
      Call("ControlExists", "DynamicBrakeFanSound", 0) == 1 and
      Call("ControlExists", "Destination", 0) == 1 and
      Call("ControlExists", "InstrumentLights", 0) == 1 and
      Call("ControlExists", "ForceBar", 0) == 1 and
      Call("ControlExists", "BrakeBar", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR146.2 (New PZB) detected") end
      return 1
   end
end

function DetectDABpbzkfa(DisablePopup) -- Cologne - Koblenz
   if Call("ControlExists", "RawSpeedTarget", 0) == 1 and
      Call("ControlExists", "TractionBug", 0) == 1 and
      Call("ControlExists", "AFB_Speed", 0) == 1 and
      Call("ControlExists", "CMD_Free", 0) == 1 and
      Call("ControlExists", "VirtualPantographControl", 0) == 1 and
      Call("ControlExists", "PantographID", 0) == 0 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "PZB_500Hz_Control", 0) == 1 and
      Call("ControlExists", "GlarePanel_L", 0) == 0 and
      Call("ControlExists", "LZB_Buzzer", 0) == 1 and
      Call("ControlExists", "PZB_DistantPassed", 0) == 1 and
      Call("ControlExists", "DynamicBrakeFanSound", 0) == 0 and
      Call("ControlExists", "Destination", 0) == 1 and
      Call("ControlExists", "InstrumentLights", 0) == 1 and
      Call("ControlExists", "ForceBar", 0) == 1 and
      Call("ControlExists", "BrakeBar", 0) == 1
   then
      if not DisablePopup then DisplayPopup("DABpbzkfa (New PZB) detected") end
      return 1
   end
end

function DetectBR189_MK(DisablePopup) -- Mannheim - Karlruhe
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 160 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000hz_Control", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "GlarePanel_L", 0) == 1 and
      Call("ControlExists", "CabAmmeter", 0) == 1 and
      Call("ControlExists", "SpeedoGuide", 0) == 1 and
      Call("ControlExists", "PantoMovement", 0) == 1 and
      Call("ControlExists", "TrackLimit", 0) == 1 and
      Call("ControlExists", "DynamicBrakeFanSound", 0) == 1 and
      Call("ControlExists", "TrainBrakeOnly", 0) == 0 and
      Call("ControlExists", "CamInCab", 0) == 1 and
      Call("ControlExists", "PowerBar", 0) == 1 and
      Call("ControlExists", "CircuitBreakerSwitch", 0) == 1 and
      Call("ControlExists", "ForceBug", 0) == 1 and
      Call("ControlExists", "DialLight", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR189 (MK) detected") end
      return 1
   end
end

function DetectBR425(DisablePopup) -- Mannheim - Karlsruhe
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 180 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000hz_Control", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("ControlExists", "Effort", 0) == 1 and
      Call("ControlExists", "ServiceBrake", 0) == 1 and
      Call("ControlExists", "Amp", 0) == 1 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR425 detected") end
      return 1
   end
end

function DetectICE3M_MK(DisablePopup) -- Mannheim - Karlsruhe
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 350 and
      Call("GetControlMaximum", "Headlights", 0) == 5 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("ControlExists", "RolloL", 0) == 0 and
      Call("ControlExists", "RolloR", 0) == 0 and
      Call("ControlExists", "Amp", 0) == 0 and
      Call("ControlExists", "HandBrake", 0) == 0 and
      Call("ControlExists", "Tilt", 0) == 0 and
      Call("ControlExists", "CircuitBreakerSwitch", 0) == 1 and
      Call("ControlExists", "WiperSwitch", 0) == 1
   then
      if not DisablePopup then DisplayPopup("ICE 3M (MK) detected") end
      return 1
   end
end

function DetectBR426(DisablePopup) -- Munich - Garmisch
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 300 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("ControlExists", "RolloL", 0) == 1 and
      Call("ControlExists", "RolloR", 0) == 1 and
      Call("ControlExists", "Amp", 0) == 1 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR426 detected") end
      return 1
   end
end

function DetectICE2(DisablePopup) -- Hamburg - Hanover
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 300 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "RolloL", 0) == 1 and
      Call("ControlExists", "RolloR", 0) == 1 and
      Call("ControlExists", "Amp", 0) == 1 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 0
   then
      if not DisablePopup then DisplayPopup("ICE 2 detected") end
      return 1
   end
end

function DetectICE2Cab(DisablePopup) -- Hamburg - Hanover
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 300 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "RolloL", 0) == 1 and
      Call("ControlExists", "RolloR", 0) == 1 and
      Call("ControlExists", "Amp", 0) == 1 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 0
   then
      if not DisablePopup then DisplayPopup("ICE 2 CabCar detected") end
      return 1
   end
end

function DetectICE3M(DisablePopup) -- Hamburg - Hanover
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 350 and
      Call("GetControlMaximum", "Headlights", 0) == 2 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("ControlExists", "RolloL", 0) == 0 and
      Call("ControlExists", "RolloR", 0) == 0 and
      Call("ControlExists", "Amp", 0) == 0 and
      Call("ControlExists", "HandBrake", 0) == 0 and
      Call("ControlExists", "Tilt", 0) == 0 and
      Call("ControlExists", "CircuitBreakerSwitch", 0) == 0 and
      Call("ControlExists", "WiperSwitch", 0) == 0
   then
      if not DisablePopup then DisplayPopup("ICE 3M detected") end
      return 1
   end
end

function DetectICET(DisablePopup) -- Hamburg - Hanover
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 350 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 0 and
      Call("ControlExists", "RolloL", 0) == 0 and
      Call("ControlExists", "RolloR", 0) == 0 and
      Call("ControlExists", "Amp", 0) == 0 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 1
   then
      if not DisablePopup then DisplayPopup("ICE T detected") end
      return 1
   end
end

function DetectBR189(DisablePopup) -- Academy
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 140 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "GlarePanel_L", 0) == 1 and
      Call("ControlExists", "CabAmmeter", 0) == 1 and
      Call("ControlExists", "SpeedoGuide", 0) == 1 and
      Call("ControlExists", "PantoMovement", 0) == 1 and
      Call("ControlExists", "TrackLimit", 0) == 1 and
      Call("ControlExists", "DynamicBrakeFanSound", 0) == 1 and
      Call("ControlExists", "TrainBrakeOnly", 0) == 1 and
      Call("ControlExists", "CamInCab", 0) == 1 and
      Call("ControlExists", "PowerBar", 0) == 1 and
      Call("ControlExists", "CabDirection", 0) == 1 and
      Call("ControlExists", "CircuitBreakerSwitch", 0) == 0 and
      Call("ControlExists", "ForceBug", 0) == 0 and
      Call("ControlExists", "Dial Light", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR189 detected") end
      return 1
   end
end

function DetectBR101_New(DisablePopup) -- Cologne - Koblentz
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "AFB_Speed", 0) == 1 and
      Call("GetControlMaximum", "AFB_Speed", 0) == 250 and
      Call("ControlExists", "PZB", 0) == 1 and
      Call("ControlExists", "PZB_1000Hz", 0) == 1 and
      Call("ControlExists", "LZB", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "Sifa", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "RolloL", 0) == 0 and
      Call("ControlExists", "RolloR", 0) == 0 and
      Call("ControlExists", "Amp", 0) == 0 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR101 (New PZB) detected") end
      return 1
   end
end

function DetectBR101(DisablePopup) -- Munich - Augsburg, Hamburg - Hanover
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 1 and
      Call("GetControlMaximum", "VSoll", 0) == 250 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "LZBEnable", 0) == 1 and
      Call("ControlExists", "LZB_End", 0) == 1 and
      Call("ControlExists", "VigilEnable", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "RolloL", 0) == 0 and
      Call("ControlExists", "RolloR", 0) == 0 and
      Call("ControlExists", "Amp", 0) == 0 and
      Call("ControlExists", "HandBrake", 0) == 1 and
      Call("ControlExists", "Tilt", 0) == 0
   then
      if not DisablePopup then DisplayPopup("BR101 detected") end
      return 1
   end
end

function DetectBR294_New(DisablePopup) -- Cologne - Koblentz
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 0 and
      Call("ControlExists", "LZBEnable", 0) == 0 and
      Call("ControlExists", "PZB", 0) == 1 and
      Call("ControlExists", "PZB_1000Hz", 0) == 1 and
      Call("ControlExists", "DummyAmmeter", 0) == 1 and
      Call("ControlExists", "DummyVoltmeter", 0) == 1 and
      Call("ControlExists", "DummyOilPressure", 0) == 1 and
      Call("ControlExists", "DummyCoolantTemperature", 0) == 1 and
      Call("ControlExists", "DummyOilTemperature", 0) == 1 and
      Call("ControlExists", "DummyEnginePressure", 0) == 1 and
      Call("ControlExists", "DummyTransmissionPressure", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR294 (New PZB) detected") end
      return 1
   end
end

function DetectBR294(DisablePopup) -- Munich - Augsburg, Hamburg - Hanover
   if Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "VSoll", 0) == 0 and
      Call("ControlExists", "LZBEnable", 0) == 0 and
      Call("ControlExists", "PZBEnable", 0) == 1 and
      Call("ControlExists", "PZB_1000", 0) == 1 and
      Call("ControlExists", "DummyAmmeter", 0) == 1 and
      Call("ControlExists", "DummyVoltmeter", 0) == 1 and
      Call("ControlExists", "DummyOilPressure", 0) == 1 and
      Call("ControlExists", "DummyCoolantTemperature", 0) == 1 and
      Call("ControlExists", "DummyOilTemperature", 0) == 1 and
      Call("ControlExists", "DummyEnginePressure", 0) == 1 and
      Call("ControlExists", "DummyTransmissionPressure", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1
   then
      if not DisablePopup then DisplayPopup("BR294 detected") end
      return 1
   end
end

function DetectBR101_Old(DisablePopup) -- EU Pack
   if Call("ControlExists", "Active", 0) == 1 and
      Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "Current", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "CabAmmeter", 0) == 1 and
      Call("ControlExists", "Accelerometer", 0) == 1 and
      Call("ControlExists", "CruiseControl", 0) == 1 and
      Call("ControlExists", "VirtualBrake", 0) == 1 and
      Call("ControlExists", "FrontPantographControl", 0) == 1 and
      Call("ControlExists", "RearPantographControl", 0) == 1 and
      Call("ControlExists", "DynamicBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("GetControlMinimum", "TractiveEffort", 0) == -1000 and
      Call("GetControlMaximum", "TractiveEffort", 0) == 10000 and
      Call("GetControlMaximum", "Current", 0) == 100000 and
      Call("GetControlMinimum", "Ammeter", 0) == -600 and
      Call("GetControlMaximum", "Ammeter", 0) == 600 and
      Call("GetControlMinimum", "Accelerometer", 0) == -320 and
      Call("GetControlMaximum", "Accelerometer", 0) == 320
   then
      if not DisablePopup then DisplayPopup("BR101 (Old) detected") end
      return 1
   end
end

function DetectBR294_Old(DisablePopup) -- EU Pack
   if Call("ControlExists", "Active", 0) == 1 and
      Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "AirBrakePipePressureBAR", 0) == 1 and
      Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 and
      Call("ControlExists", "DummyAmmeter", 0) == 1 and
      Call("ControlExists", "DummyVoltmeter", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("GetControlMinimum", "TractiveEffort", 0) == -1000 and
      Call("GetControlMaximum", "TractiveEffort", 0) == 1000 and
      Call("GetControlMaximum", "RPM", 0) == 2000 and
      Call("GetControlMinimum", "DummyAmmeter", 0) == -200 and
      Call("GetControlMaximum", "DummyAmmeter", 0) == 200 and
      Call("GetControlMaximum", "DummyVoltmeter", 0) == 150
   then
      if not DisablePopup then DisplayPopup("BR294 (Old) detected") end
      return 1
   end
end

function DetectV200(DisablePopup) -- EU Pack
   if Call("ControlExists", "Active", 0) == 1 and
      Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "LocoBrakeCylinderPressureBAR", 0) == 1 and
      Call("ControlExists", "MainReservoirPressureBAR", 0) == 1 and
      Call("ControlExists", "BrakePipePressureBAR", 0) == 1 and
      Call("ControlExists", "SpeedometerKPH", 0) == 1 and
      Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "EngineBrakeControl", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "DoorsOpenClose", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("GetControlMinimum", "TractiveEffort", 0) == -1000 and
      Call("GetControlMaximum", "TractiveEffort", 0) == 1000 and
      Call("GetControlMaximum", "LocoBrakeCylinderPressureBAR", 0) == 12 and
      Call("GetControlMaximum", "MainReservoirPressureBAR", 0) == 12 and
      Call("GetControlMaximum", "BrakePipePressureBAR", 0) == 10 and
      Call("GetControlMaximum", "SpeedometerKPH", 0) == 150 and
      Call("GetControlMaximum", "RPM", 0) == 1800
   then
      if not DisablePopup then DisplayPopup("V200 detected") end
      return 1
   end
end

-- US

function DetectUPGasTurbune(DisablePopup) -- Sherman Hill addon
   if Call("ControlExists", "RealWheelslip", 0) == 1 and
      Call("ControlExists", "AuxReservoirPressure", 0) == 1 and
      Call("ControlExists", "AuxDieselRPMDelta", 0) == 1 and
      Call("ControlExists", "TurbineRPM", 0) == 1 and
      Call("ControlExists", "WheelskidDuration", 0) == 1 and
      Call("ControlExists", "TurbineCombustion", 0) == 1 and
      Call("ControlExists", "TurbineMisStart", 0) == 1 and
      Call("ControlExists", "No1TruckPower", 0) == 1 and
      Call("ControlExists", "FlameoutTimer", 0) == 1 and
      Call("ControlExists", "TurbineHeavyFuelInjected", 0) == 1 and
      Call("ControlExists", "VirtualStartUpEnabled", 0) == 1 and
      Call("ControlExists", "BurningStartFuel", 0) == 1 and
      Call("ControlExists", "TVibrationBCabReset", 0) == 1 and
      Call("ControlExists", "FaultyFlameDetector", 0) == 1
   then
      if not DisablePopup then DisplayPopup("UP Gas Turbine detected") end
      return 1
   end
end

function DetectGP20_ADV_Reppo(DisablePopup) -- Donner Pass addon
   if Call("ControlExists", "Pitch", 0) == 1 and
      Call("ControlExists", "PositionIndicatorSW", 0) == 1 and
      Call("ControlExists", "Alerta", 0) == 1 and
      Call("ControlExists", "Fogged", 0) == 1 and
      Call("ControlExists", "LightsBreaker", 0) == 1 and
      Call("ControlExists", "BatteryKnife", 0) == 1 and
      Call("ControlExists", "FuelPumpSW", 0) == 1 and
      Call("ControlExists", "AutoSanderDelay", 0) == 1 and
      Call("ControlExists", "PcOpen", 0) == 1
   then
      if not DisablePopup then DisplayPopup("GP20 (ADV, Reppo) detected") end
      return 1
   end
end

function DetectSD45_DTM(DisablePopup) -- Donner Pass addon
   if Call("ControlExists", "Driven", 0) == 1 and
      Call("ControlExists", "FrontLights", 0) == 1 and
      Call("ControlExists", "RearLights", 0) == 1 and
      Call("ControlExists", "Mirrors_Front", 0) == 1 and
      Call("ControlExists", "Window04_Control", 0) == 1 and
      Call("ControlExists", "Door02_Control", 0) == 1 and
      Call("ControlExists", "Numberboards", 0) == 1 and
      Call("ControlExists", "Start", 0) == 1 and
      Call("ControlExists", "ThrottleInNeutral", 0) == 1 and
      Call("ControlExists", "ClassLights", 0) == 1 and
      Call("ControlExists", "Gyralight", 0) == 1
   then
      if not DisablePopup then DisplayPopup("SD45 (DTM) detected") end
      return 1
   end
end

function DetectGE44_DTM(DisablePopup) -- Donner Pass addon
   if Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 0 and
      Call("ControlExists", "Mirrors_Front", 0) == 1 and
      Call("ControlExists", "Door02_Control", 0) == 1 and
      Call("ControlExists", "Window04_Control", 0) == 1 and
      Call("ControlExists", "RearHeadLightBright", 0) == 1 and
      Call("ControlExists", "FrontHeadLightBright", 0) == 1 and
      Call("ControlExists", "RearHeadLight", 0) == 1 and
      Call("ControlExists", "FrontHeadLight", 0) == 1 and
      Call("ControlExists", "GageLights", 0) == 1 and
      Call("ControlExists", "CabHeater", 0) == 1
   then
      if not DisablePopup then DisplayPopup("GE44 (DTM) detected") end
      return 1
   end
end

function DetectF40PH(DisablePopup) -- Soldier Summit
   if Call("ControlExists", "StrobeLights", 0) == 1 and
      Call("ControlExists", "NumberLights", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("ControlExists", "LeftArm", 0) == 1 and
      Call("ControlExists", "LeftBlind", 0) == 1 and
      Call("ControlExists", "RightArm", 0) == 1 and
      Call("ControlExists", "RightBlind", 0) == 1 and
      Call("ControlExists", "InstrumentLights", 0) == 1 and
      Call("ControlExists", "UN_units", 0) == 1 and
      Call("ControlExists", "ClassLights", 0) == 1 and
      Call("ControlExists", "StepsLight", 0) == 0 and
      Call("ControlExists", "StepLights", 0) == 0
   then
      if not DisablePopup then DisplayPopup("F40PH detected") end
      return 1
   end
end

function DetectCabCar(DisablePopup) -- Pacific Surfliner and its addons
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "HornHB", 0) == 1 and
      Call("ControlExists", "Flash", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 1 and
      (
         Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 or
         Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1
      )
   then
      if not DisablePopup then DisplayPopup("CabCar detected") end
      return 1
   end
end

function DetectF59PHI(DisablePopup) -- Pacific Surfliner and its addon
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "HornHB", 0) == 1 and
      Call("ControlExists", "Flash", 0) == 1 and
      Call("ControlExists", "DoorsOpenCloseLeft", 0) == 0 and
      Call("ControlExists", "DoorsOpenCloseRight", 0) == 0 and
      Call("ControlExists", "VisorLeft", 0) == 0 and
      Call("ControlExists", "VisorMiddle", 0) == 0 and
      Call("ControlExists", "VisorRight", 0) == 0
   then
      if not DisablePopup then DisplayPopup("F59PHI detected") end
      return 1
   end
end

function DetectF59PH(DisablePopup) -- Pacific Surfliner addon
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "HornHB", 0) == 1 and
      Call("ControlExists", "Flash", 0) == 1 and
      Call("ControlExists", "HEPGen", 0) == 1 and
      Call("ControlExists", "VisorLeft", 0) == 1 and
      Call("ControlExists", "VisorMiddle", 0) == 1 and
      Call("ControlExists", "VisorRight", 0) == 1
   then
      if not DisablePopup then DisplayPopup("F59PH detected") end
      return 1
   end
end

function DetectM8(DisablePopup) -- New York - New Haven addon
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "ATCCutIn", 0) == 1 and
      Call("ControlExists", "TimeToPenalty", 0) == 1 and
      Call("ControlExists", "MyNumber", 0) == 1 and
      Call("ControlExists", "Coach_2", 0) == 1 and
      Call("ControlExists", "Cars", 0) == 1 and
      Call("ControlExists", "SpeedoUnits", 0) == 1 and
      Call("ControlExists", "CylinderUnits", 0) == 1 and
      Call("ControlExists", "PipeUnits", 0) == 1 and
      Call("ControlExists", "PowerAC", 0) == 1 and
      Call("ControlExists", "PowerOverhead", 0) == 1 and
      Call("ControlExists", "MotorVolume", 0) == 1
   then
      if not DisablePopup then DisplayPopup("M8 detected") end
      return 1
   end
end   

function DetectAcela(DisablePopup) -- New York - New Haven addon
   if Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "ATCCutIn", 0) == 1 and
      Call("ControlExists", "TimeToPenalty", 0) == 1 and
      Call("ControlExists", "Doors", 0) == 1 and
      Call("ControlExists", "SelPanto", 0) == 1 and
      Call("ControlExists", "FrontPantoControl", 0) == 1 and
      Call("ControlExists", "RearPantoControl", 0) == 1 and
      Call("ControlExists", "Servicio", 0) == 1 and
      Call("ControlExists", "TiltIsolate", 0) == 1 and
      Call("ControlExists", "FrontCone", 0) == 1 and
      Call("ControlExists", "GroundLights", 0) == 1 and
      Call("ControlExists", "Dimmer", 0) == 1 and
      Call("ControlExists", "SpeedoGuide", 0) == 1 and
      Call("ControlExists", "DestJoy", 0) == 1
   then
      if not DisablePopup then DisplayPopup("Acela detected") end
      return 1
   end
end   

function DetectACS64(DisablePopup) -- New York - New Haven
   if Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "ATCCutIn", 0) == 1 and
      Call("ControlExists", "TimeToPenalty", 0) == 1 and
      Call("ControlExists", "SpeedDigit_units", 0) == 1 and
      Call("ControlExists", "SigAspectTopGreen", 0) == 1 and
      Call("ControlExists", "SigText", 0) == 1 and
      Call("ControlExists", "ScreenDoorsBypassed", 0) == 1 and
      Call("ControlExists", "ScreenFireSuppressionDisabled", 0) == 1 and
      Call("ControlExists", "SpeedDigit_guide", 0) == 1 and
      Call("ControlExists", "AlarmsToExterior", 0) == 1 and
      Call("ControlExists", "TractiveEffortKLBF", 0) == 1 and
      Call("ControlExists", "SigModeACSES", 0) == 1
   then
      if not DisablePopup then DisplayPopup("ACS64 detected") end
      return 1
   end
end

function DetectSD402(DisablePopup) -- New York - New Haven
   if Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "Wheelslip", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "UN_units", 0) == 1 and
      Call("ControlExists", "UN_thousands", 0) == 1 and
      Call("ControlExists", "CabSignal1", 0) == 1 and
      Call("ControlExists", "CabSignal5", 0) == 1 and
      Call("ControlExists", "VirtualThrottle", 0) == 1 and
      Call("ControlExists", "ATCCutIn", 0) == 1 and
      Call("ControlExists", "ACSESCutIn", 0) == 1 and
      Call("ControlExists", "SpeedReductionAlert", 0) == 1 and
      Call("ControlExists", "AutoSuppression", 0) == 1 and
      Call("ControlExists", "CurrentAmtrakSignal", 0) == 1 and
      Call("ControlExists", "CurrentSignalType", 0) == 1 and
      Call("ControlExists", "wibble", 0) == 1 and
      Call("ControlExists", "BrakesInitialised", 0) == 1 and
      Call("ControlExists", "BrakeDifficulty", 0) == 1 and
      Call("ControlExists", "MaximumSpeedLimit", 0) == 1
   then
      if not DisablePopup then DisplayPopup("SD40-2 detected") end
      return 1
   end
end

function DetectSD70MAC_ATC(DisablePopup) -- Academy
   if Call("ControlExists", "aMainReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "aEqReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "TractiveEffort", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "AirCompressor", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "StepsLight", 0) == 1 and
      Call("ControlExists", "BrakeDifficulty", 0) == 1 and
      Call("ControlExists", "G_ER", 0) == 1 and
      Call("ControlExists", "ER_units", 0) == 1 and
      Call("ControlExists", "G_BP", 0) == 1 and
      Call("ControlExists", "BP_units", 0) == 1 and
      Call("ControlExists", "G_BC", 0) == 1 and
      Call("ControlExists", "BC_units", 0) == 1 and
      Call("ControlExists", "G_MAIN", 0) == 1 and
      Call("ControlExists", "MAIN_units", 0) == 1 and
      Call("ControlExists", "SpeedReductionAlert", 0) == 1 and
      Call("ControlExists", "CurrentAmtrakSignal", 0) == 1 and
      Call("ControlExists", "MNRRMinimumRestriction", 0) == 1 and
      Call("ControlExists", "TimeToPenalty", 0) == 1 and
      Call("ControlExists", "ATCCutIn", 0) == 1 and
      Call("ControlExists", "EmergencyBrake_Flap", 0) == 1
   then
      if not DisablePopup then DisplayPopup("SD70MAC (ATC) detected") end
      return 1
   end
end

function DetectF45(DisablePopup) -- Marias Pass
   if Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "Wheelslip", 0) == 1 and
      Call("ControlExists", "Strobe", 0) == 1 and
      Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 and
      Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 and
      Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1 and
      Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      Call("ControlExists", "Instruments", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "AWS", 0) == 0 and
      Call("GetControlMaximum", "RPM", 0) == 1050 and
      Call("GetControlMinimum", "Ammeter", 0) == -900 and
      Call("GetControlMaximum", "Ammeter", 0) == 1500 and
      Call("GetControlMaximum", "SpeedometerMPH", 0) == 120
   then
      if not DisablePopup then DisplayPopup("F45 detected") end
      return 1
   end
end

function DetectC409W(DisablePopup) -- Norfolk Southern
   if Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "RPMDelta", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "EngineStart", 0) == 1 and
      Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1 and
      Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "CabLight", 0) == 1 and
      Call("GetControlMaximum", "RPM", 0) == 1050 and
      Call("GetControlMinimum", "Ammeter", 0) == -1200 and
      Call("GetControlMaximum", "Ammeter", 0) == 1800 and
      Call("GetControlMaximum", "AirBrakePipePressurePSI", 0) == 160 and
      Call("GetControlMaximum", "SpeedometerMPH", 0) == 80
   then
      if not DisablePopup then DisplayPopup("C40-9W detected") end
      return 1
   end
end

function DetectES44DC(DisablePopup) -- Marias Pass, Stevens Pass
   if Call("ControlExists", "EngineStop", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "MAIN_hundreds", 0) == 1 and
      Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 and
      Call("ControlExists", "DynamicBrake", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "StepsLight", 0) == 1 and
      Call("ControlExists", "UnitNumber", 0) == 1 and
      Call("ControlExists", "G_Speedo", 0) == 1 and
      Call("ControlExists", "SPEED_units", 0) == 1 and
      Call("ControlExists", "G_ER", 0) == 1 and
      Call("ControlExists", "ER_units", 0) == 1 and
      Call("ControlExists", "G_BC", 0) == 1 and
      Call("ControlExists", "BC_units", 0) == 1 and
      Call("ControlExists", "G_MAIN", 0) == 1 and
      Call("ControlExists", "MAIN_units", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "AWS", 0) == 0 and
      Call("GetControlMinimum", "Ammeter", 0) == -700 and
      Call("GetControlMaximum", "Ammeter", 0) == 1000 and
      Call("GetControlMaximum", "RPM", 0) == 1050 and
      Call("GetControlMaximum", "LocoBrakeCylinderPressurePSI", 0) == 160 and
      Call("GetControlMaximum", "UnitNumber", 0) == 8000
   then
      if not DisablePopup then DisplayPopup("ES44DC detected") end
      return 1
   end
end

function DetectSD60M(DisablePopup) -- Sherman Hill addon
   if Call("ControlExists", "Driven", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "DynamicBrakeNeedle", 0) == 1 and
      Call("ControlExists", "FrontLights", 0) == 1 and
      Call("ControlExists", "RearLights", 0) == 1 and
      Call("ControlExists", "Mirrors_Front", 0) == 1 and
      Call("ControlExists", "Window04_Control", 0) == 1 and
      Call("ControlExists", "Door01_Control", 0) == 1 and
      Call("ControlExists", "SunBlock04_Control", 0) == 1 and
      Call("ControlExists", "Numberboards", 0) == 1
   then
      if not DisablePopup then DisplayPopup("SD60M detected") end
      return 1
   end
end

function DetectSD70M(DisablePopup) -- Sherman Hill
   if Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "Wheelslip", 0) == 1 and
      Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "UN_units", 0) == 1 and
      Call("ControlExists", "UN_thousands", 0) == 1 and
      Call("ControlExists", "StepLights", 0) == 1 and
      Call("GetControlMaximum", "RPM", 0) == 1050 and
      Call("GetControlMaximum", "EqReservoirPressurePSI", 0) == 160 and
      Call("GetControlMinimum", "Ammeter", 0) == -900 and
      Call("GetControlMaximum", "Ammeter", 0) == 1500
   then
      if not DisablePopup then DisplayPopup("SD70M detected") end
      return 1
   end
end

function DetectES44AC(DisablePopup) -- Sherman Hill, Norfolk Southern
   if Call("ControlExists", "MAIN_hundreds", 0) == 1 and
      Call("ControlExists", "MAIN_tens", 0) == 1 and
      Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "Wheelslip", 0) == 1 and
      Call("ControlExists", "SpeedometerMPH", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "UnitNumber", 0) == 1 and
      Call("ControlExists", "G_Speedo", 0) == 1 and
      Call("ControlExists", "SPEED_units", 0) == 1 and
      Call("ControlExists", "G_ER", 0) == 1 and
      Call("ControlExists", "ER_units", 0) == 1 and
      Call("ControlExists", "G_BC", 0) == 1 and
      Call("ControlExists", "BC_units", 0) == 1 and
      Call("ControlExists", "G_MAIN", 0) == 1 and
      Call("ControlExists", "MAIN_units", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0 and
      Call("ControlExists", "AWS", 0) == 0 and
      Call("GetControlMinimum", "DynamicBrake", 0) == 0 and
      Call("GetControlMaximum", "UnitNumber", 0) == 8000
   then
      if not DisablePopup then DisplayPopup("ES44AC detected") end
      return 1
   end
end

function DetectC449W(DisablePopup) -- Donner Pass
   if Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "ThrottleAndBrake", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "AWS", 0) == 1 and
      Call("ControlExists", "AWSReset", 0) == 1 and
      Call("ControlExists", "GlarePanels", 0) == 1 and
      Call("ControlExists", "TrackDetect1", 0) == 1 and
      Call("ControlExists", "TrackDetect2", 0) == 1 and
      Call("GetControlMaximum", "Ammeter", 0) == 1800
   then
      if not DisablePopup then DisplayPopup("C44-9W detected") end
      return 1
   end
end

-- some generic detections

function DetectGenericSteam(DisablePopup)
   if Call("GetFireboxMass") then
      if not DisablePopup then DisplayPopup("Steam detected") end
      return 1
   end
end

function DetectGenericUSDiesel(DisablePopup)
   if Call("ControlExists", "RPM", 0) == 1 and
      Call("ControlExists", "Ammeter", 0) == 1 and
      Call("ControlExists", "CompressorState", 0) == 1 and
      Call("ControlExists", "Sander", 0) == 1 and
      (
         Call("ControlExists", "MainReservoirPressurePSI", 0) == 1 or
         Call("ControlExists", "aMainReservoirPressurePSI", 0) == 1 or
         Call("ControlExists", "MainReservoirPressurePSIDisplayed", 0) == 1
      ) and
      (
         Call("ControlExists", "AirBrakePipePressurePSI", 0) == 1 or
         Call("ControlExists", "aAirBrakePipePressurePSI", 0) == 1
      ) and
      (
         Call("ControlExists", "TrainBrakeCylinderPressurePSI", 0) == 1 or
         Call("ControlExists", "aTrainBrakeCylinderPressurePSI", 0) == 1 or
         Call("ControlExists", "LocoBrakeCylinderPressurePSI", 0) == 1 or
         Call("ControlExists", "aLocoBrakeCylinderPressurePSI", 0) == 1 or
         Call("ControlExists", "EqReservoirPressurePSI", 0) == 1 or
         Call("ControlExists", "aEqReservoirPressurePSI", 0) == 1
      ) and
      (
         Call("ControlExists", "AWS", 0) == 0 or
         Call("ControlExists", "StepLights", 0) == 1 or
         Call("ControlExists", "StepsLight", 0) == 1
      ) and
      Call("ControlExists", "ThrottleAndBrake", 0) == 0
   then
      if not DisablePopup then DisplayPopup("US Diesel detected") end
      return 1
   end
end

-----------------------------------------------------------
-------------------  Helper functions  --------------------
-----------------------------------------------------------

function DisplayPopup(text, time)
   time = time or 5
   SysCall("ScenarioManager:ShowAlertMessageExt", "TrainSim Helper", text, time, 0)
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
   if Call("GetIsEngineWithKey") ~= 1 then
      return nil
   end

   if not UpdateHelperConfigured then
      -- global tables for the joystick
      tshLine = {}
      tshControl = {}
      tshRange = {}
      tshInvert = {}
      tshCenterDetent = {}
      tshNotches = {}
      tshStep = {}
      tshSetControlTargetValue = {}
      tshPreviousInput = {}
      tshCurrentSim = {}
      tshTargetSim = {}

      -- global tables for the overlay
      tshStaticValues = {}
      tshControlValues = {}
      tshControlValuesFunctions = {}
      tshDoorsValues = {}

      if Call("IsExpertMode") ~= 1 then
         DisplayPopup("SIMPLE MODE DETECTED!\n\nTrainSim Helper won't work properly.", 30)
      end
      UpdateHelperConfigured = 1
   end

   -- Joystick has to be configured first
   if not JoystickConfigured then
      ConfigureJoystick()
   end
   if not OverlayConfigured then
      ConfigureOverlay()
   end

   SetJoystickData()
   GetOverlayData()
end
