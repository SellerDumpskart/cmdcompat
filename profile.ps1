# ============================================
# CMD Compatibility Layer for PowerShell
# https://github.com/SellerDumpskart/cmdcompat
# Updated 2026 | Remote-tool safe
# ============================================
# Install: irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/install.ps1 | iex
# ============================================

# =====================
# AUTO %VAR% EXPANSION
# Converts %TEMP%, %USERPROFILE% etc to actual values
# =====================
function Expand-CmdVars([string]$text) {
    [regex]::Replace($text, '%([^%]+)%', {
        param($match)
        $val = [System.Environment]::GetEnvironmentVariable($match.Groups[1].Value)
        if ($val) { $val } else { $match.Value }
    })
}

# =====================
# REMOVE CONFLICTING POWERSHELL ALIASES
# =====================
@('curl','move','copy','del','ren','rmdir','type','set','path','cls','color') | ForEach-Object {
    Remove-Item "Alias:$_" -Force -ErrorAction SilentlyContinue
}

# =====================
# CURL — real curl.exe with %VAR% expansion
# =====================
function curl {
    $expanded = $args | ForEach-Object { Expand-CmdVars "$_" }
    & curl.exe @expanded
}

# =====================
# CMD SHORTCUT — runs anything through CMD
# Usage: c start "" notepad
#        c dir /s /b *.log
#        c echo %TEMP%
# =====================
function c { & cmd.exe /c $($args -join ' ') }

# =====================
# CMD BUILT-IN COMMANDS
# These have no .exe — only exist inside cmd.exe
# =====================
function move { & cmd.exe /c "move $(Expand-CmdVars ($args -join ' '))" }
function copy { & cmd.exe /c "copy $(Expand-CmdVars ($args -join ' '))" }
function del { & cmd.exe /c "del $(Expand-CmdVars ($args -join ' '))" }
function ren { & cmd.exe /c "ren $(Expand-CmdVars ($args -join ' '))" }
function rmdir { & cmd.exe /c "rmdir $(Expand-CmdVars ($args -join ' '))" }
function type { & cmd.exe /c "type $(Expand-CmdVars ($args -join ' '))" }
function mklink { & cmd.exe /c "mklink $(Expand-CmdVars ($args -join ' '))" }
function assoc { & cmd.exe /c "assoc $(Expand-CmdVars ($args -join ' '))" }
function ftype { & cmd.exe /c "ftype $(Expand-CmdVars ($args -join ' '))" }
function vol { & cmd.exe /c "vol $(Expand-CmdVars ($args -join ' '))" }
function ver { & cmd.exe /c "ver $(Expand-CmdVars ($args -join ' '))" }
function title { & cmd.exe /c "title $(Expand-CmdVars ($args -join ' '))" }
function set { & cmd.exe /c "set $(Expand-CmdVars ($args -join ' '))" }
function color { & cmd.exe /c "color $(Expand-CmdVars ($args -join ' '))" }

# =====================
# NETWORK SHORTCUTS — call .exe directly
# =====================
function flushdns { & ipconfig.exe /flushdns }
function registerdns { & ipconfig.exe /registerdns }
function releaseip { & ipconfig.exe /release }
function renewip { & ipconfig.exe /renew }
function displaydns { & ipconfig.exe /displaydns }
function showip { & ipconfig.exe | Select-String "IPv4|IPv6" }
function showgateway { & ipconfig.exe | Select-String "Default Gateway" }
function showwifi { & netsh.exe wlan show interfaces }
function wifiprofiles { & netsh.exe wlan show profiles }
function wifidisconnect { & netsh.exe wlan disconnect }
function ports { & netstat.exe -ano | Select-String "LISTENING" }
function portfind { & netstat.exe -ano | Select-String $args[0] }
function connections { & netstat.exe -ano | Select-String "ESTABLISHED" }
function openports { & netstat.exe -an | Select-String "LISTENING" }
function routetable { & route.exe print }
function arptable { & arp.exe -a }
function showproxy { & netsh.exe winhttp show proxy }
function resetproxy { & netsh.exe winhttp reset proxy }
function fwstatus { & netsh.exe advfirewall show allprofiles state }
function netreset { & netsh.exe int ip reset; & netsh.exe winsock reset; & ipconfig.exe /flushdns; & ipconfig.exe /release; & ipconfig.exe /renew }
function winsockreset { & netsh.exe winsock reset }
function ipreset { & netsh.exe int ip reset }
function tcpreset { & netsh.exe int tcp reset }
function showdns { & netsh.exe interface ip show dnsservers }

