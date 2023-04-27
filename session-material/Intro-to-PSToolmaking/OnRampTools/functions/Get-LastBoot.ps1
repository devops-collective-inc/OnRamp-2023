#requires -version 5.1

<#
This is an advanced version of the Get-LastBoot function.
It takes pipeline input, has verbose output, and error handling.
This is not material I would expect a beginner to write, and includes
concepts I did not cover in the session.
#>
Function Get-LastBoot {
    [cmdletbinding()]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$computername = $env:computername
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        #define hashtable of parameters to splat to Get-CimInstance
        $paramHash = @{
            class        = "Win32_OperatingSystem"
            ComputerName = $Null
            ErrorAction  = "Stop"
            Property     = "LastBootUpTime", "CSName", "Caption"
        }
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing"
        <#
        This is a scripting ForEach loop which is
        different from the ForEach-Object cmdlet.
        #>
        Foreach ($computer in $Computername) {
            $paramHash.computername = $computer
            #this is an example of error handling in PowerShell
            try {
                $data = Get-CimInstance @paramHash
                [PSCustomObject]@{
                    PSTypeName      = "PSLastBootInfo"
                    Computername    = $data.CSName
                    LastBoot        = $data.LastBootUpTime
                    OperatingSystem = $data.Caption
                }
            }
            catch {
                Write-Warning "There was an error: $($error[0].Exception.message)"
            }
        } #foreach computer
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
} #end function
