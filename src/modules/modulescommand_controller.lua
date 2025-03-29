-- BASE - script version 1
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local uis,i = game:GetService('UserInputService');

local line = {}
function line.InterpretCommand(command:string)
	-- WIP
end;

return{
	check = function() return true; end;
	init = function(widget) 
		if i then return 'Command already initialized!'; end;
		widget.Enabled = true;
		i = true;
		task.spawn(function()
			uis.InputBegan:Connect(function(input)
				if input.KeyCode == Enum.KeyCode.RightShift then
					widget.Enabled = not widget.Enabled;
				end;
			end);
		end);
		
	end;
	mod = {
		set_init_override = function(x:boolean) i=x; end;
	};
};
