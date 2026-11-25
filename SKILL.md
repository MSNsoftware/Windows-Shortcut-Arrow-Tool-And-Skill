---
name: windows-shortcut-arrow-remover
description: Safely removes or restores the shortcut arrow overlay on Windows 10 and Windows 11 across all icon sizes (Small to Extra Large 256x256) without black boxes or corner cutouts.
---

# Windows Shortcut Arrow Remover (Agent Skill)

Use this skill when the user wants to **remove** or **restore** the shortcut overlay arrow on Windows 10 or Windows 11 desktop and Explorer icons.

## Why This Approach Works Safely

1. **Multi-Resolution Transparent Icon (`assets/blank.ico`):**
   - Uses a hybrid multi-resolution `.ico` (16x16, 24x24, 32x32, 48x48, and a 256x256 PNG layer with proper alpha channel).
   - Avoids the **black-box bug** caused by invalid `,0` icon path suffixes or malformed 32bpp BMP headers.
   - Avoids the **corner-cutout bug** in Large / Extra Large (256x256) thumbnail views caused by 1bpp monochrome masks wiping destination alpha.
2. **Preserves `IsShortcut`:**
   - Never deletes `HKCR\lnkfile\IsShortcut`, keeping **Pin to Taskbar**, **Pin to Start**, and taskbar drag-and-drop 100% functional.

## Instructions for AI Agents

### Remove Shortcut Arrows
1. Run `scripts/Remove-ShortcutArrow.ps1` with PowerShell (elevated as Administrator for machine-wide `HKLM` + `C:\Windows\blank.ico`, or standard user for `HKCU` + `%LOCALAPPDATA%\ShortcutArrow\blank.ico`):
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\Remove-ShortcutArrow.ps1"
   ```
2. Verify that `Shell Icons` value `29` points directly to the `.ico` path **without** a `,0` suffix, and confirm `explorer.exe` restarted and `IconCache.db` / `thumbcache*.db` were cleared.

### Restore Default Shortcut Arrows
1. Run `scripts/Restore-ShortcutArrow.ps1` with PowerShell (elevated if `HKLM` was modified):
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\Restore-ShortcutArrow.ps1"
   ```
2. Confirm value `29` is removed from `HKCU` and `HKLM` `Shell Icons`, icon/thumbnail caches are purged, and `explorer.exe` is running.
