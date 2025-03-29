-- BASE - script version 1
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local m,l = script.modules;
l = m:GetChildren();

local modules = {};
halt = nil;
for i,v in l do
	if not halt then
		halt = require(v):check();
		modules[v.Name] = require(v);
		if halt then
			halt = nil;
		else
			halt = "BASE ERROR: loading: "..v.Name;
		end;
	end;
end;
if halt then
	error(halt);
else
	modules['data_controller.lua'].setPlugin(plugin);
	modules['ui_gen.lua'].setPlugin(plugin);
	if modules['data_controller.lua'].isFirstLaunch() then
		print('Welcome to Base');
	end;
	modules['ui_gen.lua'].buildUI();
end;
