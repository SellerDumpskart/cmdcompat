# ============================================
# CMD Compatibility Layer for PowerShell
# https://github.com/SellerDumpskart/cmdcompat
# 200+ CMD commands | Updated 2026
# ============================================
# Install: irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/install.ps1 | iex
# ============================================

# =====================
# FILE AND FOLDER
# =====================
function move { cmd.exe /c "move $($args -join ' ')" }
function copy { cmd.exe /c "copy $($args -join ' ')" }
function del { cmd.exe /c "del $($args -join ' ')" }
function ren { cmd.exe /c "ren $($args -join ' ')" }
function rmdir { cmd.exe /c "rmdir $($args -join ' ')" }
function type { cmd.exe /c "type $($args -join ' ')" }
function attrib { cmd.exe /c "attrib $($args -join ' ')" }
function xcopy { cmd.exe /c "xcopy $($args -join ' ')" }
function robocopy { cmd.exe /c "robocopy $($args -join ' ')" }
function mklink { cmd.exe /c "mklink $($args -join ' ')" }
function tree { cmd.exe /c "tree $($args -join ' ')" }
function comp { cmd.exe /c "comp $($args -join ' ')" }
function fc { cmd.exe /c "fc $($args -join ' ')" }
function find { cmd.exe /c "find $($args -join ' ')" }
function findstr { cmd.exe /c "findstr $($args -join ' ')" }
function replace { cmd.exe /c "replace $($args -join ' ')" }
function assoc { cmd.exe /c "assoc $($args -join ' ')" }
function ftype { cmd.exe /c "ftype $($args -join ' ')" }
function expand { cmd.exe /c "expand $($args -join ' ')" }
function makecab { cmd.exe /c "makecab $($args -join ' ')" }
function extrac32 { cmd.exe /c "extrac32 $($args -join ' ')" }
function forfiles { cmd.exe /c "forfiles $($args -join ' ')" }
function where { cmd.exe /c "where $($args -join ' ')" }

# =====================
# NETWORK - CORE
# =====================
function ipconfig { cmd.exe /c "ipconfig $($args -join ' ')" }
function nslookup { cmd.exe /c "nslookup $($args -join ' ')" }
function ping { cmd.exe /c "ping $($args -join ' ')" }
function tracert { cmd.exe /c "tracert $($args -join ' ')" }
function pathping { cmd.exe /c "pathping $($args -join ' ')" }
function netsh { cmd.exe /c "netsh $($args -join ' ')" }
function net { cmd.exe /c "net $($args -join ' ')" }
function netstat { cmd.exe /c "netstat $($args -join ' ')" }
function nbtstat { cmd.exe /c "nbtstat $($args -join ' ')" }
function arp { cmd.exe /c "arp $($args -join ' ')" }
function route { cmd.exe /c "route $($args -join ' ')" }
function hostname { cmd.exe /c "hostname $($args -join ' ')" }
function ftp { cmd.exe /c "ftp $($args -join ' ')" }
function telnet { cmd.exe /c "telnet $($args -join ' ')" }
function getmac { cmd.exe /c "getmac $($args -join ' ')" }
function finger { cmd.exe /c "finger $($args -join ' ')" }
function mrinfo { cmd.exe /c "mrinfo $($args -join ' ')" }

# =====================
# NETWORK - DIAGNOSTICS
# =====================
function flushdns { cmd.exe /c "ipconfig /flushdns" }
function registerdns { cmd.exe /c "ipconfig /registerdns" }
function releaseip { cmd.exe /c "ipconfig /release" }
function renewip { cmd.exe /c "ipconfig /renew" }
function displaydns { cmd.exe /c "ipconfig /displaydns" }
function netreset { cmd.exe /c "netsh int ip reset && netsh winsock reset && ipconfig /flushdns && ipconfig /release && ipconfig /renew" }
function winsockreset { cmd.exe /c "netsh winsock reset" }
function ipreset { cmd.exe /c "netsh int ip reset" }
function tcpreset { cmd.exe /c "netsh int tcp reset" }
function dnsclient { cmd.exe /c "netsh interface ip show dnsservers" }
function showip { cmd.exe /c "ipconfig | findstr /i ""IPv4 IPv6""" }
function showdns { cmd.exe /c "netsh interface ip show dnsservers" }
function showgateway { cmd.exe /c "ipconfig | findstr /i ""Default Gateway""" }
function showwifi { cmd.exe /c "netsh wlan show interfaces" }
function wifiprofiles { cmd.exe /c "netsh wlan show profiles" }
function wifipass { cmd.exe /c "netsh wlan show profiles & echo. & echo Use: netsh wlan show profile name=WIFINAME key=clear" }
function wifidisconnect { cmd.exe /c "netsh wlan disconnect" }
function ports { cmd.exe /c "netstat -ano | findstr LISTENING" }
function portfind { cmd.exe /c "netstat -ano | findstr $($args -join ' ')" }
function connections { cmd.exe /c "netstat -ano | findstr ESTABLISHED" }
function openports { cmd.exe /c "netstat -an | findstr /i listening" }
function routetable { cmd.exe /c "route print" }
function arptable { cmd.exe /c "arp -a" }

