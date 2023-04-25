BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-OSInstallDate" {
    It "Returns a date time object" {
        Get-OSInstallDate | Should -BeOfType [DateTime]
    }
}
