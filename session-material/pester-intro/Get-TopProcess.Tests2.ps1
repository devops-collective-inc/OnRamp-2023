BeforeAll {
    . $PSCommandPath.Replace('.Tests2.ps1', '.ps1')
}

#region test with mocking
Describe 'Get-TopProcess' {

    BeforeAll {
        $cmd = Get-Command -Name Get-TopProcess
        Mock Get-CimInstance {
            Write-Host 'I am mocked' -ForegroundColor yellow
            Write-Error 'Fail'
        } -ParameterFilter { $Computername -eq 'Foo' }

        Mock Get-CimInstance {
            Write-Host 'Mocking with localhost' -ForegroundColor green
            return @{Name = 'foo'; ProcessID = 123; WorkingSetSize = 12345 }
        } -ParameterFilter { $Computername -eq $env:COMPUTERNAME }

        Mock Get-CimInstance {
            Return [PSCustomObject]@{
                PSTypeName     = 'Microsoft.Management.Infrastructure.CimInstance'
                WorkingSetSize = 10MB
                VirtualSize    = 20MB
                Name           = 'foo'
                Handles        = 100
                CreationDate   = (Get-Date).AddMinutes(-5)
            }

        } -ParameterFilter { $Computername -eq 'SRV' }
    }
    It 'Should run with default values' {
        { Get-TopProcess } | Should -Not -Throw
    }
    It 'Should accept a value for the number of processes' {
        (Get-TopProcess -count 1 -Computername SRV).Count | Should -BeExactly 1
    }
    It 'Should accept a computername as a parameter value.' {
        $cmd.Parameters.ContainsKey('Computername') | Should -BeTrue
    }
    It 'Should let the user select the property' {
        $cmd.Parameters.ContainsKey('Property') | Should -BeTrue
    }
    It 'Should work on a pre-defined set of properties' {

    } -pending
    It 'Should fail with a bad computername' {
        { Get-TopProcess -Computername FOO } | Should -Throw
    }
    It 'Should fail on a negative number' {
        { Get-TopProcess -count -10 } | Should -Throw
    }
}
#endregion