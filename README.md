# Windows Shortcut Arrow Remover — Tool & Agent Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Windows 10/11](https://img.shields.io/badge/Platform-Windows%2010%20%2F%2011-0078D6.svg)](#)
[![Dual Mode: Standalone + AI Skill](https://img.shields.io/badge/Mode-1--Click%20Tool%20%2B%20AI%20Skill-brightgreen.svg)](#)

**[English](#english) · [فارسی](#فارسی)**

---

<a name="english"></a>
## English

A clean, safe, dual-purpose utility and **AI Agent Skill** to remove or restore desktop shortcut overlay arrows on **Windows 10 and Windows 11**—engineered to work across all icon sizes (**Small, Medium, Large, and Extra Large / 256×256**) without black boxes or corner cutouts.

### Two Ways to Use

#### 1. As an AI Agent Skill (`SKILL.md`)
Point your AI coding agent (such as Antigravity) to [`SKILL.md`](SKILL.md) or this repository (`https://github.com/MSNsoftware/Windows-Shortcut-Arrow-Tool-And-Skill`) and ask it to remove or restore your Windows shortcut arrows. Even if you only share `SKILL.md`, the agent knows to fetch the scripts and icon from this repository and run everything automatically.

#### 2. As Standalone Files (1-Click or PowerShell)
Download or clone the repository and run the files directly:

- **Remove Shortcut Arrows:**
  - **1-Click (Recommended):** Double-click **`Remove-Shortcut-Arrow.bat`** (automatically requests Administrator privileges).
  - **PowerShell:**
    ```powershell
    .\scripts\Remove-ShortcutArrow.ps1
    ```
- **Restore Default Arrows:**
  - **1-Click:** Double-click **`Restore-Shortcut-Arrow.bat`**.
  - **PowerShell:**
    ```powershell
    .\scripts\Restore-ShortcutArrow.ps1
    ```

### Why This Solution Works

- **No Black Boxes & No Large-Icon Cutouts:** Many common tweaks fail on Windows 11—causing solid black squares (from `,0` suffix bugs or invalid 32bpp headers) or transparent corner cutouts in Extra Large view (from 1bpp masks wiping thumbnail alpha). This tool uses a verified multi-resolution hybrid `.ico` (`16` to `256` PNG with proper alpha blending).
- **100% Safe for Windows Shell:** Does **not** delete `HKCR\lnkfile\IsShortcut`, so **Pin to Taskbar**, **Pin to Start**, and taskbar drag-and-drop continue working normally.
- **Clean Cache Rebuild:** Automatically clears `IconCache.db`, `iconcache*.db`, and `thumbcache*.db`, then restarts `explorer.exe` and notifies the shell.

### Project Structure

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

### Author

Created & published by **[MSNsoftware](https://github.com/MSNsoftware)**.

---

<a name="فارسی"></a>
## فارسی

ابزاری سبک، ایمن و دوکاره (**فایل اجرایی مستقیم + مهارت هوش مصنوعی / Agent Skill**) برای حذف یا بازگردانی فلش کنار آیکون شورتکات‌ها در **ویندوز ۱۰ و ۱۱**؛ کاملاً سازگار با تمام اندازه‌های آیکون (**کوچک، متوسط، بزرگ و خیلی بزرگ ۲۵۶×۲۵۶**) بدون ایجاد کادر مشکی یا بریدگی گوشه آیکون.

### دو روش استفاده

#### ۱. استفاده به عنوان مهارت هوش مصنوعی (`SKILL.md`)
کافی است فایل [`SKILL.md`](SKILL.md) یا لینک این مخزن (`https://github.com/MSNsoftware/Windows-Shortcut-Arrow-Tool-And-Skill`) را به ایجنت هوش مصنوعی خود (مانند Antigravity) بدهید و از آن بخواهید فلش شورتکات‌های ویندوز را حذف یا به حالت اول برگرداند. حتی اگر فقط فایل `SKILL.md` را در اختیار ایجنت قرار دهید، خودش می‌فهمد فایل‌ها را از این مخزن دانلود و به‌صورت خودکار اجرا کند.

#### ۲. استفاده مستقیم با فایل‌ها (یک‌کلیکه یا PowerShell)
مخزن را دانلود یا کلون کنید و فایل‌ها را مستقیماً اجرا نمایید:

- **حذف فلش شورتکات‌ها:**
  - **اجرای یک‌کلیکه (پیشنهادی):** روی فایل **`Remove-Shortcut-Arrow.bat`** دابل کلیک کنید (به‌صورت خودکار دسترسی ادمین را درخواست می‌کند).
  - **از طریق PowerShell:**
    ```powershell
    .\scripts\Remove-ShortcutArrow.ps1
    ```
- **بازگردانی به حالت پیش‌فرض ویندوز:**
  - **اجرای یک‌کلیکه:** روی فایل **`Restore-Shortcut-Arrow.bat`** دابل کلیک کنید.
  - **از طریق PowerShell:**
    ```powershell
    .\scripts\Restore-ShortcutArrow.ps1
    ```

### چرا این روش بی‌نقص کار می‌کند؟

- **بدون کادر مشکی و بدون بریدگی در آیکون‌های بزرگ:** بسیاری از روش‌های قدیمی در ویندوز ۱۱ دچار باگ می‌شوند؛ یا مربع مشکی توپر می‌اندازند (به دلیل پسوند `,0` یا هدر نامعتبر ۳۲ بیتی) یا در نمای خیلی بزرگ (Extra Large) گوشه آیکون را بریده و شفاف می‌کنند (به دلیل ماسک ۱ بیتی). این ابزار از یک آیکون چندرزولوشنه استاندارد (`16` تا `256` پیکسل با لایه PNG شفاف و کانال آلفای صحیح) استفاده می‌کند.
- **کاملاً ایمن برای ویندوز:** مقدار `HKCR\lnkfile\IsShortcut` را حذف نمی‌کند؛ بنابراین قابلیت‌هایی مثل **Pin to Taskbar**، **Pin to Start** و کشیدن آیکون‌ها روی نوار وظیفه بدون هیچ مشکلی به کار خود ادامه می‌دهند.
- **بازسازی تمیز کش آیکون‌ها:** فایل‌های کش `IconCache.db`، `iconcache*.db` و `thumbcache*.db` را به‌صورت خودکار پاکسازی کرده، `explorer.exe` را ریستارت می‌کند و تغییرات را به پوسته ویندوز اطلاع می‌دهد.

### ساختار پروژه

```text
├── assets/
│   └── blank.ico                   # آیکون شفاف چندرزولوشنه (۱۶×۱۶ تا ۲۵۶×۲۵۶ PNG)
├── scripts/
│   ├── Remove-ShortcutArrow.ps1    # اسکریپت اصلی حذف فلش (رجیستری + پاکسازی کش + ریستارت Explorer)
│   └── Restore-ShortcutArrow.ps1   # اسکریپت اصلی بازگردانی به حالت پیش‌فرض
├── Remove-Shortcut-Arrow.bat       # لانچر یک‌کلیکه حذف (با دسترسی خودکار ادمین)
├── Restore-Shortcut-Arrow.bat      # لانچر یک‌کلیکه بازگردانی
├── SKILL.md                        # فایل تعریف مهارت برای ایجنت‌های هوش مصنوعی
├── LICENSE                         # مجوز MIT
├── .gitignore
└── README.md
```

### سازنده

ساخته و منتشر شده توسط **[MSNsoftware](https://github.com/MSNsoftware)**.
