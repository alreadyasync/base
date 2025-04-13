-- BASE - script version 2
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local run = game:GetService('RunService');
if not run:IsRunning() and run:IsServer() then
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
		modules['data_controller.lua'].setPlugin(plugin, {
			-- DATA MODEL
			version = _G.base_bv;
			addons = {
				script.addons.bUtils.Source,
				script.addons.hUtils.Source,
			};
		});
		modules['ui_gen.lua'].setPlugin(plugin);
		modules['ui_gen.lua'].buildUI();
		modules['data_controller.lua'].isFirstLaunch();
	end;
end;
