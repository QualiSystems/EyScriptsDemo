#Set-ExecutionPolicy Unrestricted
$script_count=(get-item env:qsscript_count).Value
$script_name = ""
$output=""
$logspath="c:\qs_scripts_logs.txt"

#$pname=(get-item env:qspword).Value
#$uname=(get-item env:qsuname).Value
$execute_command=(get-item env:qsexecute_command).Value

New-Item $logspath -type file -force
Add-Content $logspath "`nstarts script download"

For ($i=1; $i -le $script_count; $i++) {
    $script_name ="qsscript{0}_url" -f $i
    Write-host  ( $script_name)
    $script_url=(get-item env:$script_name).Value
    Write-host  ( $script_url)	
	
	$fileName = $script_url.Substring($script_url.LastIndexOf("/")+1)
    $output="c:\\{0}" -f $fileName
	
    $msg= "`n downloading url : {0}"-f $script_url 
	Add-Content $logspath $msg
	
    Invoke-WebRequest -Uri $script_url -OutFile $output
}

#$msg= "`n got pass {0} and uname :{1} and execute command {2} "-f $pname,$uname,$execute_command
$msg= "`n got execute command {0} "-f $execute_command
Add-Content $logspath $msg

$msg= "`n executing the command {0} "-f $execute_command
Add-Content $logspath $msg

$msg= "`n psscriptroot : {0} :"-f $PSScriptRoot
Add-Content $logspath $msg


$cmd="c:\\{0}" -f $execute_command

$a = "powershell -file $cmd"
Invoke-Expression $a

#Invoke-Expression(start powershell ($cmd))
#Invoke-Item (start powershell ( $cmd))


