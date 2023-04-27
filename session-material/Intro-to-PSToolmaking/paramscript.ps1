Param(
    [Parameter(Position = 0)]
    [string]$Computername = $env:COMPUTERNAME,
    [Parameter(Mandatory,HelpMessage = "Enter the name of the log to query")]
    [ValidateNotNullOrEmpty()]
    [string]$LogName,
    [Parameter(HelpMessage = "Enter the number of events to retrieve")]
    [int]$Count = 20,
    [Parameter(HelpMessage = "Enter the path to save the report")]
    [ValidateScript({Test-Path $_})]
    [string]$Path = "."
)

#a script version used in the HTML report
$scriptVersion = '1.0.0'
#build a filename
$fileName = "$($ComputerName.toUpper())-$(Get-Date -format yyyy_MM-dd-hh-mm).html"
$reportPath = Join-Path -Path $Path -ChildPath $fileName

#this script has no error handling for the sake of simplicity
$data = Get-WinEvent -FilterHashtable @{LogName = $LogName; Level = 2, 3 } -MaxEvents $Count -ComputerName $Computername

$group = $data | Group-Object -Property ProviderName
#create a collection of HTML fragments
$fragments = @()
$fragments += "<H1>$($data[0].MachineName)</H1>"

foreach ($item in $group) {
    $fragments += "<H2>$($item.Name)</H2>"
    $fragments += $group[0].group | Select-Object -Property TimeCreated, ID, LevelDisplayName, Message |
    ConvertTo-Html -As Table -Fragment
}

#define a here string for the html header
$head = @"
<style>
body { background-color:#FAFAFA;
    font-family:Arial;
    font-size:12pt; }
td, th { border:1px solid black;
        border-collapse:collapse; }
th { color:white;
    background-color:black; }
table, tr, td, th { padding: 2px; margin: 0px }
tr:nth-child(odd) {background-color: lightgray}
table { margin-left:50px; }
img
{
float:left;
margin: 0px 25px;
}
</style>
<br>
"@

#HTML to display at the end of the report
$footer = @"
<br>
<i>
Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: $(Get-Date)<br>
Author&nbsp;&nbsp;: $env:USERDOMAIN\$env:username<br>
Script&nbsp;&nbsp;&nbsp;: $(Convert-Path $MyInvocation.InvocationName)<br>
Version: $scriptVersion<br>
Source&nbsp;: $($Env:COMPUTERNAME)<br>
</i>
"@

#create the HTML document
ConvertTo-HTML -Head $head -Body $fragments -PostContent $footer |
Out-File -FilePath $reportPath

Get-Item -path $reportPath