# RTFM (Real-Time Fix Manager)

Version: v0.2.0

A modular, lazy-loaded Zsh plugin for Arch Linux. Built for developers who know the Wiki but want to automate the friction. RTFM handles the "manual" work of resolving package locks, missing PGP keys, and binary owner lookups so you can stay in the flow.

![RTFM Demo](assets/demo.png)

## What's New in v0.2.0
[!TIP]
* **The Signature Update**: This version focuses on making AUR installations frictionless by handling GPG automation and refining shell history interaction.
* **PGP Key Auto-Fetch**: No more manual `gpg --recv-keys`. RTFM detects the missing ID and fetches it for you.
* **Zero-Conflict History**: Switched to `history -n` to prevent RTFM from accidentally opening your text editor (Micro/Vim) when reading command history.
* **Improved Logic Flow**: RTFM now intelligently skips over echo and itself to find the actual failed command that needs fixing.

## Features

* **[NEW v0.2.0] PGP Key Automation:** Detects "Unknown Public Key" errors during AUR installs and offers to fetch them from a keyserver automatically.
* **Intelligent Package Correction:** If `pacman` fails to find a package, `rtfm` searches both official repositories and the AUR to find the correct match.
* **Command-to-Package Mapping:** Uses `pacman -Fy` logic to identify which package provides a missing binary (e.g., typing `tree` when it's not installed).
* **Automatic Lock Detection:** Detects `/var/lib/pacman/db.lck` and offers an interactive prompt to remove it.
* **Zero-Overhead Loading:** Uses Zsh's `autoload` functionality. The logic only hits your RAM when you actually run the command.

## Prerequisites

Ensure you have the following installed on your Arch system:
* **fzf** (`sudo pacman -S fzf`)
* **Zsh** (The shell this is built for)
* **yay or paru** (for AUR support)
* **pacman** (standard on Arch)

## Installation

## Clone the repository
Clone RTFM to your preferred directory:

```zsh
git clone https://github.com/Rakosn1cek/RTFM.git /path/to/your/choice/rtfm
```
## Installation instruction for OMZ users:
```zsh
git clone https://github.com/Rakosn1cek/RTFM.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/rtfm
```
## Add 'rtfm' to the plugins array in your ~/.zshrc
**plugins=(... rtfm)**

## Configure Zsh
Manual / Vanilla Zsh.
Add the following line to your ~/.zshrc:
```zsh
source /path/to/your/choice/rtfm/rtfm.plugin.zsh
```
## Initialize File Database
For the "Command Not Found" feature to work, ensure your local file database is up to date:
```zsh
sudo pacman -Fy
```
> **Note:** It is recommended to run this periodically (or via a timer) to keep the "Command-to-Package" mapping accurate.

## Usage
Simply run rtfm after a failed command or a "command not found" error.
**Example 1**: Missing Binary
```zsh
❯ tree
zsh: command not found: tree

❯ rtfm
# fzf opens, searches for 'tree', and prepares the install command
```
**Example 2**: PGP Signature Error (AUR) [NEW v0.2.0]
```zsh
❯ yay -S some-aur-package
==> ERROR: One or more PGP signatures could not be verified!
unknown public key 1397BC53640DE551

❯ rtfm
RTFM: Detected missing PGP key: 1397BC53640DE551
Import this key from keyserver? (y/n) y
# RTFM fetches the key and puts the 'yay' command back in your buffer
```

## License
This project is licensed under the MIT License - see the LICENSE file for details.

[⭐ Star RTFM on GitHub](https://github.com/Rakosn1cek/RTFM)

---

## Support
If **RTFM** saved you some time today, feel free to buy me a coffee!

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
- [ ] **Fish & Bash Ports**: Exploring a POSIX-compliant core to bring RTFM logic to other shells.

## 📜 CHANGELOG

### [v0.2.0] - 2026-03-13
#### Added
- Automated GPG/PGP key fetching from `keyserver.ubuntu.com`.
- Visual feedback with colored status messages (Success/Error/Warning).
- Buffer re-injection for recovered AUR commands.

#### Changed
- Replaced `fc` with `history -n` to bypass `$EDITOR` conflicts.
- Refined history scraping to ignore `rtfm` and `echo` calls.
- Updated README with better usage examples and modular descriptions.

### [v0.1.0] - 2026-02-01
- Initial release.
- Support for `db.lck` detection and removal.
- Command-not-found integration using `pacman -F`.
- Basic `fzf` search for official and AUR packages.

## ⚠️ Known Issues
* **Zsh History Settings:** If your `HISTSIZE` is set extremely low or if you use `setopt HIST_IGNORE_ALL_DUPS`, RTFM might struggle to find the original failed command. 
* **Keyserver Downtime:** RTFM relies on `keyserver.ubuntu.com`. If that server is down or blocked by your network/firewall, PGP auto-fetch will fail (RTFM will notify you if this happens).
* **Subshell Execution:** Because RTFM relies on `history -n`, it may not detect errors generated inside nested subshells or some complex pipe chains.
* **Non-Standard Helpers:** Currently optimized for `yay`, `paru`, and `makepkg`. Other AUR helpers might have slightly different error strings that aren't caught yet.

> *Find a bug? Open an issue or submit a PR. I'm especially looking for PGP error strings from helpers other than yay/paru*
