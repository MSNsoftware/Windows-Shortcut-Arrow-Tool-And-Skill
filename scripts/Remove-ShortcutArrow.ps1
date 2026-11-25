<#
.SYNOPSIS
    Removes shortcut overlay arrows from Windows desktop & explorer icons cleanly.
.DESCRIPTION
    Replaces Shell Icons slot 29 with a multi-resolution transparent icon (16x16 up to 256x256).
    Compatible with all icon view sizes (Small, Medium, Large, Extra Large).
    Does NOT touch HKCR\lnkfile\IsShortcut, preserving "Pin to Taskbar" and "Pin to Start".
#>
[CmdletBinding()]
param(
    [switch]$NoRestart
)

$ErrorActionPreference = 'Stop'

function Test-IsAdmin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

$isAdmin = Test-IsAdmin
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$bundledIco = Join-Path $projectRoot 'assets\blank.ico'
$targetDir = Join-Path $env:LOCALAPPDATA 'ShortcutArrow'
$targetIco = Join-Path $targetDir 'blank.ico'
$winIco = 'C:\Windows\blank.ico'

Write-Host "=== Windows Shortcut Arrow Remover ===" -ForegroundColor Cyan

# 1. Ensure target directory exists
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# 2. Deploy transparent icon
if (Test-Path $bundledIco) {
    Copy-Item -LiteralPath $bundledIco -Destination $targetIco -Force
    Write-Host "  [OK] Installed transparent icon to $targetIco" -ForegroundColor Green
} elseif (Test-Path $winIco) {
    Copy-Item -LiteralPath $winIco -Destination $targetIco -Force
    Write-Host "  [OK] Used existing system icon at $winIco" -ForegroundColor Green
} else {
    Write-Host "  [ERROR] assets\blank.ico not found!" -ForegroundColor Red
    exit 1
}

# Also update C:\Windows\blank.ico if elevated
if ($isAdmin) {
    try {
        Copy-Item -LiteralPath $targetIco -Destination $winIco -Force
        Write-Host "  [OK] Updated $winIco" -ForegroundColor Green
    } catch {}
}

# 3. Apply Registry Setting
$regValue = if ($isAdmin -and (Test-Path $winIco)) { $winIco } else { $targetIco }

$regPathHKCU = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons'
if (-not (Test-Path $regPathHKCU)) {
    New-Item -Path $regPathHKCU -Force | Out-Null
}
Set-ItemProperty -Path $regPathHKCU -Name '29' -Value $regValue -Type String -Force
Write-Host "  [OK] Registry updated for Current User (HKCU)" -ForegroundColor Green

if ($isAdmin) {
    $regPathHKLM = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons'
    if (-not (Test-Path $regPathHKLM)) {
        New-Item -Path $regPathHKLM -Force | Out-Null
    }
    Set-ItemProperty -Path $regPathHKLM -Name '29' -Value $regValue -Type String -Force
    Write-Host "  [OK] Registry updated for Local Machine (HKLM)" -ForegroundColor Green
} else {
    Write-Host "  [INFO] Not running as admin; updated HKCU only. Re-run as admin for machine-wide effect." -ForegroundColor Yellow
}

# 4. Clear cache and restart Explorer
if (-not $NoRestart) {
    Write-Host "  [..] Clearing icon cache and restarting Explorer..." -ForegroundColor Cyan
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1

    cmd.exe /c "del /a /f /q `"%localappdata%\IconCache.db`" 2>nul"
    cmd.exe /c "del /a /f /q `"%localappdata%\Microsoft\Windows\Explorer\iconcache*`" 2>nul"
    cmd.exe /c "del /a /f /q `"%localappdata%\Microsoft\Windows\Explorer\thumbcache*`" 2>nul"

    Start-Process explorer.exe
    Start-Sleep -Seconds 2

    # Flush Desktop notification
    try {
        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class ShellChangeNotifier {
    [DllImport("shell32.dll")]
    public static extern void SHChangeNotify(int wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2);
}
"@ -ErrorAction SilentlyContinue
        [ShellChangeNotifier]::SHChangeNotify(0x08000000, 0x1000, [IntPtr]::Zero, [IntPtr]::Zero)
    } catch {}

    Write-Host "=== Shortcut arrows successfully removed! ===" -ForegroundColor Green
}
