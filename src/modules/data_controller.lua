-- BASE - script version 2
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

_G.base_bv = 1.9;
local BV,pl,dataModel = _G.base_bv;

local cc = require(script.Parent["command_controller.lua"]);
local am = require(script.Parent["addon_manager.lua"]);

function IFL()
	if not pl then return; end;
	if not pl:GetSetting('base_data') then
		pl:SetSetting('base_data', dataModel)
		return true;
	end;
	for _,v in pl:GetSetting('base_data').addons do
		cc.loadMod(v);
	end;
	return false;
end;

return{
	check = function() return true; end;
	setPlugin = function(pl2, dm) pl = pl2; dataModel = dm; end;
	isFirstLaunch = IFL;
	setData = function(data) pl:SetSetting('base_data', data) end;
	appendModule = function(moduleCode)
		local baseData = pl:GetSetting('base_data') or {};
		baseData.addons = baseData.addons or {};
		table.insert(baseData.addons, moduleCode);
		pl:SetSetting('base_data', baseData);
		cc.modr.get('logger').log('Installed! Please restart the plugin for the new module to load!');
	end;
	removeModule = function(moduleName)
		local baseData = pl:GetSetting('base_data') or {};
		if baseData.addons then
			for i,v in ipairs(baseData.addons) do
				local manifest = v:split('--# @mod_start')[1];
				local r = am.interpretManifest(manifest).mod_name;
				if r == moduleName then
					table.remove(baseData.addons, i);
					break;
				end;
			end;
		end;
		pl:SetSetting('base_data', baseData)
		cc.modr.get('logger').log('Uninstalled! Please restart the plugin for the module to be unloaded!');
	end;
	getManifest = function()
		if not pl then repeat task.wait(); until pl; end;
		if not pl:GetSetting('base_data') then IFL() end;
		return {
			name = 'base_manifest',
			ver = pl:GetSetting('base_data').version or tostring(BV);
		};
	end;
};
