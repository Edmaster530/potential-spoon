local _,data=...;
NDR = {};
NDR.Category = Settings.RegisterVerticalLayoutCategory("Nice Damage - Refreshed");

--[[
    Sets up the configuration values
]]
function NDR:ConfigureOptions()
    -- Font Selection --
    local name = "Font Selection";
    local tooltip = "Please remember to logout and back in for combat text!";
    local variable = "NDR_FONT";
    local defaultValue = NDR_FONT;

    local setting = Settings.RegisterProxySetting(NDR.Category, variable,
        Settings.VarType.Number, name, defaultValue, function()
            return NDR_FONT;
        end, function(value)
            NDR_FONT = value;
            NDR:SetFont();
        end);
    setting:SetValueChangedCallback(function(setting, value) NDR:OnSettingChanged(setting, value); end);

    local function GetOptions()
        local container = Settings.CreateControlTextContainer();
        for key,value in pairs(data.FontDictionary) do
            container:Add(key, data.FontLookup[key]);
        end
        return container:GetData();
    end

    Settings.CreateDropdown(NDR.Category, setting, GetOptions, tooltip);
    -- End Font Selection --

    -- Font Size --
    local min = 0.5;
    local max = 5;
    name = "Font Size";
    variable = "NDR_FONT_SIZE";
    defaultValue = NDR_FONT_SIZE;

    setting = Settings.RegisterProxySetting(NDR.category, variable,
        Settings.VarType.Number, name, defaultValue, function()
            return NDR_FONT_SIZE;
        end, function(value)
            NDR_FONT_SIZE = value;
            NDR:SetFont();
        end);
    setting:SetValueChangedCallback(function(setting, value) NDR:OnSettingChanged(setting, value); end);
    local options = Settings.CreateSliderOptions(min, max, 0.25);
    options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
    Settings.CreateSlider(NDR.Category, setting, options, "This is still a work in progress, it applies to the Scale of the Text");
    -- End Font Size --
end

function NDR:OnSettingChanged(setting, value)
    -- this callback will be invoked whenever a setting is modified
    -- TODO - maybe add prompt to end user
    if setting:GetVariable() == "NDR_FONT" then
        NDR_FONT = value;
    else
        NDR_FONT_SIZE = value;
    end
end

function NDR:Initialize()
    local frame = CreateFrame("Frame");
    frame:RegisterEvent("ADDON_LOADED");
    frame:SetScript("OnEvent", function(self, event, arg1)
        if event ~= "ADDON_LOADED" or arg1 ~= "Nice Damage - Refreshed" then
            return;
        end

        if NDR_FONT == nil then
            NDR_FONT = 1;
        end
        if NDR_FONT_SIZE == nil then
            NDR_FONT_SIZE = 16;
        end

        NDR:SetFont();
        NDR:ConfigureOptions();
        Settings.RegisterAddOnCategory(NDR.Category);
    end);
end

function NDR:SetFont()
    CombatTextFont:SetFont(data.FontDictionary[NDR_FONT], 16, "OUTLINE");
     CombatText:SetScale(NDR_FONT_SIZE);
    DAMAGE_TEXT_FONT = data.FontDictionary[NDR_FONT];
end

NDR:Initialize();
