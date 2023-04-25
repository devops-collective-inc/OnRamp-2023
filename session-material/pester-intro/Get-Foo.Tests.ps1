BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Foo" {
    It "Returns expected output" {
        Get-Foo | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
