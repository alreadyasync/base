-- BASE - script version 1
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local pl,bg;

return{
	check = function() return true; end;
	interpretManifest = function(manifest:string)
		if not manifest:find('--//name:') or not manifest:find('--//developer:') or not manifest:find('--//version:') or not manifest:find('--//division:') then
			return 'Invalid manifest or manifest is for a different version of BASE!';
		end;
		local name = string.split(string.split(manifest, '--//name:')[2], ';]]1')[1];
		local dev = string.split(string.split(manifest, '--//developer:')[2], ';]]2')[1];
		local ver = string.split(string.split(manifest, '--//version:')[2], ';]]3')[1];
		local div = string.split(string.split(manifest, '--//division:')[2], ';]]4')[1];
		return {mod_name=name,developer=dev,mod_version=ver,mod_division=div, packet='success'};
	end;
	mod = {
		getResponse = function() return true; end;
	};
};
