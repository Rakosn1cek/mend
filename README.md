# Mend (formerly RTFM)

**VERSION: v0.3.0**

**Mend** is a modular, fzf-powered recovery tool for Arch Linux. It "mends" your broken command chain by detecting failures (like missing PGP keys or locked databases) and offering a context-aware fix.
> [!IMPORTANT]
> **RTFM has been rebranded to Mend.** If you are an existing user, please see the [Migration](#-migration-from-rtfm) section below.

![RTFM Demo](assets/demo.png)

## What's New in v0.3.0

The **"Janitor & Detective"** update. This version moves Mend from a reactive tool to a proactive system assistant.

* **The Janitor:** Automatically detects orphaned dependencies (`-Qdtq`) and offers a one-click cleanup (`pacman -Rns`).
* **Dynamic History Depth:** Mend now "digs deeper." If an error isn't found in the immediate history, it recursively expands its search depth (up to 100 lines) to find the root cause.
* **Mirrorlist Health:** Detected a `404` or `Connection Timeout`? Mend now offers to trigger `reflector` to find the 10 fastest HTTPS mirrors for you.
* **Intelligent Execution:** Improved logic ensures Mend only opens search windows if the last command actually failed. No more ghost `fzf` windows.

## What's New in v0.2.0
[!TIP]
* **The Signature Update**: This version focuses on making AUR installations frictionless by handling GPG automation and refining shell history interaction.
* **PGP Key Auto-Fetch**: No more manual `gpg --recv-keys`. `mend` detects the missing ID and fetches it for you.
* **Zero-Conflict History**: Switched to `history -n` to prevent `mend` from accidentally opening your text editor (Micro/Vim) when reading command history.
* **Improved Logic Flow**: `mend` now intelligently skips over echo and itself to find the actual failed command that needs fixing.

---

## Features

* **[NEW v0.3.0] The Janitor (Orphan Sweep)**: Proactive detection of unused dependencies (`-Qdtq`) with a one-click cleanup option to keep your system lean.
* **[NEW v0.3.0] Smart Mirror Refresh**: Integrated `reflector` support to automatically fix `404` or `Connection Timeout` errors in your package manager.
* **[NEW v0.3.0] Recursive History Scanning**: High-performance iterative scanning that "digs deeper" into your history to find errors, even if you've run "noise" commands like `ls` or `cd`in between.
* **PGP Key Automation**: Detects "Unknown Public Key" errors during AUR installs and fetches them from `keyserver.ubuntu.com` automatically.
* **Intelligent Package Correction**: If a package install fails, `mend` searches both official repositories and the AUR to find the correct match.
* **Command-to-Package Mapping**: Uses `pacman -Fy` logic to identify which package provides a missing binary (e.g., offering to install `tree` when the command is not found).
* **Automatic Lock Detection**: Identifies `/var/lib/pacman/db.lck` and offers an interactive prompt to remove it safely.
* **Zero-Overhead Loading**: Built for Zsh using `autoload` functionality. The logic only hits your RAM when you actually call the command.

---

## Prerequisites

Ensure you have the following installed on your Arch system:
* **fzf** (`sudo pacman -S fzf`)
* **Zsh** (The shell this is built for)
* **yay or paru** (for AUR support)
* **pacman** (standard on Arch)

---

## Installation

## Clone the repository
Clone mend to your preferred directory:

```zsh
git clone https://github.com/Rakosn1cek/mend.git /path/to/your/choice/mend
```
## Installation instruction for OMZ users:
```zsh
git clone https://github.com/Rakosn1cek/mend.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/mend
```
## Add 'mend' to the plugins array in your ~/.zshrc
**plugins=(... mend)**

## Configure Zsh
Manual / Vanilla Zsh.
Add the following line to your ~/.zshrc:
```zsh
source /path/to/your/choice/mend/mend.plugin.zsh
```
## Initialize File Database
For the "Command Not Found" feature to work, ensure your local file database is up to date:
```zsh
sudo pacman -Fy
```
> **Note:** It is recommended to run this periodically (or via a timer) to keep the "Command-to-Package" mapping accurate.

___

## Usage
Simply run `mend` after a failed command or a "command not found" error.
**Example 1**: Missing Binary
```zsh
❯ tree
zsh: command not found: tree

❯ mend
# fzf opens, searches for 'tree', and prepares the install command
```
**Example 2**: PGP Signature Error (AUR) [NEW v0.2.0]
```zsh
❯ yay -S some-aur-package
==> ERROR: One or more PGP signatures could not be verified!
unknown public key 1397BC53640DE551

❯ mend
mend: Detected missing PGP key: 1397BC53640DE551
Import this key from keyserver? (y/n) y
# mend fetches the key and puts the 'yay' command back in your buffer
```

**[New in v0.3.0] Connection/Mirror Fix:**
If a download fails due to a dead mirror, Mend identifies the timeout and prompts:
`Mend: Detected connection/mirror issues. Update mirrorlist with Reflector? (y/n)`

**[New in v0.3.0] System Cleanup (The Janitor):**
If your system is healthy but has unused dependencies:
`Mend: Your system has orphaned dependencies. Remove orphaned packages? (pacman -Rns)`

**[New in v0.3.0] Deep History Search:**
Mend now scans past "noise" commands. If you run `ls` or `clear` five times after a PGP error, Mend will still find and offer to fix the original error.

___

## License
MIT © 2026 Rakosn1cek. Original logic and patterns for Arch-specific error interception. Attribution is required for any redistribution or derivative works.

[⭐ Star mend on GitHub](https://github.com/Rakosn1cek/mend)

---

## Support
If **mend** saved you some time today, feel free to buy me a coffee!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/Rakosn1cek)

## 🗺️ Roadmap

### v0.2.0 - The "Signature" Update (Current)
- [x] **PGP Key Auto-Fetch**: Detect GPG verification failures during AUR installs and fetch missing keys automatically.
- [x] **History Resilience**: Migration to `history -n` to prevent `$EDITOR` conflicts.
- [x] **Terminal Buffer Re-injection**: Re-propagate fixed commands back to the prompt.

### v0.3.0 - Intelligence & Cleanup
- [ ] **Orphan Cleanup**: Add a prompt to identify and remove orphaned dependencies (`-Rns`) after an uninstall.
- [ ] **Dynamic History Depth**: Automatically increase history search depth if a fix isn't found in the initial buffer.
- [ ] **Mirrorlist Health**: Detect "connection timed out" errors and offer to trigger a `reflector` mirror update.

### Long-term Research
- [ ] **Contextual Wiki Links**: Provide a direct URL to the relevant Arch Wiki section alongside the fix.
- [ ] **Smart History Search**: Suggest the most similar successful command from history when a typo occurs.
- [ ] **Fish & Bash Ports**: Exploring a POSIX-compliant core to bring mend logic to other shells.

## 📜 CHANGELOG

### v0.3.0 (2026-03-18) - The Janitor & Detective
* **Feature:** Added "The Janitor" – Automatic detection of orphaned dependencies (`-Qdtq`) with an interactive `pacman -Rns` prompt.
* **Feature:** Added "Reflector" integration – Detects `404` and `Connection Timeout` errors in history and offers to refresh the top 10 HTTPS mirrors.
* **Logic:** Implemented **Recursive History Scanning**. Mend now iteratively doubles its search depth (up to 100 lines) to find buried PGP or Mirror errors.
* **UX:** Added an exit-code check. Mend now skips the package search `fzf` window if the last command was successful (e.g., `ls` or `echo`).
* **Security:** Added a project header with versioning and ownership/license metadata.

### v0.2.1 (2026-03-16) - Rebrand & PGP
* **Rebrand:** Renamed project from `rtfm` to `mend`.
* **Feature:** Added PGP Public Key auto-fetch for AUR builds.
* **Compatibility:** Added official Oh My Zsh plugin support.

### [v0.2.0] - 2026-03-13
#### Added
- Automated GPG/PGP key fetching from `keyserver.ubuntu.com`.
- Visual feedback with colored status messages (Success/Error/Warning).
- Buffer re-injection for recovered AUR commands.

#### Changed
- Replaced `fc` with `history -n` to bypass `$EDITOR` conflicts.
- Refined history scraping to ignore `mend` and `echo` calls.
- Updated README with better usage examples and modular descriptions.

### [v0.1.0] - 2026-03-01
- Initial release.
- Support for `db.lck` detection and removal.
- Command-not-found integration using `pacman -F`.
- Basic `fzf` search for official and AUR packages.

## ⚠️ Known Issues
* **Zsh History Settings:** If your `HISTSIZE` is set extremely low or if you use `setopt HIST_IGNORE_ALL_DUPS`, mend might struggle to find the original failed command. 
* **Keyserver Downtime:** mend relies on `keyserver.ubuntu.com`. If that server is down or blocked by your network/firewall, PGP auto-fetch will fail (mend will notify you if this happens).
* **Subshell Execution:** Because mend relies on `history -n`, it may not detect errors generated inside nested subshells or some complex pipe chains.
* **Non-Standard Helpers:** Currently optimized for `yay`, `paru`, and `makepkg`. Other AUR helpers might have slightly different error strings that aren't caught yet.

## Migration from RTFM
**If you previously used RTFM**:

- Rename your local folder from `rtfm` to `mend`.

- Update your .zshrc (change `autoload -Uz rtfm` to `autoload -Uz mend`).

- The rtfm command is now an alias for mend to ensure your existing muscle memory still works.

> *Find a bug? Open an issue or submit a PR. I'm especially looking for PGP error strings from helpers other than yay/paru*
