return "This is a demo script file. Run in VSCode or the PowerShell ISE"

Import-Module Pester
Get-Module Pester
Get-Command -module Pester

#start a new project

#region  New-Fixture -Name Get-Foo
psedit .\Get-Foo.ps1
psedit .\Get-Foo.Tests.ps1
Invoke-Pester .\Get-Foo.Tests.ps1
#endregion

#region New-Fixture Get-OSInstallDate
psedit .\Get-OSInstallDate.Tests.ps1
psedit .\Get-OSInstallDate.ps1

Invoke-Pester .\Get-OSInstallDate.Tests.ps1
#legacy syntax
invoke-Pester .\Get-OSInstallDate.Tests.ps1 -Show All

#endregion

#region New-Fixture -name Get-TopProcess
psedit .\Get-TopProcess.Tests.ps1
psedit .\Get-TopProcess.ps1

Invoke-Pester .\Get-TopProcess.Tests.ps1 -show all
#add mocking
psedit .\Get-TopProcess.Tests2.ps1
Invoke-Pester .\Get-TopProcess.Tests2.ps1 -show all

#endregion

#region A real-world set of tests

https://github.com/jdhitsolutions/PSFunctionTools/tree/main/tests

# psedit C:\scripts\PSFunctionTools\tests\psfunctiontools.tests.ps1
# psedit C:\scripts\PSFunctionTools\tests\runtests.ps1
# C:\scripts\PSFunctionTools\tests\runtests.ps1

#endregion