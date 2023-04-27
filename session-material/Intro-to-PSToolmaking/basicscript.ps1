$Computername = $env:COMPUTERNAME
#get errors and warnings from the system log
Get-WinEvent -FilterHashtable @{LogName="System";Level=2,3} -MaxEvents 20 -ComputerName $Computername