# =====================
# NETWORK - FIREWALL
# =====================
function netshfw { cmd.exe /c "netsh advfirewall $($args -join ' ')" }
function netshfwrule { cmd.exe /c "netsh advfirewall firewall $($args -join ' ')" }
function netshfwshow { cmd.exe /c "netsh advfirewall firewall show rule name=all $($args -join ' ')" }
function netshfwreset { cmd.exe /c "netsh advfirewall reset $($args -join ' ')" }
function netshfwoff { cmd.exe /c "netsh advfirewall set allprofiles state off $($args -join ' ')" }
function netshfwon { cmd.exe /c "netsh advfirewall set allprofiles state on $($args -join ' ')" }
function netshwlan { cmd.exe /c "netsh wlan $($args -join ' ')" }
function netshint { cmd.exe /c "netsh interface $($args -join ' ')" }
function netshdns { cmd.exe /c "netsh interface ip set dns $($args -join ' ')" }
function netshproxy { cmd.exe /c "netsh winhttp $($args -join ' ')" }
function showproxy { cmd.exe /c "netsh winhttp show proxy" }
function resetproxy { cmd.exe /c "netsh winhttp reset proxy" }
function fwstatus { cmd.exe /c "netsh advfirewall show allprofiles state" }

# =====================
# SYSTEM AND PROCESS
# =====================
function taskkill { cmd.exe /c "taskkill $($args -join ' ')" }
function tasklist { cmd.exe /c "tasklist $($args -join ' ')" }
function systeminfo { cmd.exe /c "systeminfo $($args -join ' ')" }
function shutdown { cmd.exe /c "shutdown $($args -join ' ')" }
function sc { cmd.exe /c "sc $($args -join ' ')" }
function wmic { cmd.exe /c "wmic $($args -join ' ')" }
function schtasks { cmd.exe /c "schtasks $($args -join ' ')" }
function sfc { cmd.exe /c "sfc $($args -join ' ')" }
function dism { cmd.exe /c "dism $($args -join ' ')" }
function bcdedit { cmd.exe /c "bcdedit $($args -join ' ')" }
function msconfig { cmd.exe /c "msconfig $($args -join ' ')" }
function powercfg { cmd.exe /c "powercfg $($args -join ' ')" }
function ver { cmd.exe /c "ver $($args -join ' ')" }
function date { cmd.exe /c "date $($args -join ' ')" }
function time { cmd.exe /c "time $($args -join ' ')" }
function setx { cmd.exe /c "setx $($args -join ' ')" }
function timeout { cmd.exe /c "timeout $($args -join ' ')" }
function choice { cmd.exe /c "choice $($args -join ' ')" }
function clip { cmd.exe /c "clip $($args -join ' ')" }
function mode { cmd.exe /c "mode $($args -join ' ')" }
function title { cmd.exe /c "title $($args -join ' ')" }
function fkill { cmd.exe /c "taskkill /F /IM $($args -join ' ')" }
function fpid { cmd.exe /c "taskkill /F /PID $($args -join ' ')" }
function elevate { cmd.exe /c "powershell -Command Start-Process cmd -Verb RunAs $($args -join ' ')" }

