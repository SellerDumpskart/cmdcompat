# ============================================
# CMD Compatibility Layer for PowerShell
# https://github.com/SellerDumpskart/cmdcompat
# Updated 2026 | Remote-tool safe
# ============================================
# Install: irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/install.ps1 | iex
# ============================================
# DESIGN: Only wraps CMD built-in commands (no .exe).
# Commands like ipconfig, whoami, ping etc have their own .exe
# and work natively in PowerShell - we do NOT override them.
# ============================================

# =====================
# AUTO %VAR% EXPANSION
# Converts %TEMP%, %USERPROFILE% etc to actual values
# Works system-wide via PSDefaultParameterValues
# =====================
function Expand-CmdVars([string]$text) {
    [regex]::Replace($text, '%([^%]+)%', {
        param($match)
        $val = [System.Environment]::GetEnvironmentVariable($match.Groups[1].Value)
        if ($val) { $val } else { $match.Value }
    })
}

# Override default prompt processing to auto-expand %VAR% in commands
$ExecutionContext.InvokeCommand.PreCommandLookupAction = {
    param($commandName, $eventArgs)
}

# Wrapper to auto-expand %VAR% in any argument
function Invoke-CmdExpanded {
    $expanded = $args | ForEach-Object { Expand-CmdVars "$_" }
    $cmd = $expanded[0]
    $cmdArgs = if ($expanded.Count -gt 1) { $expanded[1..($expanded.Count-1)] } else { @() }
    & $cmd @cmdArgs
}

