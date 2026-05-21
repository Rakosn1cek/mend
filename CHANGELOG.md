## 📜 CHANGELOG

## [0.8.4] - 2026-05-20

### Fixed
- Optimised shell history matching pool logic within `functions/history` to resolve early mutation typos (e.g., `ccd` instead of `cd`). Implemented a deterministic single-character prefix filter that preserves argument matching inside trailing directories while preventing wide-pool history pollution from unrelated commands.

### Known Issue
- Mend will not be able to match a typo and suggest fix if it happens at the very first character. This is a sacrifice that has been well thought through during testing to limit unrelated outputs in the fuzzy-search.

---

## [0.8.3] - 2026-05-18

### Added
- New interactive deployment module (`mend -git`) featuring a fully non-destructive `fzf` TUI for repository initialization, remote tracking layout configuration, commit compilation, and annotated release tagging.
- Automated next-point release version prediction inside the Git deployment tag selection stream.
- Comprehensive user documentation entries for the Git deployment tool inside the README usage and help systems.

### Fixed
- Re-architected the history assistant (`mend -h`) to eliminate duplicate suggestion entries by dropping parallel array appending loops.
- Replaced strict fuzzy query locking with a lightweight two-character prefix constraint, dropping background command noise while resolving hidden match bugs for directory path and package manager typos.
- Corrected terminal buffer flooding and Zsh 1-index subscript failures within the proximity sorting pipeline.
- Resolved execution path calculation failures across standard desktop workspaces by dynamically targeting context layout blocks inside the master wrapper.

---

## [0.8.2] - 2026-05-14
### Added
- Expanded hardware.db with legacy support for NVIDIA NVS 3100M and Intel 5 Series chipset components.
- Added mapping for Intel Centrino Advanced-N 6200 wireless and 82577LM Gigabit networking.

### Fixed
- Function `mend -h` has been fixed and is fully working. It still depends on `history` to find the correct string/command.

---

## [0.8.1] - 2026-05-11
### Added
- AUR Integration: Formal support for zsh-mend-git package installation.
- Hardware Expansion: Added new mappings for Realtek Wi-Fi 6 (rtw89), NVIDIA 3070 Mobile, and Renesas USB controllers to hardware.db.
- Path Validation: Added a safety check for $HISTFILE presence to prevent errors during history purging

### Fixed
- Path Portability: Migrated all internal logic from hardcoded home directory paths to dynamic $MEND_DIR and $MEND_DATA_DIR variables.
- Environment Visibility: Implemented variable exporting in the plugin entry point to ensure sourced sub-modules inherit the correct data paths.
- System Path Fallback: Added logic to automatically detect and use /usr/share/zsh/plugins/mend/ when running as a system-wide package.

### Changed
- Plugin Structure: Removed legacy rtfm bridge and default fix alias to allow for cleaner system-level integration and user customisation.
- Refined Dependencies: Updated requirements to include pciutils and util-linux for better reliability on minimal installations.

---

## [0.8.0] - 2026-05-10
### Added
- New hardware scanner feature (`mend -s`).
- Support for Audio, Ethernet, and USB/Bluetooth controllers.
- Mapping logic for pacman, apt, dnf, and zypper.
- Expanded hardware.db with Intel, AMD, and Realtek IDs.

### Changed
- Updated lspci filtering to include a wider range of essential hardware.
- Refined fzf interface for better package previews.

---

## [0.7.0] - 2026-04-14
### Added
- New `mend -h` flag to trigger an interactive history-based correction mode.
- Automatic history purging: selecting a correction now removes all instances of that specific typo from the Zsh history file and internal buffer.
- Integrated fzf scoring with a specific history scheme to better rank long command strings and complex arguments.

### Improved
- Refactored history search to use a prefix-based fuzzy match, significantly reducing noise from unrelated commands.
- Optimised history handling for large files (20,000+ entries) by using native Zsh buffer management.
- Enhanced typo detection by utilising the full string length for weighted ranking in the suggestion menu.

### Fixed
- Resolved an issue where repeated typos would persist in the history list even after being corrected.
- Fixed a bug causing history inflation when syncing buffers across multiple terminal sessions.
- Corrected a scoring scheme error in fzf to ensure compatibility with standard Arch Linux installations.

---

