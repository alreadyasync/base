return function()
	local studio = game:GetService('StudioService');
	return tostring(studio:GetUserId());
end;
