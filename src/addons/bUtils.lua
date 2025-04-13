--//name:b-utils;]]1
--//developer:alreadyasync;]]2
--//version:1.7;]]3
--//division:b;]]4
--# @mod_start

local logger = base:Get('logger');
local data = base:Get('data');
local controller = base:Get('controller');

local clipboard = script.Parent.Parent.runtime.values.clipboard;

local mod = {};
function mod.onEnable()
	print('B-Utils Active!');
end;
function mod.OnDisable()
	print('B-Utils Unactive! Reactivate ASAP!');
end;
function mod.commandExecuted(command, arguments)
	print(command, arguments)
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
	elseif command == 'c' then
		if not arguments['arg1'] then return false; end;
		local final:string,complete = '';
		print(arguments)
		local sortedKeys = {};
		for k in pairs(arguments) do
			table.insert(sortedKeys, k);
		end;
		table.sort(sortedKeys, function(a, b) return tonumber(a:match('%d+')) < tonumber(b:match('%d+')); end);
		for _, k in ipairs(sortedKeys) do
			local v = arguments[k];
			print(k, v);
			if k ~= 'arg0' then
				print('not arg0');
				local a;
				if _ == #sortedKeys then
					a = v;
				else
					a = v .. ' ';
				end;
				final = final .. a;
			else
				print('is arg0');
			end;
		end;
		if string.find(final, '@') then
			complete = require(controller).loadCommand(final);
			local count = 0;
			repeat task.wait(0.1); count+=1; until count >= 10 or complete;
			print(complete)
			if complete then
				logger.log('Copied "'..complete..'" to your clipboard! (C)');
			else
				logger.log('Failed to copy "'..final..'" to your clipboard! (C)');
			end
		else
			complete = final;
			logger.log('Copied "'..complete..'" to your clipboard! (S)');
		end;
		clipboard.Value = complete;
	end;
	return;
end;
return mod;
