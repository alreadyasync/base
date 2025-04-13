--//name:RemoteControl;]]1
--//developer:alreadyasync;]]2
--//version:1.0;]]3
--//division:rc;]]4
--# @mod_start

local logger = base:Get('logger');

local mod = {};
function mod.onEnable()
	print('Remote Control enabled!');
end;
function mod.OnDisable()
	print('Remote Control disabled!');
end;
function mod.commandExecuted(command, arguments)
	if command == 'fire' or command == 'f' then
		local final;
		local arg1,arg2;
		if arguments['arg1'] and arguments['arg2'] then
			arg1,arg2 = arguments['arg1'],arguments['arg2'];
		end;
		local sortedKeys = {};
		for k in pairs(arguments) do
			table.insert(sortedKeys, k);
		end;
		table.sort(sortedKeys, function(a, b) return tonumber(a:match('%d+')) < tonumber(b:match('%d+')); end);
		for _, k in ipairs(sortedKeys) do
			local v = arguments[k];
			if k ~= 'arg0' and k ~= 'arg1' and k ~= 'arg2' then
				local a;
				if _ == #sortedKeys then
					a = v;
				else
					a = v .. ',';
				end;
				final = final .. a;
			end;
		end;
		if game[arg1] and game[arg1][arg2] then
			 game[arg1][arg2]:FireServer(final);
			logger.log('Remote Control: Running event!');
			return true;
		else
			logger.log('Remote Control: Failed to run event!');
			return false;
		end;
	end;
end;
return mod;
