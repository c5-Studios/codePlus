# codePlus

Additional functions and variables that can be used in Roblox scripts

*Please be aware that everything here is protected under the Creative Commons Attribution 4.0 International License: You may tweak, share, and distribute this code commercially. However, you MUST give credit to any adaptations of this code, and note any changes made. You do not have to credit me if you just use the script without further distributing or editing it.*

## Download

> Warning: Everything is subject to change, and be outdated.

**Adding it to your game manually:**
1. Copy the code from `MainModule.lua` into a module script under `game.ReplicatedStorage`
2. Name the module script *codePlus_Main*

**Adding it to your game with SharedSystem**
1. Download the SharedSystem plugin into Roblox Studio, if not already done
2. In the command bar, type `shared.codePlus_Update()`

## Usage

> Note: Some functions may be used only by local scripts, some only by server scripts; the remaining functions can be shared universally. Keep this in mind when referencing the functions.

**Installing codePlus into a script**
Installation is super easy. At the beginning of a script, type:
`local cp = require(game.ReplicatedStorage:WaitForChild("codePlus_Main"))`

**Using a codePlus userdata (functions, values, etc.)**
- To use a variable, use cp.VariableName. You can change the values in it as well!
- To use a function, use cp.FunctionName(args) or cp:FunctionName(args). To change the function, do cp.FunctionName = function()
- And so forth and so on. Every other userdata can be referenced by the variable method.
