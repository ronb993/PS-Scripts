# Error code for success: '3231711234' but converts --> '-1063256062'


# Read file line by line
$comp_list = Get-Content "C:\ps-scripts\computernames.txt"

$myScript = {

	#needed for -ArgumentList to work
	param($online)

	$computers = $online

	foreach($computer in $computers){
		$Result = bdehdcfg -driveinfo

		if($LASTEXITCODE -eq -1063256062){
			Write-Host -ForegroundColor Green $computer ": Is properly Configured"
			write-output $computer >> c:\ps-scripts\successs.txt


}

		else{

			Write-Host -ForegroundColor Red $computer ": Is not configured"
}


}

}



# iterate through the list
foreach($item in $comp_list) {

# test the connection
	if(Test-Connection -ComputerName $item -Buffersize 16 -Count 1 -Quiet){

		$online = $item

		Invoke-Command -ComputerName $online -ArgumentList $online -ScriptBlock $myScript
}

	else{

		$badhost = $item
		Write-Host -ForegroundColor Red $badhost ": is offline or icmp is blocked"

}



}




