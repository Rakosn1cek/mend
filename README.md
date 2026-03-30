# Mend

**VERSION: v0.5.0**

**Mend** is a modular, fzf-powered recovery tool for Arch Linux. It "mends" your broken command chain by detecting failures (like missing PGP keys or locked databases) and offering a context-aware fix.

![RTFM Demo](assets/demo.png)


## Features
* **[NEW v0.5.0] Shared Library Repair**: Identifies an error while loading shared libraries from your shell history.
* **Intelligent Version Fallback**: If an exact library version (e.g., .so.13) is no longer in the repos, Mend automatically searches for the base provider (e.g., .so) to bridge the gap between your apps and the latest Arch rolling-release updates.
* **Physical File Verification**: Performs a systematic check in `/usr/lib/` to confirm a library is truly missing before suggesting a reinstall, preventing unnecessary package operations.
* **[NEW v0.4.0] Integrated Arch Wiki**: Press `[w]` inside any fix menu to open web browser directly to the relevant troubleshooting section on the Arch Wiki.
* **[NEW v0.3.0] The Janitor (Orphan Sweep)**: Proactive detection of unused dependencies (`-Qdtq`) with a one-click cleanup option to keep your system lean.
* **[NEW v0.3.0] Smart Mirror Refresh**: Integrated `reflector` support to automatically fix `404` or `Connection Timeout` errors in your package manager.
* **[NEW v0.3.0] Recursive History Scanning**: High-performance iterative scanning that "digs deeper" into your history to find errors, even if you've run "noise" commands like `ls` or `cd` in between.
* **PGP Key Automation**: Detects "Unknown Public Key" errors during AUR installs and fetches them from `keyserver.ubuntu.com` automatically.
* **Intelligent Package Correction**: If a package install fails, `mend` searches both official repositories and the AUR to find the correct match.
* **Command-to-Package Mapping**: Uses `pacman -Fy` logic to identify which package provides a missing binary (e.g., offering to install `tree` when the command is not found).
* **Automatic Lock Detection**: Identifies `/var/lib/pacman/db.lck` and offers an interactive prompt to remove it safely.
* **Resource-efficient Loading**: Built for Zsh using `autoload` functionality. The logic only hits your RAM when you actually call the command.

---

## Prerequisites

Ensure you have the following installed on your Arch system:
* **fzf** (`sudo pacman -S fzf`)
* **Zsh** (The shell this is built for)
* **yay or paru** (for AUR support)
* **pacman** (standard on Arch)
* **pacman-contrib** (Optional: for paccache cleanup)

---

## Installation

## Clone the repository
**Clone mend to your preferred directory:**

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
**Manual / Vanilla Zsh.**
**Add the following line to your ~/.zshrc:**
```zsh
source /path/to/your/choice/mend/mend.plugin.zsh
```
## Initialize File Database
**For Command Not Found and Shared Library Repair to function, your local file database must be synced:**
```zsh
sudo pacman -Fy
```
> **Note**: Mend v0.5.0 will now prompt you to run this if your database is missing or older than 7 days.

___

## Usage
Simply run `mend` after a failed command or a "command not found" error.
**Example 1: Missing Binary**
```zsh
❯ tree
zsh: command not found: tree

❯ mend
# fzf opens, searches for 'tree', and prepares the install command
```
**Example 2: PGP Signature Error (AUR) [NEW v0.2.0]**
```zsh
❯ yay -S some-aur-package
==> ERROR: One or more PGP signatures could not be verified!
unknown public key 1397BC53640DE551

❯ mend
mend: Detected missing PGP key: 1397BC53640DE551
Import this key from keyserver? (y/n) y
# mend fetches the key and puts the 'yay' command back in your buffer
```
**Example 3: Database Lock Error [NEW v0.4.0]**
```zsh
❯ sudo pacman -S tree
error: failed to init transaction (unable to lock database)
if you're sure a package manager is not already running, you can remove /var/lib/pacman/db.lck

❯ mend
# Mend detects the ghost lock, offers a fix, and provides the Wiki shortcut
Mend: Ghost lock file detected. This typically occurs after a crash.
[w] Wiki: [System maintenance](https://wiki.archlinux.org/title/Pacman#%22Failed_to_init_transaction_(unable_to_lock_database)%22_error)
```
**Example 4: Missing Library [New v0.5.0]**
```zsh
❯ teamspeak3
teamspeak3: error while loading shared libraries: libssl.so.1.1: cannot open shared object file

❯ mend
# Mend detects the version mismatch, finds the provider, and offers a fix
```

---

## License
MIT © 2026 Rakosn1cek. Original logic and patterns for Arch-specific error interception. Attribution is required for any redistribution or derivative works.

[⭐ Star mend on GitHub](https://github.com/Rakosn1cek/mend)

---

## Support
If **mend** saved you some time today, feel free to buy me a coffee!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/Rakosn1cek)

## Roadmap
### v0.2.0 - The "Signature" Update (Current)
- [x] **PGP Key Auto-Fetch**: Detect GPG verification failures during AUR installs and fetch missing keys automatically.
- [x] **History Resilience**: Migration to `history -n` to prevent `$EDITOR` conflicts.
- [x] **Terminal Buffer Re-injection**: Re-propagate fixed commands back to the prompt.

### v0.3.0 - Intelligence & Cleanup
- [x] **Orphan Cleanup**: Add a prompt to identify and remove orphaned dependencies (`-Rns`) after an uninstall.
- [x] **Dynamic History Depth**: Automatically increase history search depth if a fix isn't found in the initial buffer.
- [x] **Mirrorlist Health**: Detect "connection timed out" errors and offer to trigger a `reflector` mirror update.

### Long-term Research
- [x] **Contextual Wiki Links**: Provide a direct URL to the relevant Arch Wiki section alongside the fix. [Added in v0.4.0]

**In progress**
- [ ] **Smart History Search**: Suggest the most similar successful command from history when a typo occurs.

**Future Research**
- [ ] **Fish & Bash Ports**: Exploring a POSIX-compliant core to bring mend logic to other shells.

## 📜 CHANGELOG

For a detailed history of all versions and technical changes, please see the [CHANGELOG.md](https://github.com/Rakosn1cek/mend/blob/main/CHANGELOG.md).

## ⚠️ Known Issues
* **Zsh History Settings:** If your `HISTSIZE` is set extremely low or if you use `setopt HIST_IGNORE_ALL_DUPS`, mend might struggle to find the original failed command. 
* **Keyserver Downtime:** mend relies on `keyserver.ubuntu.com`. If that server is down or blocked by your network/firewall, PGP auto-fetch will fail (mend will notify you if this happens).
* **Subshell Execution:** Because mend relies on `history -n`, it may not detect errors generated inside nested subshells or some complex pipe chains.
* **Non-Standard Helpers:** Currently optimised for `yay`, `paru`, and `makepkg`. Other AUR helpers might have slightly different error strings that aren't caught yet.

> *Find a bug? Open an issue or submit a PR. I'm especially looking for PGP error strings from helpers other than yay/paru*