# =====================
# FIREWALL SHORTCUTS
# =====================
function netshfwoff { & netsh.exe advfirewall set allprofiles state off }
function netshfwon { & netsh.exe advfirewall set allprofiles state on }
function netshfwreset { & netsh.exe advfirewall reset }
function netshfwshow { & netsh.exe advfirewall firewall show rule name=all }

# =====================
# PROCESS SHORTCUTS
# =====================
function fkill { & taskkill.exe /F /IM $($args -join ' ') }
function fpid { & taskkill.exe /F /PID $($args -join ' ') }

# =====================
# SYSTEM INFO SHORTCUTS
# =====================
function localusers { & net.exe user }
function localgroups { & net.exe localgroup }
function admins { & net.exe localgroup administrators }
function enableadmin { & net.exe user administrator /active:yes }
function disableadmin { & net.exe user administrator /active:no }
function whogroups { & whoami.exe /groups }
function whopriv { & whoami.exe /priv }
function whoall { & whoami.exe /all }
function savedcreds { & cmdkey.exe /list }
function services { & sc.exe query type= service state= all }
function drivers { & driverquery.exe /v /fo list }
function hotfixes { & wmic.exe qfe get HotFixID,InstalledOn,Description /format:table }
function lastpatch { & wmic.exe qfe get HotFixID,InstalledOn }
function installed { & wmic.exe product get name,version /format:list }
function startups { & wmic.exe startup get caption,command }
function diskhealth { & wmic.exe diskdrive get status,model,size }
function productkey { & wmic.exe path softwarelicensingservice get OA3xOriginalProductKey }
function envvars { & cmd.exe /c "set" }
function showpath { & cmd.exe /c "echo %PATH%" }

# =====================
# GROUP POLICY SHORTCUTS
# =====================
function gpforce { & gpupdate.exe /force /wait:0 }
function gpolist { & gpresult.exe /r /scope:computer; & gpresult.exe /r /scope:user }
function gpouser { & gpresult.exe /r /scope:user }
function gpocomputer { & gpresult.exe /r /scope:computer }
function gpoverify { & gpresult.exe /z }
function gpohtml { & gpresult.exe /h "$env:TEMP\gporeport.html"; Start-Process "$env:TEMP\gporeport.html" }

# =====================
# REGISTRY SHORTCUTS — use cmd.exe for reg commands
# =====================
function regquery { & cmd.exe /c "reg query $($args -join ' ')" }
function regadd { & cmd.exe /c "reg add $($args -join ' ')" }
function regdelete { & cmd.exe /c "reg delete $($args -join ' ')" }
function regexport { & cmd.exe /c "reg export $($args -join ' ')" }
function regimport { & cmd.exe /c "reg import $($args -join ' ')" }
function regbackup { & cmd.exe /c "reg export HKLM\SOFTWARE %TEMP%\HKLM_SOFTWARE_backup.reg /y & reg export HKLM\SYSTEM %TEMP%\HKLM_SYSTEM_backup.reg /y & reg export HKCU %TEMP%\HKCU_backup.reg /y & echo Backed up to %TEMP%" }

# =====================
# CERTIFICATE SHORTCUTS
# =====================
function showcerts { & certutil.exe -store my }
function rootcerts { & certutil.exe -store root }
function hashfile { & certutil.exe -hashfile $($args -join ' ') }
function verifycert { & certutil.exe -verify $($args -join ' ') }

