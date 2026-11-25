# Windows Shortcut Arrow Remover — Tool & Agent Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Windows 10/11](https://img.shields.io/badge/Platform-Windows%2010%20%2F%2011-0078D6.svg)](#)
[![Dual Mode: Standalone + AI Skill](https://img.shields.io/badge/Mode-1--Click%20Tool%20%2B%20AI%20Skill-brightgreen.svg)](#)

A clean, safe, dual-purpose utility and **AI Agent Skill** to remove or restore desktop shortcut overlay arrows on **Windows 10 and Windows 11**—engineered to work across all icon sizes (**Small, Medium, Large, and Extra Large / 256×256**) without black boxes or corner cutouts.

ابزاری سبک، ایمن و دوکاره (**فایل اجرایی مستقیم + مهارت هوش مصنوعی / Agent Skill**) برای حذف یا بازگردانی فلش شورتکات‌ها در **ویندوز ۱۰ و ۱۱**؛ کاملاً سازگار با تمام اندازه‌های آیکون (از کوچک تا خیلی بزرگ ۲۵۶×۲۵۶) بدون ایجاد کادر مشکی یا بریدگی گوشه آیکون.

---

## Two Ways to Use / دو روش استفاده

### 1. As an AI Agent Skill (`SKILL.md`) / استفاده به عنوان مهارت هوش مصنوعی
You can load [`SKILL.md`](SKILL.md) (or point your AI coding agent like Antigravity to this repository) and simply ask it to remove or restore your Windows shortcut arrows. The agent will follow the instructions and run the scripts automatically.

می‌توانید فایل [`SKILL.md`](SKILL.md) یا لینک این مخزن را به ایجنت هوش مصنوعی خود (مانند Antigravity) بدهید و از آن بخواهید فلش شورتکات‌ها را حذف یا به حالت اول برگرداند تا تمام مراحل به‌صورت خودکار انجام شود.

### 2. As Standalone Files (1-Click or PowerShell) / استفاده مستقیم با فایل‌ها

#### Remove Shortcut Arrows / حذف فلش شورتکات‌ها
- **1-Click (Recommended):** Double-click **`Remove-Shortcut-Arrow.bat`** (automatically requests Administrator privileges).
- **PowerShell:**
  ```powershell
  .\scripts\Remove-ShortcutArrow.ps1
  ```

#### Restore Default Arrows / بازگردانی به حالت پیش‌فرض ویندوز
- **1-Click:** Double-click **`Restore-Shortcut-Arrow.bat`**.
- **PowerShell:**
  ```powershell
  .\scripts\Restore-ShortcutArrow.ps1
  ```

---

## Why This Solution? / چرا این روش؟

- **No Black Boxes & No Large-Icon Cutouts:** Many common tweaks fail on Windows 11—causing solid black squares (from `,0` suffix bugs or invalid 32bpp headers) or transparent corner cutouts in Extra Large view (from 1bpp masks wiping thumbnail alpha). This repo uses a verified multi-resolution hybrid `.ico` (`16` to `256` PNG with proper alpha blending).
- **100% Safe for Windows Shell:** Does **not** delete `HKCR\lnkfile\IsShortcut`, so **Pin to Taskbar**, **Pin to Start**, and taskbar drag-and-drop continue working normally.
- **Clean Cache Rebuild:** Automatically clears `IconCache.db`, `iconcache*.db`, and `thumbcache*.db`, then restarts `explorer.exe` and notifies the shell.

---

## Project Structure / ساختار پروژه

```text
├── assets/
│   └── blank.ico                   # Multi-resolution transparent icon (16x16 to 256x256 PNG)
├── scripts/
│   ├── Remove-ShortcutArrow.ps1    # Core removal script (registry + cache purge + Explorer restart)
│   └── Restore-ShortcutArrow.ps1   # Core restoration script
├── Remove-Shortcut-Arrow.bat       # 1-click auto-elevated launcher (Remove)
├── Restore-Shortcut-Arrow.bat      # 1-click auto-elevated launcher (Restore)
├── SKILL.md                        # AI Agent Skill definition
├── LICENSE                         # MIT License
├── .gitignore
└── README.md
```

---

## Author / سازنده

Created & published by **[MSNsoftware](https://github.com/MSNsoftware)**.