## [v0.6.0] - 2026-04-06
### Added
- Distro-Agnostic Core: Full rewrite to support Arch (pacman), openSUSE (zypper), Fedora (dnf), and Ubuntu/Mint (apt).
- Dynamic Driver Setup: Automatic package manager detection and path mapping for locks, queries, and installs.
- Unified Knowledge Base: Migrated error descriptions and Wiki links into a modular MEND_KB associative array for all supported distributions.
- Agnostic Library Search: New provider extraction logic that handles different table formats across apt-file, zypper, and dnf repoquery.
- The Janitor (Multi-Distro): Added orphan cleanup support for apt autoremove, dnf autoremove, and zypper packages --unneeded.

### Fixed
- Table Parsing: Implemented robust header-skipping and column-index logic to handle padded output from Zypper and DNF.
- Clean Selection: Added xargs and Zsh parameter stripping to ensure package names are passed to the installer without accidental spaces or colons.

### Changed
- Documentation: Simplified the README to focus on readable instructions and universal requirements.

---

## [v0.5.0] - 2026-03-27
### Added
- Shared Library Repair: New detection engine for error while loading shared libraries.
- Intelligent Version Fallback: Implemented automatic base-name searching (e.g., libalpm.so.13 → libalpm.so) to resolve rolling-release version increments.
- Physical File Verification: Added a pre-search check for files in /usr/lib/ and /lib/ to confirm a library is truly missing before suggesting repairs.
- Database Age Nudge: Integrated a check for `pacman -Fy` database metadata. Mend now warns if the sync database is missing or older than 7 days.
- Arch Wiki Shortcut: Added [w] keybinding to the library provider menu, linking directly to System Maintenance documentation.

### Fixed
- Search Noise: Filtered out "private" bundled libraries (e.g., /opt/teamspeak3/) by prioritising system-wide library paths in the provider search.
- String Parsing: Replaced brittle awk/sed pipes with native Zsh parameter expansion for safer package name extraction.
- FZF Preview: Corrected the preview command to ensure `pacman -Si` always receives a clean package name string.

### Changed
-Internal Logic: Optimised the library search to use a single while loop with internal Zsh splitting, reducing subshell overhead.
- README: Migrated full version history to CHANGELOG.md and streamlined the main documentation for better readability.

---

## [0.4.0] - 2026-03-22
### Added
- Integrated Knowledge Base (MEND_KB) for standardized error descriptions and Wiki links.
- Deep-linking support for Arch Wiki troubleshooting sections.
- Unified FZF header styling with keyboard shortcut hints.
- Terminal buffer normalisation using `clear` to prevent redraw bugs on full screens.

### Fixed
- Resolved "Double Print/Ghosting" bug when returning from the browser.
- Fixed variable leakage where the wrong Wiki page would open in sequential errors.
- Corrected FZF height and layout for better readability on small terminal windows.
### Changed
- Moved Knowledge Base initialisation inside the function for better scope management.
- Switched to native Zsh string expansion for faster metadata parsing.

---

## [v0.3.0] - 2026-03-18
### Added 
- The Janitor: Automatic detection of orphaned dependencies (`-Qdtq`) with an interactive `pacman -Rns` prompt.
- Reflector integration: Detects `404` and `Connection Timeout` errors and offers to refresh the top 10 HTTPS mirrors.
- Recursive History Scanning: Implemented a doubling search depth (up to 100 lines) to find buried errors past "noise" commands.

##Fixed
 - Added an exit-code check to prevent `fzf` from opening if the last command was successful.

## Security 
- Added project headers with versioning, ownership, and MIT license metadata.

---

## [v0.2.1] - 2026-03-15
### Changed
- **Rebrand**: Project officially renamed from **RTFM** to **Mend**.
- Project Structure: Updated for full **Oh My Zsh** compatibility.
- Function Name: Main command changed to `mend`.
- Legacy Support: Added `rtfm` bridge so old commands still work.

---

## [v0.2.0] - 2026-03-13
### Added
- Automated GPG/PGP key fetching from `keyserver.ubuntu.com`.
- Visual feedback with colored status messages (Success/Error/Warning).
- Buffer re-injection for recovered AUR commands.

### Changed
- Replaced `fc` with `history -n` to bypass `$EDITOR` conflicts.
- Refined history scraping to ignore `mend` and `echo` calls.
- Updated README with better usage examples and modular descriptions.

---

## [v0.1.0] - 2026-03-01
- Initial release.
- Support for `db.lck` detection and removal.
- Command-not-found integration using `pacman -F`.
- Basic `fzf` search for official and AUR packages.
