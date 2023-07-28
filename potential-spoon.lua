local _,data=...;  -- Addon Folder Name, AddonTable Data Object
PotentialSpoonAddon = LibStub("AceAddon-3.0"):NewAddon(data.Directory);
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");

function PotentialSpoonAddon:SetupFont(value)
    -- setting the damage text font from the options configured
    DAMAGE_TEXT_FONT = data.FontDictionary[PotentialSpoonAddon.db.global.damage_font];
    CombatTextFont:SetFont(DAMAGE_TEXT_FONT, COMBAT_TEXT_HEIGHT, "OUTLINE");
    -- message("Game CLIENT Restart required in order for Font Changes to take affect!");
end

--[[
    UI Types are "cmd" "dropdown" "dialog" (ignored)
    UI Name field is expected to contain the full name of the calling addon, including version (ignored)
    App Name field is the options table name as given at registration time
    <see href="https://www.wowace.com/projects/ace3/pages/api/ace-config-registry-3-0" />

    App Name options are stuck to one type, we don't have multiples
]]
function PotentialSpoonAddon:GetOptions(_, _, name)
    return {
        type = "group",
        name = data.MetaData.Name .. " (" .. data.MetaData.Version .. ")",
        args = {
            damage_font = {
                type = "select",
                style = "dropdown",
                name = "Font",
                values = data.FontLookup,
                set = function(_, value)
                    PotentialSpoonAddon.db.global.damage_font = value;
                    PotentialSpoonAddon:SetupFont(value);
                end,
                get = function(_)
                    return PotentialSpoonAddon.db.global.damage_font;
                end
            },
        },
    };
end

--[[
    AceAddon Initialization Logic
]]
function PotentialSpoonAddon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(data.DatabaseName, data.DefaultOptions, true);
    AceConfigRegistry:RegisterOptionsTable(data.MetaData.Name, PotentialSpoonAddon.GetOptions);
    data.Dialog = AceConfigDialog:AddToBlizOptions(data.MetaData.Name, data.MetaData.Name);
    self.SetupFont(self.db.global.damage_font);
end