# =====================
# DISK AND STORAGE
# =====================
function diskpart { cmd.exe /c "diskpart $($args -join ' ')" }
function chkdsk { cmd.exe /c "chkdsk $($args -join ' ')" }
function format { cmd.exe /c "format $($args -join ' ')" }
function defrag { cmd.exe /c "defrag $($args -join ' ')" }
function fsutil { cmd.exe /c "fsutil $($args -join ' ')" }
function label { cmd.exe /c "label $($args -join ' ')" }
function vol { cmd.exe /c "vol $($args -join ' ')" }
function convert { cmd.exe /c "convert $($args -join ' ')" }
function compact { cmd.exe /c "compact $($args -join ' ')" }
function subst { cmd.exe /c "subst $($args -join ' ')" }
function mountvol { cmd.exe /c "mountvol $($args -join ' ')" }
function cleanmgr { cmd.exe /c "cleanmgr $($args -join ' ')" }
function diskperf { cmd.exe /c "diskperf $($args -join ' ')" }
function diskhealth { cmd.exe /c "wmic diskdrive get status,model,size" }

# =====================
# REGISTRY
# =====================
function reg { cmd.exe /c "reg $($args -join ' ')" }
function regedit { cmd.exe /c "regedit $($args -join ' ')" }
function regsvr32 { cmd.exe /c "regsvr32 $($args -join ' ')" }
function regini { cmd.exe /c "regini $($args -join ' ')" }
function regquery { cmd.exe /c "reg query $($args -join ' ')" }
function regadd { cmd.exe /c "reg add $($args -join ' ')" }
function regdelete { cmd.exe /c "reg delete $($args -join ' ')" }
function regexport { cmd.exe /c "reg export $($args -join ' ')" }
function regimport { cmd.exe /c "reg import $($args -join ' ')" }
function regsave { cmd.exe /c "reg save $($args -join ' ')" }
function regrestore { cmd.exe /c "reg restore $($args -join ' ')" }
function regload { cmd.exe /c "reg load $($args -join ' ')" }
function regunload { cmd.exe /c "reg unload $($args -join ' ')" }
function regcompare { cmd.exe /c "reg compare $($args -join ' ')" }
function regcopy { cmd.exe /c "reg copy $($args -join ' ')" }
function regflags { cmd.exe /c "reg flags $($args -join ' ')" }
function regbackup { cmd.exe /c "reg export HKLM\SOFTWARE %TEMP%\HKLM_SOFTWARE_backup.reg /y & reg export HKLM\SYSTEM %TEMP%\HKLM_SYSTEM_backup.reg /y & reg export HKCU %TEMP%\HKCU_backup.reg /y & echo Backed up to %TEMP%" }

# =====================
# GROUP POLICY
# =====================
function gpupdate { cmd.exe /c "gpupdate $($args -join ' ')" }
function gpresult { cmd.exe /c "gpresult $($args -join ' ')" }
function gpforce { cmd.exe /c "gpupdate /force /wait:0" }
function gpedit { cmd.exe /c "gpedit.msc $($args -join ' ')" }
function secpol { cmd.exe /c "secpol.msc $($args -join ' ')" }
function rsop { cmd.exe /c "rsop.msc $($args -join ' ')" }
function secedit { cmd.exe /c "secedit $($args -join ' ')" }
function auditpol { cmd.exe /c "auditpol $($args -join ' ')" }
function lgpo { cmd.exe /c "lgpo $($args -join ' ')" }
function dcgpofix { cmd.exe /c "dcgpofix $($args -join ' ')" }
function gpfixup { cmd.exe /c "gpfixup $($args -join ' ')" }
function gpolist { cmd.exe /c "gpresult /r /scope:computer & echo. & gpresult /r /scope:user" }
function gpohtml { cmd.exe /c "gpresult /h %TEMP%\gporeport.html & start %TEMP%\gporeport.html" }
function gpouser { cmd.exe /c "gpresult /r /scope:user" }
function gpocomputer { cmd.exe /c "gpresult /r /scope:computer" }
function gpoverify { cmd.exe /c "gpresult /z" }

# =====================
# SECURITY AND PERMISSIONS
# =====================
function icacls { cmd.exe /c "icacls $($args -join ' ')" }
function cacls { cmd.exe /c "cacls $($args -join ' ')" }
function takeown { cmd.exe /c "takeown $($args -join ' ')" }
function cipher { cmd.exe /c "cipher $($args -join ' ')" }
function whoami { cmd.exe /c "whoami $($args -join ' ')" }
function runas { cmd.exe /c "runas $($args -join ' ')" }
function cmdkey { cmd.exe /c "cmdkey $($args -join ' ')" }
function nltest { cmd.exe /c "nltest $($args -join ' ')" }
function klist { cmd.exe /c "klist $($args -join ' ')" }
function setspn { cmd.exe /c "setspn $($args -join ' ')" }
function savedcreds { cmd.exe /c "cmdkey /list" }
function localusers { cmd.exe /c "net user" }
function localgroups { cmd.exe /c "net localgroup" }
function admins { cmd.exe /c "net localgroup administrators" }
function enableadmin { cmd.exe /c "net user administrator /active:yes" }
function disableadmin { cmd.exe /c "net user administrator /active:no" }
function whogroups { cmd.exe /c "whoami /groups" }
function whopriv { cmd.exe /c "whoami /priv" }
function whoall { cmd.exe /c "whoami /all" }

