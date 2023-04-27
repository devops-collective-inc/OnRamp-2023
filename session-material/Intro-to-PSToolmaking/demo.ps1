return "This is a demo script file."

<#
terminology
cmdlet: a powershell command
function: a powershell command defined in a script
script: a file containing powershell commands
module: a collection of cmdlets and functions
toolmaking: the process of creating cmdlets, functions, and modules
#>

<#
Toolmaking decisions and planning
- what is the purpose of the tool?
- Who will use the tools?
- What is their expectation?
- Plan for the unexpected. You don't
know how or where parameter values will come from.
#>

#cmdlets
Get-WinEvent -LogName system -MaxEvents 20 -ComputerName $env:COMPUTERNAME

#region scripts
#basic script
psedit .\basicscript.ps1

#parameterized script
psedit .\paramscript.ps1
#endregion

#region functions
psedit .\basic-function.ps1
psedit .\Get-CriticalEventLogEntry.ps1
psedit .\Get-LastBoot.ps1
#endregion

#region modules
# module terms and basics
$env:PSModulePath -split ';'

# New-Item -name OnRampTools -Path . -ItemType Directory
cd .\OnRampTools

'en-US', 'docs', 'functions', 'tests', 'formats', 'types' | ForEach-Object {
    # New-Item -Name $_  -path . -ItemType Directory
}

# copy ..\Get-CriticalEventLogEntry.ps1 -Destination .\functions\
# copy ..\Get-LastBoot.ps1 -Destination .\functions\

#create the module file
New-Item -Name OnRampTools.psm1 -ItemType File
psedit .\OnRampTools.psm1

#create the manifest
help New-ModuleManifest
#paramter hashtable to splat to New-ModuleManifest
$paramHash = @{
    Path              = '.\OnRampTools.psd1'
    Author            = 'Jeff Hicks'
    Description       = 'OnRamp management PowerShell Tools'
    RootModule        = 'OnRampTools.psm1'
    FunctionsToExport = 'Get-LastBoot', 'Get-OnRampTools', 'Get-CriticalEventLogEntry'
}

New-ModuleManifest @paramHash
psedit .\OnRampTools.psd1

#test the module
Import-Module .\OnRampTools.psd1 -force
Get-OnRampTools
Get-LastBoot

help Get-LastBoot

#create help docs
# Install-Module Platyps
Get-Command -module Platyps
New-MarkdownHelp -Module OnRampTools -OutputFolder .\docs

#create external help
New-ExternalHelp -Path .\docs -OutputPath .\en-US -force
Import-Module .\OnRampTools.psd1 -force
help Get-LastBoot
#other files
    # changelog
    #  Import-Module
    # New-ChangeLog -path .\OnRampTools\CHANGELOG.md
    # license
    # Copy c:\scripts\license.txt .\OnRampTools\LICENSE.txt
    # readme


#endregion
