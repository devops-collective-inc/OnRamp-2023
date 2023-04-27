#dot source the module functions

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {
    . $_.FullName
}

#add any other module related code here

Function Get-OnRampTools {
    [cmdletbinding()]
    Param()
    Get-Command -Module OnRampTools
}
