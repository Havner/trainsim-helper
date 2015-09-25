-- A word of warning, be careful with your syntax when editing LUA script files because
-- the only way you know something is wrong is when the script does not work. So my advice
-- is make small changes and test your script regularly.

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

require("plugins/trainsim-helper-detect-locos")
require("plugins/trainsim-helper-find-values")
require("plugins/trainsim-helper-joystick")
require("plugins/trainsim-helper-overlay")

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
