# codePlus

Additional functions and variables that can be used in Roblox scripts

*Please be aware that everything here is protected under the Creative Commons Attribution 4.0 International License: You may tweak, share, and distribute this code commercially. However, you MUST give credit to any adaptations of this code, and note any changes made. You do not have to credit me if you just use the script without further distributing or editing it.*

## Download

> Warning: Everything is subject to change, and be outdated.

**Adding it to your game manually:**
1. Copy the code from `MainModule.lua` into a module script under `game.ReplicatedStorage`
2. Name the module script *codePlus_Main*

**Adding it to your game with the plugin**
1. Download the *codePlus* plugin into Roblox Studio, if not already done
2. Press the plugin button, labeled "iGottic's codePlus"

## Usage

> Note: Some functions may be used only by local scripts, some only by server scripts; the remaining functions can be shared universally. Keep this in mind when referencing the functions.

**Installing codePlus into a script manually**
Installation is super easy. At the beginning of a script, type:
`local cp = require(game.ReplicatedStorage:WaitForChild("codePlus_Main"))`

**Installing codePlus into a script with plugin**
If you have the plugin, you don't have to worry: it will install codePlus into every script created!

**Using a codePlus userdata (functions, values, etc.)**
- To use a variable, use cp.VariableName. You can change the values in it as well!
- To use a function, use cp.FunctionName(args) or cp:FunctionName(args) ([depends on function used]). To change and customize the function, do cp.FunctionName = function()
- And so forth and so on. Every other userdata can be referenced by the variable method.