# =====================
# ACTIVE DIRECTORY
# =====================
function dsregcmd { cmd.exe /c "dsregcmd $($args -join ' ')" }
function dsquery { cmd.exe /c "dsquery $($args -join ' ')" }
function dsget { cmd.exe /c "dsget $($args -join ' ')" }
function dsmod { cmd.exe /c "dsmod $($args -join ' ')" }
function dsadd { cmd.exe /c "dsadd $($args -join ' ')" }
function dsrm { cmd.exe /c "dsrm $($args -join ' ')" }
function dsmove { cmd.exe /c "dsmove $($args -join ' ')" }
function csvde { cmd.exe /c "csvde $($args -join ' ')" }
function ldifde { cmd.exe /c "ldifde $($args -join ' ')" }
function netdom { cmd.exe /c "netdom $($args -join ' ')" }
function adprep { cmd.exe /c "adprep $($args -join ' ')" }
function ntdsutil { cmd.exe /c "ntdsutil $($args -join ' ')" }
function esentutl { cmd.exe /c "esentutl $($args -join ' ')" }
function dcdiag { cmd.exe /c "dcdiag $($args -join ' ')" }
function repadmin { cmd.exe /c "repadmin $($args -join ' ')" }
function dnscmd { cmd.exe /c "dnscmd $($args -join ' ')" }
function dfsutil { cmd.exe /c "dfsutil $($args -join ' ')" }
function dfsrmig { cmd.exe /c "dfsrmig $($args -join ' ')" }
function domaininfo { cmd.exe /c "nltest /dsgetdc: & echo. & dsregcmd /status" }
function dclist { cmd.exe /c "nltest /dclist:" }
function trustinfo { cmd.exe /c "nltest /domain_trusts /all_trusts" }
function fsmo { cmd.exe /c "netdom query fsmo" }
function replstatus { cmd.exe /c "repadmin /replsummary" }
function replshow { cmd.exe /c "repadmin /showrepl" }
function adsite { cmd.exe /c "nltest /dsgetsite" }
function dsacls { cmd.exe /c "dsacls $($args -join ' ')" }
function ktpass { cmd.exe /c "ktpass $($args -join ' ')" }
function ksetup { cmd.exe /c "ksetup $($args -join ' ')" }
function adkds { cmd.exe /c "dsquery server -isgc" }
function gcverify { cmd.exe /c "nltest /dsgetdc: /gc" }
function sitelink { cmd.exe /c "repadmin /showconn" }

# =====================
# CERTIFICATES AND CRYPTO
# =====================
function certutil { cmd.exe /c "certutil $($args -join ' ')" }
function certreq { cmd.exe /c "certreq $($args -join ' ')" }
function certmgr { cmd.exe /c "certmgr.msc $($args -join ' ')" }
function signtool { cmd.exe /c "signtool $($args -join ' ')" }
function makecert { cmd.exe /c "makecert $($args -join ' ')" }
function showcerts { cmd.exe /c "certutil -store my" }
function rootcerts { cmd.exe /c "certutil -store root" }
function verifycert { cmd.exe /c "certutil -verify $($args -join ' ')" }
function urlcache { cmd.exe /c "certutil -urlcache $($args -join ' ')" }
function hashfile { cmd.exe /c "certutil -hashfile $($args -join ' ')" }

