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
                    PotentialSpoonAddon.db.global.damage_font = value;
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
                    .."\n"
                    .."Self-Font is the only font that is height adjustable."
                    .."\n"
                    .."\n"
            },
            font_size = {
                order = 5,
                name = "Personal Combat Font Size",
                type = "range",
                min = 1,
                step = 1,
                max = 100,
                get = function(_)
                    return PotentialSpoonAddon.db.global.font_size;
                end,
                set = function(_, value)
                    PotentialSpoonAddon.db.global.font_size = value;
                end
            },
            revert = {
                order = 5,
                type = "execute",
                name = "Reset",
                func = function()
                    PotentialSpoonAddon.db.global.font_size = PotentialSpoonAddon.db.global.default_size;
                end
            },
            desc2 = {
                order = 6,
                type = "description",
                name = "\n"
                    .."\n"
            },
            apply = {
                order = -1,
                type = "execute",
                name = "Save Changes",
                func = function()
                    local original = DAMAGE_TEXT_FONT;
                    if original ~= data.FontDictionary[PotentialSpoonAddon.db.global.damage_font] then
                        StaticPopup_Show("ND_CONFIRM");
                    end
                    CombatTextFont:SetFont(data.FontDictionary[PotentialSpoonAddon.db.global.self_font], PotentialSpoonAddon.db.global.font_size, "OUTLINE");
                    DAMAGE_TEXT_FONT = data.FontDictionary[PotentialSpoonAddon.db.global.damage_font];
                    -- StaticPopup_Show("ND_CONFIRM");
                end
            }
        },
    };
end

--[[
    AceAddon Initialization Logic
]]
function PotentialSpoonAddon:OnInitialize()
    -- set up a static confirmation dialog box
    StaticPopupDialogs["ND_CONFIRM"] = {
        text = "Please make sure to restart your client for changes to take affect!",
        button1 = "Understood",
        OnAccept = function()
            PotentialSpoonAddon:Print("Restart Client for changes to take affect!");
        end,
        timeout = 0,
        whileDead = false,
        hideOnEscape = true
    };

    self.db = LibStub("AceDB-3.0"):New(data.DatabaseName, data.DefaultOptions, true);
    AceConfigRegistry:RegisterOptionsTable(data.MetaData.Name, PotentialSpoonAddon.GetOptions);
    data.Dialog = AceConfigDialog:AddToBlizOptions(data.MetaData.Name, data.MetaData.Name);
    CombatTextFont:SetFont(data.FontDictionary[self.db.global.self_font], PotentialSpoonAddon.db.global.font_size, "OUTLINE");
    DAMAGE_TEXT_FONT = data.FontDictionary[self.db.global.damage_font];
end
