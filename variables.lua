local folder,data=...;

-- Addon Constants --
data.DatabaseName = "PotentialSpoonDB";
data.MetaData = {
    Name = GetAddOnMetadata(..., "Title"),
    Version = GetAddOnMetadata(..., "Version"),
    Notes = GetAddOnMetadata(..., "Notes"),
};
data.Dialog = {};