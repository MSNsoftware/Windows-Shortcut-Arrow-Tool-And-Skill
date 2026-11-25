<#
.SYNOPSIS
    Restores default Windows shortcut overlay arrows.
.DESCRIPTION
    Deletes Shell Icons slot 29 from HKCU and HKLM, clears caches, and restarts explorer.
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

Write-Host "=== Windows Shortcut Arrow Restorer ===" -ForegroundColor Cyan

# 1. Remove from HKCU
$regPathHKCU = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons'
if (Test-Path $regPathHKCU) {
    Remove-ItemProperty -Path $regPathHKCU -Name '29' -ErrorAction SilentlyContinue
    # If Shell Icons is empty, remove key
    $props = Get-ItemProperty -Path $regPathHKCU
    $userProps = $props.PSObject.Properties | Where-Object { $_.Name -notmatch '^PS' }
    if (-not $userProps) {
        Remove-Item -Path $regPathHKCU -Force -ErrorAction SilentlyContinue
    }
    Write-Host "  [OK] Removed overlay override from HKCU" -ForegroundColor Green
}

# 2. Remove from HKLM if elevated
if ($isAdmin) {
    $regPathHKLM = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons'
    if (Test-Path $regPathHKLM) {
        Remove-ItemProperty -Path $regPathHKLM -Name '29' -ErrorAction SilentlyContinue
        $props = Get-ItemProperty -Path $regPathHKLM
        $userProps = $props.PSObject.Properties | Where-Object { $_.Name -notmatch '^PS' }
        if (-not $userProps) {
            Remove-Item -Path $regPathHKLM -Force -ErrorAction SilentlyContinue
        }
        Write-Host "  [OK] Removed overlay override from HKLM" -ForegroundColor Green
    }
} else {
    Write-Host "  [INFO] Not running as admin; check HKLM manually if system-wide tweak was applied." -ForegroundColor Yellow
}

# 3. Clear caches and restart Explorer
if (-not $NoRestart) {
    Write-Host "  [..] Clearing icon cache and restarting Explorer..." -ForegroundColor Cyan
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1

    cmd.exe /c "del /a /f /q `"%localappdata%\IconCache.db`" 2>nul"
    cmd.exe /c "del /a /f /q `"%localappdata%\Microsoft\Windows\Explorer\iconcache*`" 2>nul"
    cmd.exe /c "del /a /f /q `"%localappdata%\Microsoft\Windows\Explorer\thumbcache*`" 2>nul"

    Start-Process explorer.exe
    Start-Sleep -Seconds 2

    try {
        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class ShellChangeNotifierRestore {
    [DllImport("shell32.dll")]
    public static extern void SHChangeNotify(int wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2);
}
"@ -ErrorAction SilentlyContinue
        [ShellChangeNotifierRestore]::SHChangeNotify(0x08000000, 0x1000, [IntPtr]::Zero, [IntPtr]::Zero)
    } catch {}

    Write-Host "=== Default shortcut arrows restored successfully! ===" -ForegroundColor Green
}
