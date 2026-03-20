# CMD Compatibility Layer for PowerShell

Use CMD built-in commands and 150+ shortcuts directly in PowerShell. **Remote management tool safe** — doesn't break native `.exe` command output.

## One-Line Install

```powershell
irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/install.ps1 | iex
```

Works on any Windows machine. Installs in seconds. Persists across reboots.

## One-Line Uninstall

```powershell
irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/uninstall.ps1 | iex
```

## Manual Install (No Internet)

Open PowerShell on the target machine and paste:

```powershell
@'
<paste contents of profile.ps1 here>
'@ | Set-Content $PROFILE -Force
. $PROFILE
```

## How It Works

**Native .exe commands are NOT overridden** — `ipconfig`, `whoami`, `ping`, `tracert`, `netstat`, `gpupdate`, `certutil`, etc. all work exactly as before. This ensures compatibility with remote management tools (RMM, SCCM, Intune, etc.) that can't capture `cmd.exe /c` output.

**Only CMD built-in commands** (which have no `.exe`) are wrapped: `move`, `copy`, `del`, `ren`, `type`, `mklink`, `assoc`, `ftype`, `vol`, `ver`, `set`, etc.

**150+ shortcut commands** are added for common admin tasks — these call `.exe` directly, not through `cmd.exe`.

## Categories

- CMD Built-in Wrappers (move, copy, del, type, etc.)
- Network Shortcuts (flushdns, ports, netreset, showip, etc.)
- Firewall Shortcuts (netshfwon/off, fwstatus, etc.)
- Process Shortcuts (fkill, fpid)
- System Info (localusers, admins, services, drivers, etc.)
- Group Policy (gpforce, gpolist, gpohtml, etc.)
- Registry (regquery, regadd, regdelete, regbackup, etc.)
- Active Directory (domaininfo, dclist, fsmo, replstatus, etc.)
- Certificates (showcerts, rootcerts, hashfile, etc.)
- Windows Update (wuscan, wuforce, wureset, hotfixes, etc.)
- Bypass Toggles (defenderoff/on, uacoff/on, rdpon/off, nlaoff/on, etc.)
- Boot & Power (safeboot, hibernateoff, sleepoff, fastbootoff, etc.)
- WSL & Package Managers (wsllist, wingetinstall, etc.)
- Cleanup (cleartemp, clearevt, wucleardownload, etc.)
- Bridge Utilities (c, run, opencmd, bg, bgmin)

## Requirements

- Windows 10 / 11 / Server 2016+
- PowerShell 5.1 or 7+
- Some commands require admin rights
- AD commands require RSAT tools

## License

MIT
