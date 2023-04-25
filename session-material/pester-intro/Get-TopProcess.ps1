function Get-TopProcess {
    [CmdletBinding()]
    Param(
        [ValidateScript({$_ -gt 0})]
        [int]$Count = 10,
        [string]$Computername = $env:COMPUTERNAME,
        [ValidateSet("WorkingSetSize","CreationDate","Handles","VirtualSize")]
        [string]$Property = "WorkingSetSize"
    )

    Try {
        $Data  = Get-CimInstance -ClassName Win32_Process -Computername $Computername -ErrorAction Stop
    }
    Catch {
        Throw $_
    }
    If ($data) {
        #for demonstrating mocking
#        $data | Out-String | Write-Host -ForegroundColor cyan
        #write the output to the pipeline
        $data | Sort-Object -property $Property -Descending |
        Select-Object -first $Count
    }
}
