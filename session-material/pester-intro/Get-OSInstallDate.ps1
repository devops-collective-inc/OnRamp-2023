function Get-OSInstallDate {
    [cmdletBinding()]
    Param([string]$Computername=$env:COMPUTERNAME)

    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computername
    $os.InstallDate
}
