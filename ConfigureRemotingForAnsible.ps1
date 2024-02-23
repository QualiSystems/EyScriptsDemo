winrm quickconfig -q
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
Start-Service WinRM
set-service WinRM -StartupType Automatic
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled false

If ((Get-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation').GetValue("ActiveTimeBias") -eq $null)
{ New-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation' -Name "ActiveTimeBias" -Value "480" -Type "DWord" -Force | Out-Null }
