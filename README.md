# CMD Compatibility Layer for PowerShell

Use **200+ CMD commands** directly in PowerShell without any syntax changes. Built for IT admins, sysadmins, and remote management workflows.

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

## Categories Covered

- File and Folder (23 commands)
- Network Core (17 commands)
- Network Diagnostics (23 commands)
- Network Firewall (13 commands)
- System and Process (25 commands)
- Disk and Storage (14 commands)
- Registry (17 commands)
- Group Policy (16 commands)
- Security and Permissions (19 commands)
- Active Directory (27 commands)
- Certificates and Crypto (10 commands)
- Windows Update and Patching (20 commands)
- Hyper-V and Virtualization (5 commands)
- WSL and Subsystem (8 commands)
- Package Managers (10 commands)
- User Sessions (8 commands)
- Printing and Devices (7 commands)
- Remote Management (10 commands)
- Diagnostics (13 commands)
- Bypass and Quick Actions (30+ commands)
- PowerShell-to-CMD Bridge (13 commands)

## How It Works

Each CMD command is wrapped as a PowerShell function that passes arguments through `cmd.exe /c`. The functions are saved to your PowerShell profile (`$PROFILE`) so they load automatically on every session, including remote management sessions running as SYSTEM.

## Requirements

- Windows 10 / 11 / Server 2016+
- PowerShell 5.1 or 7+
- Some commands require admin rights
- AD commands require RSAT tools

## License

MIT
