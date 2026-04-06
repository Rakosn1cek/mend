## 📜 CHANGELOG

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
