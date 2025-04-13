return function()
	local studio = game:GetService('StudioService');
	return tostring(game.Players:GetNameFromUserIdAsync(studio:GetUserId()));
end;
