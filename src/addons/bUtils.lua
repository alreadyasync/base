--//name:b-utils;]]1
--//developer:alreadyasync;]]2
--//version:1.0;]]3
--//division:b;]]4
--# @mod_start

local logger = base:Get('logger');
local data = base:Get('data');

local mod = {};
function mod.onEnable()
	print('B-Utils Active!');
end;
function mod.OnDisable()
	print('B-Utils Unactive! Reactivate ASAP!');
end;
function mod.commandExecuted(command, arguments)
	if command == 'WPD' then
		local arg1 = 'N/A';
		if arguments['arg1'] then
			arg1 = arguments['arg1'];
		else
			logger.log('Are you sure you want to wipe plugin data?');
			logger.log('This will delete all downloaded plugins other than:');
			logger.log('bUtils, hUtils');
			logger.log('To confirm, type: @b -WPD confirm');
		end;
		if arg1 == 'confirm' then
			logger.log('Wiping plugin data!');
			require(data).setData(nil);
			logger.log('Please restart the plugin!');
		end;
	elseif command == 'uninst' then
		local arg1;
		if arguments['arg1'] then
			arg1 = arguments['arg1'];
		end;
		arg1 = string.gsub(arg1, '/!', ' ');
		require(data).removeModule(arg1);
	end;
	return;
end;
return mod;
