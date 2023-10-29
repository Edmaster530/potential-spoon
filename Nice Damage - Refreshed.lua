local _,data=...;  -- Addon Folder Name, AddonTable Data Object
PotentialSpoonAddon = LibStub("AceAddon-3.0"):NewAddon(data.MetaData.Name, "AceConsole-3.0");
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
                order = 1,
                type = "select",
                style = "dropdown",
                name = "Combat Text Font",
                values = data.FontLookup,
                set = function(_, value)
                    if PotentialSpoonAddon.db.global.damage_font == value then return end
                    DAMAGE_TEXT_FONT = data.FontDictionary[value];
                    PotentialSpoonAddon.db.global.damage_font = value;
                    PotentialSpoonAddon:Print("Restart Client for changes to take affect!");
                end,
                get = function(_)
                    return PotentialSpoonAddon.db.global.damage_font;
                end
            },
            desc0 = {
                order = 2,
                type = "description",
                name = "Combat Text Font (outside of self)"
                    .."\n"
                    .."\n"
                    .."Make sure to restart your client after selecting a preferred Combat Text font!"
                    .."\n"
                    .."Blizzard requires a client restart after setting the global Damage Font property."
            },
            self_font = {
                order = 3,
                type = "select",
                style = "dropdown",
                name = "Personal Combat Font",
                values = data.FontLookup,
                set = function(_, value)
                    if PotentialSpoonAddon.db.global.self_font == value then return end
                    CombatTextFont:SetFont(data.FontDictionary[value], COMBAT_TEXT_HEIGHT, "OUTLINE");
                    PotentialSpoonAddon.db.global.self_font = value;
                end,
                get = function(_)
                    return PotentialSpoonAddon.db.global.self_font;
                end
            },
            desc1 = {
                order = 4,
                type = "description",
                name = "Combat Text Font for Self"
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
    CombatTextFont:SetFont(data.FontDictionary[self.db.global.self_font], COMBAT_TEXT_HEIGHT, "OUTLINE");
    DAMAGE_TEXT_FONT = data.FontDictionary[self.db.global.damage_font];
end
