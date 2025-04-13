--//name:h-utils;]]1
--//developer:alreadyasync;]]2
--//version:2.0;]]3
--//division:h;]]4
--# @mod_start

local logger = base:Get('logger');
local data = require(base:Get('data'));

local http = game:GetService('HttpService');

function httpGet(arg)
	local success, response = pcall(function()
		return http:GetAsync(arg, true);
	end);
	if success then
		return response;
	else
		return false;
	end;
end;
function httpPost(arg, arg2)
	local success, response = pcall(function()
		return http:PostAsync(arg, arg2);
	end);
	if success then
		return response;
	else
		return false;
	end;
end;

local mod = {};
function mod.onEnable()
	print('H-Utils Active!');
	if tonumber(httpGet('https://raw.githubusercontent.com/alreadyasync/base/refs/heads/main/version.txt')) > _G.base_bv then
		logger.warning('There is an update for BASE available at github.com/alreadyasync/base!');
	end;
end;
function mod.OnDisable()
	print('H-Utils Unactive! Reactivate ASAP!');
end;
function mod.commandExecuted(command, arguments)
	print(command, arguments)
	if not command then
		logger.log('H-Utils - Made by AlreadyAsync')
		logger.log('@h -inst [v.] pluginName.lua      Installs a verified plugin from the Github');
		logger.log('@h -inst [uv.] https://*.*.*/*    Installs an unverified plugin from a website of your choice');
		logger.log("@h -get https://*.*.*/*           Sumbit's a GET request to a site and returns the response");
		logger.log("@h -post https://*.*.*/*          Sumbit's a POST request to a site");
		logger.log("H-Utils is also useful for creating plugins. E.g. base:GetDep('hUtils');"); 
	end
	if command == 'inst' then
		local arg1,arg2;
		local prefix;
		if arguments['arg1'] and arguments['arg2'] then
			arg1 = arguments['arg1'];
			arg2 = arguments['arg2'];
		end;
		if arg1 == '[v.]' then
			if not string.find(arg2,'.lua') then arg2 = arg2..'.lua'; end;
			prefix = 'https://raw.githubusercontent.com/alreadyasync/base/refs/heads/main/verified_addons/'..arg2;
		elseif arg1 == '[uv.]' then
			prefix = arg2;
		end;
		data.appendModule(httpGet(prefix));
		return;
	elseif command == 'get' then
		local arg1;
		local prefix;
		if arguments['arg1'] then
			arg1 = arguments['arg1'];
		end;
		prefix = arg1;
		local finish = httpGet(prefix)
		print(finish);
		return finish;
	elseif command == 'post' then
		local arg1,arg2;
		local prefix;
		if arguments['arg1'] and arguments['arg2'] then
			arg1 = arguments['arg1'];
			arg2 = arguments['arg2'];
		end;
		prefix = arg1;
		logger.log(httpPost(prefix, arg2));
	end;
end;
return mod;
