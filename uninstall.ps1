# ============================================
# CMD Compatibility Layer - Uninstaller
# https://github.com/SellerDumpskart/cmdcompat
# ============================================
# Usage: irm https://raw.githubusercontent.com/SellerDumpskart/cmdcompat/main/uninstall.ps1 | iex
# ============================================

Write-Host ""
Write-Host "  CMD Compatibility Layer - Uninstalling..." -ForegroundColor Yellow
Write-Host ""

if (!(Test-Path $PROFILE)) {
    Write-Host "  No PowerShell profile found. Nothing to uninstall." -ForegroundColor Red
    return
}

$content = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue

if ($content -match "CMD Compatibility Layer") {
    $cleaned = $content -replace '(?s)# ={5,}\r?\n# CMD Compatibility Layer.*', ''
    $cleaned = $cleaned.TrimEnd()

    if ($cleaned.Length -gt 0) {
        $cleaned | Set-Content $PROFILE -Force
        Write-Host "  Removed CMD Compatibility Layer from profile." -ForegroundColor Green
        Write-Host "  Your other profile settings were preserved." -ForegroundColor Green
    } else {
        Remove-Item $PROFILE -Force
        Write-Host "  Removed profile file (it only contained CMD Compatibility)." -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "  Restart PowerShell to complete uninstall." -ForegroundColor Cyan
} else {
    Write-Host "  CMD Compatibility Layer not found in profile." -ForegroundColor Red
}

Write-Host ""
