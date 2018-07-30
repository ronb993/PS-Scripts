# This script is used to check multiple computers from a list to see if bitlocker needs to create
# A new partition or if bitlocker is configured properly. Changes will have to be made to create a bitlocker partition
# Error code for success: '3231711234' but converts --> '-1063256062'
# Make sure you have permissions to run the script (Enable-PSRemoting -Force)
# Add your host or ips in the computer list and make sure you have a folder for output


$err=@()

$computerlist = Get-Content "computernames.txt"

$myScript={
	param($computername)
	$Result = BdeHdCfg.exe -driveinfo
	$theErrors = $computername + $Result
	if($LASTEXITCODE -eq -1063256062){
		Write-Host -ForegroundColor Green $computername ": Is properly Configured"
		write-output $computername >> C:\somepath\success.txt
	}

	else{

		Write-Host -ForegroundColor Red $computername `
		"Exit code is different or not properly configured, check logs"
	}

	Write-Output $err | Out-File -Append -FilePath C:\somepath\error.txt
	Write-Output $theErrors | Out-File -Append -FilePath C:\somepath\bde-log.txt
}



foreach($computername in $computerlist){
	Invoke-Command -ComputerName $computername `
	-ArgumentList $computername -ScriptBlock $myScript `
	-EA SilentlyContinue -ErrorVariable +err

}
    