# =====================
# WINDOWS UPDATE AND PATCHING
# =====================
function wuauclt { cmd.exe /c "wuauclt $($args -join ' ')" }
function usoclient { cmd.exe /c "usoclient $($args -join ' ')" }
function wureset { cmd.exe /c "net stop wuauserv & net stop cryptSvc & net stop bits & net stop msiserver & ren C:\Windows\SoftwareDistribution SoftwareDistribution.old & ren C:\Windows\System32\catroot2 catroot2.old & net start wuauserv & net start cryptSvc & net start bits & net start msiserver" }
function wuforce { cmd.exe /c "usoclient StartScan & usoclient StartDownload & usoclient StartInstall" }
function wuscan { cmd.exe /c "usoclient StartScan" }
function wudownload { cmd.exe /c "usoclient StartDownload" }
function wuinstall { cmd.exe /c "usoclient StartInstall" }
function wureboot { cmd.exe /c "usoclient RestartDevice" }
function wustatus { cmd.exe /c "sc query wuauserv & echo. & sc query bits & echo. & sc query cryptSvc" }
function wulog { cmd.exe /c "wevtutil qe Microsoft-Windows-WindowsUpdateClient/Operational /c:20 /rd:true /f:text" }
function wuhistory { cmd.exe /c "wmic qfe list full /format:table" }
function hotfixes { cmd.exe /c "wmic qfe get HotFixID,InstalledOn,Description /format:table" }
function lastpatch { cmd.exe /c "wmic qfe get HotFixID,InstalledOn | sort /r" }
function wupause { cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseUpdatesExpiryTime /t REG_SZ /d ""2099-01-01T00:00:00"" /f & reg add ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseFeatureUpdatesStartTime /t REG_SZ /d ""2024-01-01T00:00:00"" /f & reg add ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseQualityUpdatesStartTime /t REG_SZ /d ""2024-01-01T00:00:00"" /f" }
function wuresume { cmd.exe /c "reg delete ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseUpdatesExpiryTime /f & reg delete ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseFeatureUpdatesStartTime /f & reg delete ""HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"" /v PauseQualityUpdatesStartTime /f" }
function wudisable { cmd.exe /c "sc config wuauserv start= disabled & sc stop wuauserv" }
function wuenable { cmd.exe /c "sc config wuauserv start= auto & sc start wuauserv" }
function deliveryopt { cmd.exe /c "reg query ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config""" }
function wuserver { cmd.exe /c "reg query ""HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"" /s" }
function wucleardownload { cmd.exe /c "net stop wuauserv & del /q/f/s C:\Windows\SoftwareDistribution\Download\* & net start wuauserv" }

# =====================
# HYPER-V AND VIRTUALIZATION
# =====================
function vmconnect { cmd.exe /c "vmconnect $($args -join ' ')" }
function hcsdiag { cmd.exe /c "hcsdiag $($args -join ' ')" }
function vboxmanage { cmd.exe /c "vboxmanage $($args -join ' ')" }
function vmms { cmd.exe /c "sc query vmms" }
function hyperv { cmd.exe /c "virtmgmt.msc $($args -join ' ')" }

# =====================
# WSL AND SUBSYSTEM
# =====================
function wsl { cmd.exe /c "wsl $($args -join ' ')" }
function wslconfig { cmd.exe /c "wslconfig $($args -join ' ')" }
function bash { cmd.exe /c "bash $($args -join ' ')" }
function wsllist { cmd.exe /c "wsl --list --verbose" }
function wslshutdown { cmd.exe /c "wsl --shutdown" }
function wslstatus { cmd.exe /c "wsl --status" }
function wslupdate { cmd.exe /c "wsl --update" }
function wslinstall { cmd.exe /c "wsl --install $($args -join ' ')" }

# =====================
# PACKAGE MANAGERS
# =====================
function winget { cmd.exe /c "winget $($args -join ' ')" }
function choco { cmd.exe /c "choco $($args -join ' ')" }
function scoop { cmd.exe /c "scoop $($args -join ' ')" }
function wingetinstall { cmd.exe /c "winget install $($args -join ' ')" }
function wingetsearch { cmd.exe /c "winget search $($args -join ' ')" }
function wingetupgrade { cmd.exe /c "winget upgrade --all" }
function wingetlist { cmd.exe /c "winget list" }
function chocoinstall { cmd.exe /c "choco install $($args -join ' ') -y" }
function chocoupgrade { cmd.exe /c "choco upgrade all -y" }
function chocolist { cmd.exe /c "choco list --local-only" }

# =====================
# USER SESSIONS
# =====================
function logoff { cmd.exe /c "logoff $($args -join ' ')" }
function query { cmd.exe /c "query $($args -join ' ')" }
function quser { cmd.exe /c "quser $($args -join ' ')" }
function qwinsta { cmd.exe /c "qwinsta $($args -join ' ')" }
function msg { cmd.exe /c "msg $($args -join ' ')" }
function tsdiscon { cmd.exe /c "tsdiscon $($args -join ' ')" }
function tscon { cmd.exe /c "tscon $($args -join ' ')" }
function rwinsta { cmd.exe /c "rwinsta $($args -join ' ')" }

# =====================
# PRINTING AND DEVICES
# =====================
function print { cmd.exe /c "print $($args -join ' ')" }
function wevtutil { cmd.exe /c "wevtutil $($args -join ' ')" }
function pnputil { cmd.exe /c "pnputil $($args -join ' ')" }
function devcon { cmd.exe /c "devcon $($args -join ' ')" }
function driverquery { cmd.exe /c "driverquery $($args -join ' ')" }
function printui { cmd.exe /c "printui $($args -join ' ')" }
function rundll32 { cmd.exe /c "rundll32 $($args -join ' ')" }

# =====================
# REMOTE MANAGEMENT
# =====================
function psexec { cmd.exe /c "psexec $($args -join ' ')" }
function mstsc { cmd.exe /c "mstsc $($args -join ' ')" }
function msiexec { cmd.exe /c "msiexec $($args -join ' ')" }
function wusa { cmd.exe /c "wusa $($args -join ' ')" }
function bitsadmin { cmd.exe /c "bitsadmin $($args -join ' ')" }
function winrm { cmd.exe /c "winrm $($args -join ' ')" }
function winrs { cmd.exe /c "winrs $($args -join ' ')" }
function wecutil { cmd.exe /c "wecutil $($args -join ' ')" }
function rdpon { cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server"" /v fDenyTSConnections /t REG_DWORD /d 0 /f & netsh advfirewall firewall set rule group=""remote desktop"" new enable=Yes" }
function rdpoff { cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server"" /v fDenyTSConnections /t REG_DWORD /d 1 /f & netsh advfirewall firewall set rule group=""remote desktop"" new enable=No" }

# =====================
# DIAGNOSTICS
# =====================
function eventvwr { cmd.exe /c "eventvwr $($args -join ' ')" }
function perfmon { cmd.exe /c "perfmon $($args -join ' ')" }
function resmon { cmd.exe /c "resmon $($args -join ' ')" }
function msinfo32 { cmd.exe /c "msinfo32 $($args -join ' ')" }
function verifier { cmd.exe /c "verifier $($args -join ' ')" }
function lodctr { cmd.exe /c "lodctr $($args -join ' ')" }
function typeperf { cmd.exe /c "typeperf $($args -join ' ')" }
function logman { cmd.exe /c "logman $($args -join ' ')" }
function w32tm { cmd.exe /c "w32tm $($args -join ' ')" }
function mdsched { cmd.exe /c "mdsched $($args -join ' ')" }
function winsat { cmd.exe /c "winsat $($args -join ' ')" }
function repair { cmd.exe /c "sfc /scannow && DISM /Online /Cleanup-Image /RestoreHealth" }
function cleartemp { cmd.exe /c "del /q/f/s %TEMP%\* 2>nul & del /q/f/s C:\Windows\Temp\* 2>nul" }

# =====================
# BYPASS AND QUICK ACTIONS
# =====================
function defenderoff { cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f" }
function defenderon { cmd.exe /c "reg delete ""HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"" /v DisableRealtimeMonitoring /f" }
function activation { cmd.exe /c "slmgr /xpr & cscript //nologo C:\Windows\System32\slmgr.vbs /dlv" }
function productkey { cmd.exe /c "wmic path softwarelicensingservice get OA3xOriginalProductKey" }
function bitlocker { cmd.exe /c "manage-bde -status" }
function installed { cmd.exe /c "wmic product get name,version /format:list" }
function startups { cmd.exe /c "wmic startup get caption,command" }
function services { cmd.exe /c "sc query type= service state= all" }
function envvars { cmd.exe /c "set" }
function showpath { cmd.exe /c "echo %PATH%" }
function bootinfo { cmd.exe /c "bcdedit /enum & echo. & systeminfo | findstr /i boot" }
function drivers { cmd.exe /c "driverquery /v /fo list" }
function uacoff { cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"" /v EnableLUA /t REG_DWORD /d 0 /f" }
function uacon { cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"" /v EnableLUA /t REG_DWORD /d 1 /f" }
function sleepoff { cmd.exe /c "powercfg -change -standby-timeout-ac 0 & powercfg -change -standby-timeout-dc 0 & powercfg -change -hibernate-timeout-ac 0" }
function hibernateoff { cmd.exe /c "powercfg -h off" }
function hibernateon { cmd.exe /c "powercfg -h on" }
function fastbootoff { cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v HiberbootEnabled /t REG_DWORD /d 0 /f" }
function fastbooton { cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v HiberbootEnabled /t REG_DWORD /d 1 /f" }
function smb1off { cmd.exe /c "dism /online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart" }
function smb1on { cmd.exe /c "dism /online /Enable-Feature /FeatureName:SMB1Protocol /NoRestart" }
function clearevt { cmd.exe /c "for /F ""tokens=*"" %1 in ('wevtutil.exe el') DO wevtutil.exe cl ""%1""" }
function resetnet { cmd.exe /c "netsh int ip reset & netsh winsock reset & netsh advfirewall reset & ipconfig /flushdns & ipconfig /release & ipconfig /renew" }
function safeboot { cmd.exe /c "bcdedit /set {current} safeboot minimal" }
function safebootnet { cmd.exe /c "bcdedit /set {current} safeboot network" }
function safebootoff { cmd.exe /c "bcdedit /deletevalue {current} safeboot" }
function nlaoff { cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"" /v UserAuthentication /t REG_DWORD /d 0 /f" }
function nlaon { cmd.exe /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"" /v UserAuthentication /t REG_DWORD /d 1 /f" }
function autologon { cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v AutoAdminLogon /t REG_SZ /d 1 /f & reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultUserName /t REG_SZ /d $($args[0]) /f & reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultPassword /t REG_SZ /d $($args[1]) /f" }
function autologoff { cmd.exe /c "reg add ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v AutoAdminLogon /t REG_SZ /d 0 /f & reg delete ""HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v DefaultPassword /f" }
function numlockon { cmd.exe /c "reg add ""HKU\.DEFAULT\Control Panel\Keyboard"" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f" }
function showhidden { cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v Hidden /t REG_DWORD /d 1 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v ShowSuperHidden /t REG_DWORD /d 1 /f" }
function showext { cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v HideFileExt /t REG_DWORD /d 0 /f" }
function disabletelemetry { cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"" /v AllowTelemetry /t REG_DWORD /d 0 /f & sc config DiagTrack start= disabled & sc stop DiagTrack" }
function disablecortana { cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"" /v AllowCortana /t REG_DWORD /d 0 /f" }
function disableonedrive { cmd.exe /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive"" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f" }
function taskbarclean { cmd.exe /c "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v TaskbarMn /t REG_DWORD /d 0 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v TaskbarDa /t REG_DWORD /d 0 /f & reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"" /v ShowTaskViewButton /t REG_DWORD /d 0 /f" }

# =====================
# POWERSHELL-TO-CMD BRIDGE
# =====================
Remove-Item Alias:curl -ErrorAction SilentlyContinue
Set-Alias -Name curl -Value curl.exe
function c { cmd.exe /c "$($args -join ' ')" }
function k { cmd.exe /c "cmd /k $($args -join ' ')" }
function runat { cmd.exe /c "runas /user:$($args[0]) ""$($args[1..$args.Length] -join ' ')""" }
function toclip { cmd.exe /c "$($args -join ' ') | clip" }
function tofile { cmd.exe /c "$($args[1..$args.Length] -join ' ') > $($args[0])" }
function silent { cmd.exe /c "$($args -join ' ') >nul 2>&1" }
function Start-CmdBlock {
    param([string]$Block)
    $Block -split "`n" | ForEach-Object {
        $line = $_.Trim()
        if ($line -ne "") { cmd.exe /c $line }
    }
}
Set-Alias -Name run -Value Start-CmdBlock
function bat { cmd.exe /c "$($args -join ' ')" }
function opencmd { cmd.exe /c "start cmd /k cd /d $PWD" }
function bg { cmd.exe /c "start /b $($args -join ' ')" }
function bgmin { cmd.exe /c "start /min $($args -join ' ')" }
function cmdtime { cmd.exe /c "echo %TIME% & $($args -join ' ') & echo %TIME%" }

# ============================================
# Total: 200+ commands | 17 categories
# ============================================
