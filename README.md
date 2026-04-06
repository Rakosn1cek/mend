# Mend

Version: [0.6.0]

**Mend** is a clever little helper for your Linux computer that steps in when things go wrong.
If you try to run a command and it fails, or if your system says a file is missing, you just type `mend` and it tries to fix the problem for you.
Mend was originally created to manage my own system running on Arch. Now it works across most popular versions of Linux like Arch, openSUSE, Fedora, and Ubuntu/Mint.

![RTFM Demo](assets/demo.png)


## What it does for you

Most of the time, Linux errors are just small hurdles. You might be missing a specific bit of software, a security key, or another update might be blocking your progress. Mend looks at the very last thing that happened on your screen, figures out why it failed, and offers you a one-click fix.
It can help you find and install missing programmes even if you don't know their exact names. It also handles the "behind the scenes" maintenance, like clearing out old files you no longer need or refreshing your connection to the update servers if they're being slow.

## Must have for **Mend** to work
**Zsh**: The specific command-line shell the tool is written for.
**fzf**: Provides the interactive menus and search windows.
**sudo**: Required to fix system files or install software.
**Package Managers**: One of the following: pacman (Arch), apt (Ubuntu/Mint), zypper (openSUSE), or dnf (Fedora).
**apt-file**: Only for Ubuntu or Mint systems to find missing library files.
**Standard Linux Tools**: Uses common tools like grep, sed, awk, and history to read and understand your error messages.
**Internet Access**: Needed to fetch security keys or download missing files.

## Getting started

1. **Download the tool**
Copy the files to your computer by running:
 `git clone https://github.com/Rakosn1cek/mend.git ~/mend`

2. **Set it up**
Add this line to the bottom of your `.zshrc` file:
 `source ~/mend/mend.plugin.zsh`

3. **Initialize File Database (Arch only)**
For "Command Not Found" and library repairs to work, sync your database:
 `sudo pacman -Fy`
> *Note: From v0.5.0, Mend will prompt you if this is missing or older than 7 days.*

4. **Ready to go**
Restart your terminal. Now, whenever you see an error, just type `mend`.

## How to use it

If you see an error like "command not found" or "missing library," simply type mend immediately after. A menu will pop up with the most likely solutions. Pick the one that looks right, and Mend will take care of the rest. You can also press [w] while in the menu to open a relevant help page in your web browser.

## A quick note on safety

Mend is designed to be a helpful assistant, not a replacement for your own judgement. It will always ask for your permission before making any changes or installing new software. 

---

**In progress**
- [ ] **Smart History Search**: Suggest the most similar successful command from history when a typo occurs.

**Future Research**
- [ ] **Fish & Bash Ports**: Exploring a POSIX-compliant core to bring mend logic to other shells.

## 📜 CHANGELOG

For a detailed history of all versions and technical changes, please see the [CHANGELOG.md](https://github.com/Rakosn1cek/mend/blob/main/CHANGELOG.md).

## ⚠️ Known Issues
* **Zsh History Settings:** Mend works by scanning your recent command history to find what went wrong. If your system is set up to ignore duplicate commands or has a very small history limit, Mend might not be able to "see" the error it needs to fix. 
* **Keyserver Downtime:** Mend relies on `keyserver.ubuntu.com`. If that server is down or blocked by your network/firewall, PGP auto-fetch will fail (mend will notify you if this happens).
* **Subshell Execution:** Commands run inside brackets, complex pipes, or nested scripts often don't save to the main history file in a way that Mend can read, so it might miss errors generated there.
* **Unique Error Messages:** While Mend is built to understand most common Linux errors, a very obscure tool might use a unique error message that isn't in the "knowledge base" yet. If Mend doesn't recognise the text, it won't know how to offer a fix.

## License
MIT © 2026 Rakosn1cek. Attribution is required for any redistribution or derivative works.

[⭐ Star mend on GitHub](https://github.com/Rakosn1cek/mend)

---

## Support
If **mend** saved you some time today, feel free to buy me a coffee!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/Rakosn1cek)

> *Found a bug? Open an issue on GitHub, please.*
