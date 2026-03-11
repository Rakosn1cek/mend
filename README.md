# RTFM (Real-Time Fix Manager)

Version: v0.1.1

A modular, lazy-loaded Zsh plugin for Arch Linux. Instead of searching the Wiki for why a command failed, `rtfm` uses `fzf` to resolve package conflicts, find missing binaries, and clear database locks.

![RTFM Demo](assets/demo.png)

## Features

* **Intelligent Package Correction:** If `pacman` fails to find a package, `rtfm` searches both official repositories and the AUR to find the correct match.
* **Command-to-Package Mapping:** Uses `pacman -Fy` logic to identify which package provides a missing binary (e.g., typing `tree` when it's not installed).
* **Automatic Lock Detection:** Detects `/var/lib/pacman/db.lck` and offers an interactive prompt to remove it.
* **Zero-Overhead Loading:** Uses Zsh's `autoload` functionality. The logic only hits your RAM when you actually run the command.

## Prerequisites

Ensure you have the following installed on your Arch system:
* **fzf** (`sudo pacman -S fzf`)
* **yay** (or another AUR helper compatible with `yay` syntax)
* **Zsh** (The shell this is built for)

## Installation

### 1. Clone the repository
Choose a location for your plugins (e.g., `~/arch-projects/` or `~/.config/zsh/plugins/`):

```zsh
mkdir -p ~/arch-projects
git clone [https://github.com/Rakosn1cek/RTFM.git](https://github.com/Rakosn1cek/RTFM.git) ~/arch-projects/RTFM
echo "source ~/arch-projects/rtfm/rtfm.plugin.zsh" >> ~/.zshrc
```
## Installation instruction for OMZ users:
```zsh
git clone https://github.com/Rakosn1cek/RTFM.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/rtfm
```
# Add 'rtfm' to the plugins array in your ~/.zshrc
# plugins=(... rtfm)

## Configure Zsh
Add the following line to your ~/.zshrc:
```zsh
source ~/arch-projects/RTFM/rtfm.plugin.zsh
```
## Initialize File Database
For the "Command Not Found" feature to work, ensure your local file database is up to date:
```zsh
sudo pacman -Fy
```
## Usage
Simply run rtfm after a failed command or a "command not found" error.
*Example*
```zsh
❯ tree
zsh: command not found: tree

❯ rtfm
# fzf opens, searches for 'tree', and prepares the install command
```
## License
This project is licensed under the MIT License - see the LICENSE file for details.

[⭐ Star RTFM on GitHub](https://github.com/Rakosn1cek/RTFM)
