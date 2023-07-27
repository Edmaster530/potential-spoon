local _,data=...;  -- Addon Folder Name, AddonTable Data Object
PotentialSpoonAddon = LibStub("AceAddon-3.0"):NewAddon(data.Directory);
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");

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
                    DAMAGE_TEXT_FONT = data.FontDictionary[value];
                    STANDARD_TEXT_FONT = data.FontDictionary[value];
                    NAMEPLATE_SPELLCAST_FONT = data.FontDictionary[value];
                    UNIT_NAME_FONT = data.FontDictionary[value];
                    CombatTextFont = data.FontDictionary[value];
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
    -- setting the damage text font from the options configured
    DAMAGE_TEXT_FONT = data.FontDictionary[self.db.global.damage_font];
    STANDARD_TEXT_FONT = data.FontDictionary[self.db.global.damage_font];
    NAMEPLATE_SPELLCAST_FONT = data.FontDictionary[self.db.global.damage_font];
    UNIT_NAME_FONT = data.FontDictionary[self.db.global.damage_font];
    CombatTextFont = data.FontDictionary[self.db.global.damage_font];
end
