-- BASE - script version 1
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local BV,pl = 0.01;

return{
	check = function() return true; end;
	setPlugin = function(pl2) pl = pl2; end;
	isFirstLaunch = function() if not pl then return; end; if pl:GetSetting('base_data') then pl:SetSetting('base_data', {version=BV}) return true; else return false; end; end;
	getManifest = function()
		if not pl then repeat task.wait(); until pl; end;
		if not pl:GetSetting('base_data') then pl:SetSetting('base_data', {version=BV}) end;
		print(pl:GetSetting('base_data'))
		return {
		name = 'base_manifest',
		ver = pl:GetSetting('base_data').version or tostring(BV);
	}; end;
};
