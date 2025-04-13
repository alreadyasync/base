-- BASE - script version 3
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local uis,i,w = game:GetService('UserInputService'),false,false;
local am = require(script.Parent["addon_manager.lua"]);

local line = {}
local register = {}

function line.log(log)
	if w then
		local placeholder = w.background.placeholder:Clone();
		placeholder.Parent = w.background.logs;
		placeholder.Visible = true;
		placeholder.Text = '-> '..tostring(log);
	end;
end;

function line.InterpretCommand(command:string)
	if not string.find(command, '@') then return; end;
	local division = string.split(string.split(command, '@')[2], ' ')[1];
	if register[division] then
		local cmd;
		if string.split(string.split(command, ' -')[2], ' ')[1] then
			cmd = string.split(string.split(command, ' -')[2], ' ')[1];
		end;
		local args = {}
		local a=0;
		repeat
			if not string.split(command, ' ')[a+2] then break end;
			if string.split(string.split(command, ' ')[a+2], ' ')[1] then
				args['arg'..a] = string.split(string.split(command, ' ')[a+2], ' ')[1];
				if string.find(args['arg'..a],'%%') then
					local c = string.split(args['arg'..a],'%')[2];
					local d = string.split(c,'%')[1];
					for _,v in pairs(script.Parent.Parent.runtime.placeholders:GetChildren()) do
						if v.Name == d then
							local val = v.Value;
							if string.find(val, 'VALUES.') then
								local internal = string.split(val, 'VALUES.')[2];
								if script.Parent.Parent.runtime.values[internal] then
									args['arg'..a] = script.Parent.Parent.runtime.values[internal].Value;
								end;
							end;
							if string.find(val, 'MOD') then
								if v:FindFirstChild('placeholder') then
									args['arg'..a] = require(v.placeholder)();
								end;
							end;
						end;
					end;
				end;
			end;
			a+=1;
			task.wait();
		until not string.split(command, ' ')[a+2]
		print(cmd, args);
		return register[division].commandExecuted(cmd, args);
	end;
end;
function line.InterpretModule(moduleScript:string)
	if moduleScript:split('--# @mod_start') then
		local manifest = moduleScript:split('--# @mod_start')[1];
		manifest = am.interpretManifest(manifest);
		if manifest.packet then
			local moduleObj = Instance.new('ModuleScript', script.Parent.Parent.runtime);
			local moduleScriptCode = string.gsub(moduleScript, 'base:Get%(', 'require(script.Parent.Parent.modules["command_controller.lua"]).modr.get(');
			moduleObj.Source = moduleScriptCode;
			moduleObj.Name = manifest.mod_name;
			if register[manifest.mod_division] then
				return 'InterpretModule: Failed - Division is already registered!'
			else
				register[manifest.mod_division] = require(moduleObj);
				register[manifest.mod_division].onEnable();
			end;
		else
			return 'Interpreter fail: No manifest packet!';
		end;
	else
		return 'Interpreter fail: Invalid simple manifest!';
	end;
end;

return{
	check = function() return true; end;
	init = function(widget) 
		if i then return 'Command already initialized!'; end;
		w = widget;
		widget.Enabled = true;
		local bg = widget.background;
		local sf = bg.logs;
		local tb = bg.command;
		local log = bg.placeholder;
		i = true;
		task.spawn(function()
			uis.InputBegan:Connect(function(input)
				if input.KeyCode == Enum.KeyCode.RightShift then
					widget.Enabled = not widget.Enabled;
				end;
			end);
		end);
		tb.FocusLost:Connect(function(enter)
			if enter then
				line.InterpretCommand(tb.Text);
				tb.Text = '';
			end;
		end);
	end;
	loadMod = line.InterpretModule;
	loadCommand = line.InterpretCommand;
	mod = {
		set_init_override = function(x:boolean) i=x; end;
	};
	modr = {
		-- mod resources
		get = function(obj)
			if obj == 'logger' then
				return {
					log = function(log)
						line.log(log);
					end,
					warning = function(log)
						line.log('WARNING: '..log);
					end,
					err = function(log)
						line.log('ERROR: '..log);
					end,
				};
			elseif obj == 'data' then
				return script.Parent["data_controller.lua"];
			elseif obj == 'controller' then
				return script.Parent["command_controller.lua"];
			end;
		end;
	};
};
