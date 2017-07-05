$path = "C:\mypath\"
$db = "DBSRV\INSTANCE"

Import-Module ActiveDirectory
Get-ADComputer -Filter * | Select -Expand Name | Out-File -filePath ($path + "ADComputer.out" ) 

Invoke-Sqlcmd -InputFile ( $path + "SQLCmd.sql" ) -ServerInstance $db | Out-File -filePath  ($path + "SQLCmd.out" )

$ADComputer = Get-Content ( $path + "ADComputer.out" )
$SQLCmd = Get-Content ( $path + "SQLCmd.out" )
$SQLCmd = $SQLCmd.Trim()
Compare-Object  $SQLCmd $ADComputer | Out-File -filePath ( $path + "diff.out" )