# =====================
# ACTIVE DIRECTORY SHORTCUTS
# =====================
function domaininfo { & nltest.exe /dsgetdc:; & dsregcmd.exe /status }
function dclist { & nltest.exe /dclist: }
function trustinfo { & nltest.exe /domain_trusts /all_trusts }
function fsmo { & netdom.exe query fsmo }
function replstatus { & repadmin.exe /replsummary }
function replshow { & repadmin.exe /showrepl }
function adsite { & nltest.exe /dsgetsite }
function adkds { & dsquery.exe server -isgc }
function gcverify { & nltest.exe /dsgetdc: /gc }
function sitelink { & repadmin.exe /showconn }

# =====================
# WINDOWS UPDATE SHORTCUTS
# =====================
function wuscan { & usoclient.exe StartScan }
function wudownload { & usoclient.exe StartDownload }
function wuinstall { & usoclient.exe StartInstall }
function wureboot { & usoclient.exe RestartDevice }
function wuforce { & usoclient.exe StartScan; & usoclient.exe StartDownload; & usoclient.exe StartInstall }
function wustatus { & sc.exe query wuauserv; & sc.exe query bits; & sc.exe query cryptSvc }
function wulog { & wevtutil.exe qe Microsoft-Windows-WindowsUpdateClient/Operational /c:20 /rd:true /f:text }
function wuhistory { & wmic.exe qfe list full /format:table }
function wudisable { & sc.exe config wuauserv start= disabled; & sc.exe stop wuauserv }
function wuenable { & sc.exe config wuauserv start= auto; & sc.exe start wuauserv }

