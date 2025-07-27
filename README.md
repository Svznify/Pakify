```
 ______     _    _  __       
| ___ \   | |  (_)/ _|      
| |_/ /_ _| | ___| |_ _   _
|  __/ _` | |/ / |  _| | | |
| | | (_| |   <| | | | |_| |
\_|  \__,_|_|\_\_|_|  \__, |
                       __/ |
                      |___/

✨ Pakify — Web App to Desktop App Builder for Windows* ✨
```

---

## 🧠 What is Pakify?

**Pakify** is a beautiful, interactive PowerShell tool that helps you turn any website into a fully packaged desktop application using [Pake](https://github.com/tw93/Pake) for Windows*

It handles:

* ✅ Auto-installing Node.js, Rust, and Pake
* ✅ Verifying if MSVC Build Tools are installed
* ✅ Simple guided app creation with optional flags
* ✅ Creating EXEs from your favorite sites!

---

## 🚀 Features

* Interactive terminal prompts (no boring typing!)
* Auto-detect + install dependencies (Rust, Node, VS Build Tools)
* Flags for:

  * `--fullscreen`
  * `--hide-title-bar`
  * `--disable-web-shortcuts`
* ASCII-styled console with emoji flair 😎

---

## 🔧 Requirements

* Windows 10+
* PowerShell 5.1+ (with execution policy set to allow scripts)
* Internet connection (of course you need Internet)

---

## 📦 How to Use

### a. by Powershell
1. Clone or download this repo
2. Run `Pakify.ps1` in PowerShell:

   ```powershell
   ./Pakify.ps1
   ```
3. Follow the prompts!
### b. by Executable
1. Go to [Releases](/releases)
2. Download `Pakify.exe`
3. Run it
---

## 🛠️ Example Output

```
[*] Checking Dependencies
======================================
[√] NodeJS is already installed.
[√] Rust is already installed.
[√] pake-cli is already installed.

[*] App Configuration
======================================
Website URL: https://youtube.com
App Name: 1Anime
Icon Path: https:/youtube.com/favicon.ico
Fullscreen: yes

[*] Launching pake...
[√] Build complete. Your app should be in the output folder.
```

---

## 💬 Credits

Built with love by the community.
Inspired by [Pake](https://github.com/tw93/Pake) and made stylish with a sprinkle of ✨.

---

## 📜 License

MIT — free to use, share, modify. Just don’t sell it without saying *thank you* 😌.

### *Yes, it's only made for Windows- and this is for beginneers. (You can PR if you want to)