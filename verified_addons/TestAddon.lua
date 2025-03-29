--//name:Test Addon;]]1
--//developer:alreadyasync;]]2
--//version:1.0;]]3
--//division:t;]]4
--# @mod_start

local logger = base:Get('logger');

local mod = {};
function mod.onEnable()
	print('Test Addon is enabled!');
end;
function mod.OnDisable()
	print('Test Addon is disabled!');
end;
function mod.commandExecuted(command, arguments)
	if command == 'test_addon' then
		local arg1 = 'No argument provided!';
		if arguments['arg1'] then
			arg1 = arguments['arg1'];
		end;
		logger.log('Hello world! '..arg1);
		return;
	end;
end;
return mod;
