-- BASE - script version 1
-- alreadycode aka alreadyasync - 2025 - github.com/alreadyasync/base/tree/main/

-- CC-BY-4.0

local pl,bg;

local dc = require(script.Parent['data_controller.lua']);
local cc = require(script.Parent['command_controller.lua']);

local widgetInfo,widget;
local buildInit;

return{
	check = function() return true; end;
	setPlugin = function(pl2) pl = pl2; end;
	buildUI = function()
		if not pl then repeat task.wait(); until pl; end;
		if buildInit then return 'Build already initialized!'; end;
		buildInit = true;
		local manifest = dc.getManifest(dc);
		local ver = manifest.ver;
		
		widgetInfo  = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float,false,false,350,200,150,150);
		widget = pl:CreateDockWidgetPluginGui('BASE', widgetInfo);
		widget.Title = 'BASE - build v'..ver;
		
		bg = Instance.new('Frame',widget);
		bg.Name = 'background';
		bg.Size = UDim2.fromScale(1,1);
		bg.BackgroundColor3 = Color3.fromRGB(34, 34, 34);
		local h = Instance.new('TextLabel',bg);
		h.Size = UDim2.fromScale(1,0.1);
		h.BackgroundTransparency = 1;
		h.Text = 'Made by AlreadyAsync';
		h.TextColor3 = Color3.fromRGB(255,255,255);
		h.Font = Enum.Font.Roboto;
		h.TextScaled = true;
		h.ZIndex = 2;
		local i = Instance.new('TextBox',bg);
		i.Name = 'command';
		i.Size = UDim2.fromScale(1,0.1);
		i.Position = UDim2.fromScale(0,0.9);
		i.ClearTextOnFocus = false;
		i.BackgroundTransparency = 1;
		i.PlaceholderText = 'BASE v'..ver..'! "@help" for a list of commands!'
		i.Text = '';
		i.PlaceholderColor3 = Color3.fromRGB(255,255,255);
		i.TextColor3 = Color3.fromRGB(255,255,255);
		i.Font = Enum.Font.Roboto;
		i.TextScaled = true;
		i.ZIndex = 2;
		local sf = Instance.new('ScrollingFrame',bg);
		sf.Name = 'logs';
		sf.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
		sf.Position = UDim2.fromScale(0, 0.1);
		sf.Size = UDim2.fromScale(1,0.8);
		sf.ZIndex = 2;
		sf.CanvasSize = UDim2.fromScale(0,0);
		sf.AutomaticSize = Enum.AutomaticSize.Y;
		sf.ClipsDescendants = true;
		local uiList = Instance.new('UIListLayout',sf);
		uiList.SortOrder = Enum.SortOrder.Name;
		uiList.FillDirection = Enum.FillDirection.Vertical;
		uiList.VerticalAlignment = Enum.VerticalAlignment.Bottom;
		local l = Instance.new('TextLabel',bg);
		l.Name = 'placeholder'; 
		l.Size = UDim2.fromScale(1,0.1);
		l.Visible = false;
		l.BackgroundTransparency = 1;
		l.Text = 'a fatal base error occured please report this!';
		l.TextColor3 = Color3.fromRGB(255,255,255);
		l.Font = Enum.Font.Roboto;
		l.TextScaled = true;
		l.ZIndex = 2;
		
		cc.init(widget);
	end;
	mod = {
		getUI = function() return bg; end;
	};
};
