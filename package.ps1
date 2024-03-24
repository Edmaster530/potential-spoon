<#
Curse uses the following files:
- Nice Damage - Refreshed.toc
- Nice Damage - Refreshed.lua
- variables.lua
- embeds.xml
- LICENSE
- Fonts\
- Libs\
#>

$destination = ".\Nice+Damage+-+Refreshed.zip"

$NDR_TOC = ".\Nice Damage - Refreshed.toc"
$NDR_LUA = ".\Nice Damage - Refreshed.lua"
$VARIABLES = ".\variables.lua"
$EMBEDS = ".\embeds.xml"
$LICENSE = ".\LICENSE"
$FONTS_DIR = ".\Fonts\"
$LIBS_DIR = ".\Libs\"

$NDR = "Nice Damage - Refreshed"

# we will clear out the folder if it exists
Write-Host "Removing" $NDR
Remove-Item $NDR -Recurse -ErrorAction Ignore
Write-Host "Removing" $destination
Remove-Item $destination -ErrorAction Ignore

# Curse requires a zip folder containing the name of the addon as a directory
# then we re-create it
New-Item -Path . -Name $NDR -ItemType directory
# we will move the files into this new directory
Copy-Item $NDR_TOC -Destination ".\$NDR"
Copy-Item $NDR_LUA -Destination ".\$NDR"
Copy-Item $VARIABLES -Destination ".\$NDR"
Copy-Item $EMBEDS -Destination ".\$NDR"
Copy-Item $VARIABLES -Destination ".\$NDR"
Copy-Item $LICENSE -Destination ".\$NDR"
Copy-Item $FONTS_DIR -Destination ".\$NDR" -Recurse
Copy-Item $LIBS_DIR -Destination ".\$NDR" -Recurse

Compress-Archive -Path $NDR -DestinationPath $destination
# now we remove the folder
Remove-Item $NDR -Recurse -ErrorAction Ignore

# Compress-Archive -Path $NDR_TOC, $NDR_LUA, $VARIABLES, $EMBEDS, $LICENSE -DestinationPath $destination
# Compress-Archive -Path $FONTS_DIR -DestinationPath $destination -Update
# Compress-Archive -Path $LIBS_DIR -DestinationPath $destination -Update
Write-Host "Archiving Complete"