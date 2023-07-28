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
        self_font = 1
    },
};

data.Dialog = {};
data.FontDictionary = {};
data.FontDictionary[1] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\af-pepsi.ttf";
data.FontDictionary[2] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\basket-of-hammers.ttf";
data.FontDictionary[3] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\college.ttf";
data.FontDictionary[4] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\elite.ttf";
data.FontDictionary[5] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\galaxy-one.ttf";
data.FontDictionary[6] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\skratch-punk.ttf";
data.FontDictionary[7] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\stentiga.ttf";
data.FontDictionary[8] = "Interface\\Addons\\" .. data.Directory .. "\\Fonts\\zombie.ttf";
data.FontLookup = {};
data.FontLookup[1] = "AF Pepsi";
data.FontLookup[2] = "Basket of Hammers";
data.FontLookup[3] = "College";
data.FontLookup[4] = "Elite";
data.FontLookup[5] = "Galaxy 1";
data.FontLookup[6] = "Skratch Punk";
data.FontLookup[7] = "Stentiga";
data.FontLookup[8] = "Zombie";