local _,data=...;

-- Addon Constants --
data.Directory = "potential-spoon";
data.DatabaseName = "PotentialSpoonDB";
data.MetaData = {
    Name = GetAddOnMetadata(..., "Title"),
    Version = GetAddOnMetadata(..., "Version"),
    Notes = GetAddOnMetadata(..., "Notes"),
};

data.DefaultOptions = {
    profile = {},
    global = {
        damage_font = 1,
    },
};

-- Testing to check for local global variables that might be available
local AceGUI = LibStub("AceGUI-3.0");
local scrollcontainer = AceGUI:Create("SimpleGroup");
scrollcontainer:SetFullWidth(true);
scrollcontainer:SetLayout("Fill");
-- Create a container frame
local f = AceGUI:Create("Frame")
f:SetCallback("OnClose",function(widget) AceGUI:Release(widget) end)
f:SetTitle("AceGUI-3.0 Example")
f:SetLayout("Flow")
f:AddChild(scrollcontainer);

local scroll = AceGUI:Create("ScrollFrame");
scroll:SetLayout("Flow");
scrollcontainer:AddChild(scroll);

local str = "";
for k,v in pairs(_G) do
    if string.find(k, "FONT") and not string.find(k, "COLOR") then
        str = str .. "\n" .. k;
    end
end

local edit = AceGUI:Create("MultiLineEditBox");
edit:SetText(str);
edit:SetLabel("Global Variables");
f:AddChild(edit);

data.Dialog = {};
data.FontDictionary = {};
data.FontDictionary[1] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\pepsi.ttf";
data.FontDictionary[2] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\basket-of-hammers.ttf";
data.FontDictionary[3] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\college.ttf";
data.FontDictionary[4] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\elite.ttf";
data.FontDictionary[5] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\galaxy-one.ttf";
data.FontDictionary[6] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\skratch-punk.ttf";
data.FontDictionary[7] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\stentiga.ttf";
data.FontDictionary[8] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\zombie.ttf";
data.FontLookup = {};
data.FontLookup[1] = "! PEPSI !";
data.FontLookup[2] = "Basket of Hammers";
data.FontLookup[3] = "College";
data.FontLookup[4] = "Elite";
data.FontLookup[5] = "Galaxy 1";
data.FontLookup[6] = "Skratch Punk";
data.FontLookup[7] = "Stentiga";
data.FontLookup[8] = "Zombie";