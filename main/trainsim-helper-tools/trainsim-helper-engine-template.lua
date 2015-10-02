-- This is a glue code that will make the game run the original loco
-- engine script, as well as trainsim-helper code that deals with a
-- joystick and an overlay. It calls the original script and mine
-- using a fortunate fact that functions in LUA are variables and
-- can be mangled around.

-- The alternative would be to patch the binary .out files to inject
-- my code. I've managed to do that previously but this method is not
-- always reliable for all the RSC/DTG provided scripts.
-- (Credits to CobraOne for the original method).

-- Require the original renamed script, we still need it
require("_ORIGINAL_SCRIPT_NAME_SUFFIXED_")
-- And require helper code
require("plugins/trainsim-helper.lua")

-- Provide a basic Initialise for old locos that don't have it
function InitialiseBasic()
   Call("BeginUpdate")
end

if not Initialise then
   Initialise = InitialiseBasic
end

-- Save the original function under a different name
UpdateOrig = Update
MainUpdateOrig = MainUpdate  -- GT3

-- And define a new function that will get called by the game instead
function Update(time)
   if UpdateOrig then
      UpdateOrig(time)
   end
   UpdateHelper(time)
end

function MainUpdate(time)
   if MainUpdateOrig then
      MainUpdateOrig(time)
   end
   UpdateHelper(time)
end
