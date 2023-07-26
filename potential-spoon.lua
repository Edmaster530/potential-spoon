
local folder,data=...;  -- Addon Folder Name, AddonTable Data Object
PotentialSpoonAddon = LibStub("AceAddon-3.0"):NewAddon(folder);
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");

local base_options = {
    defaults = {
        profile = {},
        global = {
            damage_font = 1,
        },
    },
    options.fonts = {
        1 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\pepsi.ttf",
        2 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\basket-of-hammers.ttf",
        3 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\college.ttf",
        4 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\elite.ttf",
        5 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\galaxy-one.ttf",
        6 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\skratch-punk.ttf",
        7 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\stentiga.ttf",
        8 = "Interface\\Addons\\#69 Suffering - Refreshed\\Fonts\\zombie.ttf",
    },
};

--[[
    UI Types are "cmd" "dropdown" "dialog" (ignored)
    UI Name field is expected to contain the full name of the calling addon, including version (ignored)
    App Name field is the options table name as given at registration time
    <see href="https://www.wowace.com/projects/ace3/pages/api/ace-config-registry-3-0" />

    App Name options are stuck to one type, we don't have multiples
]]
function PotentialSpoonAddon:GetOptions(_, _, name)
    local options = {
        type = "group",
        name = self.MetaData.Name .. " (" .. self.MetaData.Version .. ")",
        args = {
            damage_font = {
                type = "select",
                style = "dropdown",
                name = "Font",
                values = base_options.fonts,
                set = function(_, value)
                    self.db.global.damage_font = value;
                    DAMAGE_TEXT_FONT = value;
                end
            },
        },
    }
end

--[[
    AceAddon Initialization Logic
]]
function PotentialSpoonAddon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New(data.DatabaseName, base_options.defaults, true);
    AceConfigRegistry:RegisterOptionsTable(folder, PotentialSpoonAddon.GetOptions);
    data.Dialog = AceConfigDialog:AddToBlizOptions(folder, data.MetaData.Name);
    -- setting the damage text font from the options configured
    DAMAGE_TEXT_FONT = PotentialSpoonAddon:SetFont(self.db.global.damage_font);
end