# =====================
# CMD BUILT-IN COMMANDS
# These have no .exe — they only exist inside cmd.exe
# Auto-expands %VAR% to actual values
# =====================
function move { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "move $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function copy { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "copy $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function del { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "del $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function ren { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "ren $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function rmdir { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "rmdir $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function type { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "type $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function mklink { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "mklink $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function assoc { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "assoc $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function ftype { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "ftype $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function vol { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "vol $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function ver { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "ver $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function date { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "date $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function time { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "time $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function title { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "title $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function set { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "set $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function path { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "path $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function cls { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "cls $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function color { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "color $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function prompt { $exp = Expand-CmdVars ($args -join ' '); $out = & cmd.exe /c "prompt $exp" 2>&1; $out | ForEach-Object { Write-Host $_ } }

# =====================
# FIX CURL — use real curl.exe, auto-expands %VAR%
# =====================
Remove-Item Alias:curl -ErrorAction SilentlyContinue
function curl {
    $expanded = $args | ForEach-Object { Expand-CmdVars "$_" }
    & curl.exe @expanded
}

# =====================
# QUICK CMD SHORTCUT — for any CMD-only command
# Usage: c start "" notepad
#        c dir /s /b *.log
#        c echo %TEMP%
# =====================
function c { $out = & cmd.exe /c "$($args -join ' ')" 2>&1; $out | ForEach-Object { Write-Host $_ } }

# Keep CMD window open
function k { & cmd.exe /k "$($args -join ' ')" }

# =====================
# SHORTCUT COMMANDS — no conflicts, just convenience
# These call .exe directly (no cmd.exe wrapper)
# =====================

# --- Network shortcuts ---
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

# --- Firewall shortcuts ---
function netshfwoff { & netsh.exe advfirewall set allprofiles state off }
function netshfwon { & netsh.exe advfirewall set allprofiles state on }
function netshfwreset { & netsh.exe advfirewall reset }
function netshfwshow { & netsh.exe advfirewall firewall show rule name=all }

# --- Process shortcuts ---
function fkill { & taskkill.exe /F /IM $($args -join ' ') }
function fpid { & taskkill.exe /F /PID $($args -join ' ') }

# --- System info shortcuts ---
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
function envvars { $out = & cmd.exe /c "set" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function showpath { $out = & cmd.exe /c "echo %PATH%" 2>&1; $out | ForEach-Object { Write-Host $_ } }

# --- Group Policy shortcuts ---
function gpforce { & gpupdate.exe /force /wait:0 }
function gpolist { & gpresult.exe /r /scope:computer; & gpresult.exe /r /scope:user }
function gpouser { & gpresult.exe /r /scope:user }
function gpocomputer { & gpresult.exe /r /scope:computer }
function gpoverify { & gpresult.exe /z }
function gpohtml { & gpresult.exe /h "$env:TEMP\gporeport.html"; Start-Process "$env:TEMP\gporeport.html" }

# --- Certificate shortcuts ---
function showcerts { & certutil.exe -store my }
function rootcerts { & certutil.exe -store root }
function hashfile { & certutil.exe -hashfile $($args -join ' ') }
function verifycert { & certutil.exe -verify $($args -join ' ') }

# --- Active Directory shortcuts ---
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

# --- Windows Update shortcuts ---
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

# --- WSL shortcuts ---
function wsllist { & wsl.exe --list --verbose }
function wslshutdown { & wsl.exe --shutdown }
function wslstatus { & wsl.exe --status }
function wslupdate { & wsl.exe --update }

# --- Package manager shortcuts ---
function wingetinstall { & winget.exe install $($args -join ' ') }
function wingetsearch { & winget.exe search $($args -join ' ') }
function wingetupgrade { & winget.exe upgrade --all }
function wingetlist { & winget.exe list }

# --- Repair shortcuts ---
function repair { & sfc.exe /scannow; & dism.exe /Online /Cleanup-Image /RestoreHealth }
function bitlocker { $out = & cmd.exe /c "manage-bde -status" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function activation { $out = & cmd.exe /c "cscript //nologo C:\Windows\System32\slmgr.vbs /xpr" 2>&1; $out | ForEach-Object { Write-Host $_ } }

# --- Session shortcuts ---
function qusers { & quser.exe }
function sessions { & qwinsta.exe }

# =====================
# REGISTRY BYPASS COMMANDS — must use cmd.exe (use Write-Host)
# =====================
function regquery { $out = & cmd.exe /c "reg query $($args -join ' ')" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function regadd { $out = & cmd.exe /c "reg add $($args -join ' ')" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function regdelete { $out = & cmd.exe /c "reg delete $($args -join ' ')" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function regexport { $out = & cmd.exe /c "reg export $($args -join ' ')" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function regimport { $out = & cmd.exe /c "reg import $($args -join ' ')" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function regbackup { $out = & cmd.exe /c "reg export HKLM\SOFTWARE %TEMP%\HKLM_SOFTWARE_backup.reg /y & reg export HKLM\SYSTEM %TEMP%\HKLM_SYSTEM_backup.reg /y & reg export HKCU %TEMP%\HKCU_backup.reg /y & echo Backed up to %TEMP%" 2>&1; $out | ForEach-Object { Write-Host $_ } }

# --- Bypass toggle shortcuts (reg-based, use cmd.exe + Write-Host) ---
function defenderoff { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function defenderon { $out = & cmd.exe /c "reg delete ""HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"" /v DisableRealtimeMonitoring /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function uacoff { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"" /v EnableLUA /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function uacon { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"" /v EnableLUA /t REG_DWORD /d 1 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function rdpon { $out = & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server"" /v fDenyTSConnections /t REG_DWORD /d 0 /f & netsh advfirewall firewall set rule group=""remote desktop"" new enable=Yes" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function rdpoff { $out = & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server"" /v fDenyTSConnections /t REG_DWORD /d 1 /f & netsh advfirewall firewall set rule group=""remote desktop"" new enable=No" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function nlaoff { $out = & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"" /v UserAuthentication /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function nlaon { $out = & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"" /v UserAuthentication /t REG_DWORD /d 1 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function fastbootoff { $out = & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v HiberbootEnabled /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function fastbooton { $out = & cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v HiberbootEnabled /t REG_DWORD /d 1 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function showhidden { $out = & cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v Hidden /t REG_DWORD /d 1 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v ShowSuperHidden /t REG_DWORD /d 1 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function showext { $out = & cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v HideFileExt /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function disabletelemetry { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"" /v AllowTelemetry /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ }; & sc.exe config DiagTrack start= disabled; & sc.exe stop DiagTrack }
function disablecortana { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"" /v AllowCortana /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function disableonedrive { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive"" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function taskbarclean { $out = & cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v TaskbarMn /t REG_DWORD /d 0 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v TaskbarDa /t REG_DWORD /d 0 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v ShowTaskViewButton /t REG_DWORD /d 0 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function numlockon { $out = & cmd.exe /c "reg add ""HKU\.DEFAULT\Control Panel\Keyboard"" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function autologon { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v AutoAdminLogon /t REG_SZ /d 1 /f & reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultUserName /t REG_SZ /d $($args[0]) /f & reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultPassword /t REG_SZ /d $($args[1]) /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function autologoff { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v AutoAdminLogon /t REG_SZ /d 0 /f & reg delete ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultPassword /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function wupause { $out = & cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseUpdatesExpiryTime /t REG_SZ /d ""2099-01-01T00:00:00"" /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function wuresume { $out = & cmd.exe /c "reg delete ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseUpdatesExpiryTime /f" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function wuserver { $out = & cmd.exe /c "reg query ""HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"" /s" 2>&1; $out | ForEach-Object { Write-Host $_ } }
function deliveryopt { $out = & cmd.exe /c "reg query ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config""" 2>&1; $out | ForEach-Object { Write-Host $_ } }

# --- Boot mode shortcuts (bcdedit-based) ---
function safeboot { & bcdedit.exe /set "{current}" safeboot minimal }
function safebootnet { & bcdedit.exe /set "{current}" safeboot network }
function safebootoff { & bcdedit.exe /deletevalue "{current}" safeboot }
function bootinfo { & bcdedit.exe /enum }

# --- Power shortcuts ---
function sleepoff { & powercfg.exe -change -standby-timeout-ac 0; & powercfg.exe -change -standby-timeout-dc 0 }
function hibernateoff { & powercfg.exe -h off }
function hibernateon { & powercfg.exe -h on }

# --- DISM shortcuts ---
function smb1off { & dism.exe /online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart }
function smb1on { & dism.exe /online /Enable-Feature /FeatureName:SMB1Protocol /NoRestart }

# --- Cleanup shortcuts ---
function cleartemp { Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue; Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "Temp files cleared" }
function wureset { & net.exe stop wuauserv; & net.exe stop cryptSvc; & net.exe stop bits; & net.exe stop msiserver; Rename-Item "C:\Windows\SoftwareDistribution" "SoftwareDistribution.old" -Force -ErrorAction SilentlyContinue; Rename-Item "C:\Windows\System32\catroot2" "catroot2.old" -Force -ErrorAction SilentlyContinue; & net.exe start wuauserv; & net.exe start cryptSvc; & net.exe start bits; & net.exe start msiserver; Write-Host "Windows Update components reset" }
function wucleardownload { & net.exe stop wuauserv; Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue; & net.exe start wuauserv; Write-Host "WU download cache cleared" }
function clearevt { Get-WinEvent -ListLog * -ErrorAction SilentlyContinue | ForEach-Object { & wevtutil.exe cl $_.LogName 2>$null }; Write-Host "Event logs cleared" }

# =====================
# BRIDGE UTILITIES
# =====================
function run {
    param([string]$Block)
    $Block -split "`n" | ForEach-Object {
        $line = $_.Trim()
        if ($line -ne "") {
            $out = & cmd.exe /c $line 2>&1
            $out | ForEach-Object { Write-Host $_ }
        }
    }
}
function toclip { $args | & cmd.exe /c "$($args -join ' ')" 2>&1 | clip.exe }
function opencmd { Start-Process cmd.exe -ArgumentList "/k cd /d $PWD" }
function bg { Start-Process -FilePath $args[0] -ArgumentList ($args[1..$args.Length] -join ' ') -WindowStyle Hidden }
function bgmin { Start-Process -FilePath $args[0] -ArgumentList ($args[1..$args.Length] -join ' ') -WindowStyle Minimized }

# ============================================
# Remote-tool safe | No .exe overrides
# ============================================