# =====================
# BYPASS TOGGLES — use cmd.exe for registry changes
# =====================
function defenderoff { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f" }
function defenderon { & cmd.exe /c "reg delete ""HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"" /v DisableRealtimeMonitoring /f" }
function uacoff { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"" /v EnableLUA /t REG_DWORD /d 0 /f" }
function uacon { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"" /v EnableLUA /t REG_DWORD /d 1 /f" }
function rdpon { & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server"" /v fDenyTSConnections /t REG_DWORD /d 0 /f & netsh advfirewall firewall set rule group=""remote desktop"" new enable=Yes" }
function rdpoff { & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server"" /v fDenyTSConnections /t REG_DWORD /d 1 /f & netsh advfirewall firewall set rule group=""remote desktop"" new enable=No" }
function nlaoff { & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"" /v UserAuthentication /t REG_DWORD /d 0 /f" }
function nlaon { & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"" /v UserAuthentication /t REG_DWORD /d 1 /f" }
function fastbootoff { & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v HiberbootEnabled /t REG_DWORD /d 0 /f" }
function fastbooton { & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v HiberbootEnabled /t REG_DWORD /d 1 /f" }
function showhidden { & cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v Hidden /t REG_DWORD /d 1 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v ShowSuperHidden /t REG_DWORD /d 1 /f" }
function showext { & cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v HideFileExt /t REG_DWORD /d 0 /f" }
function disabletelemetry { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"" /v AllowTelemetry /t REG_DWORD /d 0 /f"; & sc.exe config DiagTrack start= disabled; & sc.exe stop DiagTrack }
function disablecortana { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"" /v AllowCortana /t REG_DWORD /d 0 /f" }
function disableonedrive { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive"" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f" }
function taskbarclean { & cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v TaskbarMn /t REG_DWORD /d 0 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v TaskbarDa /t REG_DWORD /d 0 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v ShowTaskViewButton /t REG_DWORD /d 0 /f" }
function numlockon { & cmd.exe /c "reg add ""HKU\.DEFAULT\Control Panel\Keyboard"" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f" }
function autologon { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v AutoAdminLogon /t REG_SZ /d 1 /f & reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultUserName /t REG_SZ /d $($args[0]) /f & reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultPassword /t REG_SZ /d $($args[1]) /f" }
function autologoff { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v AutoAdminLogon /t REG_SZ /d 0 /f & reg delete ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultPassword /f" }
function wupause { & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseUpdatesExpiryTime /t REG_SZ /d ""2099-01-01T00:00:00"" /f" }
function wuresume { & cmd.exe /c "reg delete ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseUpdatesExpiryTime /f" }
function wuserver { & cmd.exe /c "reg query ""HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"" /s" }
function deliveryopt { & cmd.exe /c "reg query ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config""" }

# =====================
# BOOT AND POWER SHORTCUTS
# =====================
function safeboot { & bcdedit.exe /set "{current}" safeboot minimal }
function safebootnet { & bcdedit.exe /set "{current}" safeboot network }
function safebootoff { & bcdedit.exe /deletevalue "{current}" safeboot }
function bootinfo { & bcdedit.exe /enum }
function sleepoff { & powercfg.exe -change -standby-timeout-ac 0; & powercfg.exe -change -standby-timeout-dc 0 }
function hibernateoff { & powercfg.exe -h off }
function hibernateon { & powercfg.exe -h on }
function smb1off { & dism.exe /online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart }
function smb1on { & dism.exe /online /Enable-Feature /FeatureName:SMB1Protocol /NoRestart }

# =====================
# WSL SHORTCUTS
# =====================
function wsllist { & wsl.exe --list --verbose }
function wslshutdown { & wsl.exe --shutdown }
function wslstatus { & wsl.exe --status }
function wslupdate { & wsl.exe --update }

# =====================
# PACKAGE MANAGER SHORTCUTS
# =====================
function wingetinstall { & winget.exe install $($args -join ' ') }
function wingetsearch { & winget.exe search $($args -join ' ') }
function wingetupgrade { & winget.exe upgrade --all }
function wingetlist { & winget.exe list }

# =====================
# REPAIR AND CLEANUP
# =====================
function repair { & sfc.exe /scannow; & dism.exe /Online /Cleanup-Image /RestoreHealth }
function bitlocker { & cmd.exe /c "manage-bde -status" }
function activation { & cmd.exe /c "cscript //nologo C:\Windows\System32\slmgr.vbs /xpr" }
function cleartemp { Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue; Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "Temp files cleared" }
function wureset { & net.exe stop wuauserv; & net.exe stop cryptSvc; & net.exe stop bits; & net.exe stop msiserver; Rename-Item "C:\Windows\SoftwareDistribution" "SoftwareDistribution.old" -Force -ErrorAction SilentlyContinue; Rename-Item "C:\Windows\System32\catroot2" "catroot2.old" -Force -ErrorAction SilentlyContinue; & net.exe start wuauserv; & net.exe start cryptSvc; & net.exe start bits; & net.exe start msiserver; Write-Host "Windows Update components reset" }
function wucleardownload { & net.exe stop wuauserv; Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue; & net.exe start wuauserv; Write-Host "WU download cache cleared" }
function clearevt { Get-WinEvent -ListLog * -ErrorAction SilentlyContinue | ForEach-Object { & wevtutil.exe cl $_.LogName 2>$null }; Write-Host "Event logs cleared" }

# =====================
# SESSION SHORTCUTS
# =====================
function qusers { & quser.exe }
function sessions { & qwinsta.exe }

# =====================
# BRIDGE UTILITIES
# =====================
function run {
    param([string]$Block)
    $Block -split "`n" | ForEach-Object {
        $line = $_.Trim()
        if ($line -ne "") { & cmd.exe /c $line }
    }
}
function opencmd { Start-Process cmd.exe -ArgumentList "/k cd /d $PWD" }
function bg { Start-Process -FilePath $args[0] -ArgumentList ($args[1..$args.Length] -join ' ') -WindowStyle Hidden }
function bgmin { Start-Process -FilePath $args[0] -ArgumentList ($args[1..$args.Length] -join ' ') -WindowStyle Minimized }

# ============================================
# Remote-tool safe | No Write-Host | No .exe overrides
# ============================================
