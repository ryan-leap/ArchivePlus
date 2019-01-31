# Dot source all functions in all ps1 files located in the module's public and private folders, excluding tests and profiles.
# Followed template created by Mike Robbins here: https://github.com/mikefrobbins/Plaster
Get-ChildItem -Path $PSScriptRoot\public\*.ps1, $PSScriptRoot\private\*.ps1 -Exclude *.tests.ps1, *profile.ps1 -ErrorAction SilentlyContinue |
ForEach-Object {
    . $_.FullName
}