## Hello Developers!

Here is all the API reference which you can use in your custom **BASE** plugin!

### Manifest
Your code MUST include the following at the START of your script:

- `--//name:plugin name;]]1`
- `--//developer:your name here, someone elses name;]]2`
- `--//version:your plugin version as a number (can be a float);]]3`
- `--//division:the @ part which points at your code (needs to be original);]]4`
- `--# @mod_start`

### Base Functions
- `base:Get('logger')` - Returns a dictionary with properties: log(log), warning(log), err(log)
- `base:Get('data')` - Returns the data_controller module (Needs to be required)
- `base:Get('controller')` - Returns the command_controller module (Needs to be required)

### Functions Base Will Trigger
- `mod.onEnable()` - Will be triggered when the module is enabled
- `mod.onDisable()` - Will be triggered when the module is disabled
- `mod.commandExecuted(command:string, arguments:table)` - Will be triggered when the module's division followed with a command (and an arg) has been executed
