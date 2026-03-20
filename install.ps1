# ============================================
# CMD Compatibility Layer - Installer
# https://github.com/SellerDumpskart/cmdcompat
# ============================================
# Usage: irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/install.ps1 | iex
# ============================================

Write-Host ""
Write-Host "  ==============================================" -ForegroundColor Green
Write-Host "   CMD Compatibility Layer - Installing...      " -ForegroundColor Green
Write-Host "  ==============================================" -ForegroundColor Green
Write-Host ""

# Download the profile content
$url = "https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/profile.ps1"
try {
    $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
    Write-Host "  [1/3] Downloaded profile from GitHub" -ForegroundColor Cyan
} catch {
    Write-Host "  [ERROR] Could not download from GitHub." -ForegroundColor Red
    Write-Host "  Check your internet connection and try again." -ForegroundColor Red
    return
}

# Create profile directory if needed
$profileDir = Split-Path $PROFILE
if (!(Test-Path $profileDir)) {
    New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
    Write-Host "  [2/3] Created directory: $profileDir" -ForegroundColor Cyan
} else {
    Write-Host "  [2/3] Profile directory exists" -ForegroundColor Cyan
}

# Check if already installed
if (Test-Path $PROFILE) {
    $existing = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
    if ($existing -match "CMD Compatibility Layer") {
        # Remove old version and replace
        $cleaned = $existing -replace '(?s)# ={5,}\r?\n# CMD Compatibility Layer.*', ''
        $content = $cleaned.TrimEnd() + "`r`n`r`n" + $content
        Write-Host "  [!] Updated existing installation" -ForegroundColor Yellow
    } else {
        # Append to existing profile
        $content = $existing.TrimEnd() + "`r`n`r`n" + $content
        Write-Host "  [!] Appending to existing profile" -ForegroundColor Yellow
    }
}

# Write the profile
$content | Set-Content $PROFILE -Force
Write-Host "  [3/3] Saved to: $PROFILE" -ForegroundColor Cyan

# Load it immediately
. $PROFILE

Write-Host ""
Write-Host "  ==============================================" -ForegroundColor Green
Write-Host "   Installation Complete! Remote-tool safe      " -ForegroundColor Green
Write-Host "  ==============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Native commands work as-is:" -ForegroundColor White
Write-Host "    ipconfig /all" -ForegroundColor Gray
Write-Host "    whoami /all" -ForegroundColor Gray
Write-Host "    ping google.com" -ForegroundColor Gray
Write-Host ""
Write-Host "  New shortcuts available:" -ForegroundColor White
Write-Host "    flushdns, ports, admins, hotfixes" -ForegroundColor Gray
Write-Host "    rdpon, rdpoff, defenderoff, defenderon" -ForegroundColor Gray
Write-Host "    gpforce, gpolist, regquery, regadd" -ForegroundColor Gray
Write-Host "    c start """" notepad  (any CMD command)" -ForegroundColor Gray
Write-Host ""
Write-Host "  Full list: https://github.com/SellerDumpskart/cmdcompat" -ForegroundColor DarkGray
Write-Host ""
