--//name:Utilla;]]1
--//developer:alreadyasync;]]2
--//version:1.0;]]3
--//division:u;]]4
--# @mod_start

local logger = base:Get('logger');

local mod = {};
function mod.onEnable()
	logger.log('Utilla v1.0 is now running!');
end;
function mod.OnDisable()
	logger.log('Utilla has been disabled!');
end;
function mod.commandExecuted(command, arguments)
	if command == 'db' then
		local arg1;
		if arguments['arg1'] then
			arg1 = arguments['arg1'];
		end;
		if arg1 == 'test' then
			local h = #script.Parent.modules:GetChildren();
			local failed = '';
			local succeed = 0;
			for _,check in script.Parent.modules:GetChildren() do
				if require(check).check() then
					succeed+=1;
				else
					failed..=module.Name..', ';
				end;
			end;
			if succeed == h then
				logger.log('All modules successfully replied!');
			else
				logger.warning(succeed..'/'..h..' modules successfully replied!');
				logger.warning('Following modules did not respond: '..failed);
			end;
		end;
		logger.log('Hello world! '..arg1);
		return;
	elseif command == 'logger' then
		local arg1,arg2;
		if arguments['arg1'] and arguments['arg2'] then
			arg1 = arguments['arg1'];
			arg2 = arguments['arg2'];
		end;
		if arg1 and arg2 then
			if arg1 == 'log' then logger.log(arg2) elseif arg1 == 'warning' or arg1 == 'warn' then logger.warning(arg2) elseif arg1 == 'error' or arg1 == 'err' then logger.err(arg2) end;
		end;
	end;
end;
return mod;
