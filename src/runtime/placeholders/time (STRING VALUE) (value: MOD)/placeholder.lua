return function()
	local min;
	min = DateTime.now():ToLocalTime().Minute;
	if #tostring(min) == 1 then
		min = '0'..min;
	end;
	return tostring(DateTime.now():ToLocalTime().Hour..':'..min);
end;
