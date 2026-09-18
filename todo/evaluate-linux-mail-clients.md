# Evaluate Linux Mail Clients

## Goal
Research and test popular professional-grade mail clients for Linux to find a suitable replacement for web-based email workflows.

## Implementation Plan

1. **Define Requirements**
   - Primary email providers to support (Gmail, Outlook, custom domains)
   - Must-have features (unified inbox, calendar, contacts, search)
   - Performance requirements
   - Integration needs (GNOME desktop, existing workflow)

2. **Test Top Candidates**
   - Thunderbird (latest redesigned version)
   - Mailspring (free + pro evaluation)
   - Wavebox (trial period)
   - BlueMail
   - Web-based PWA alternatives

3. **Evaluation Criteria**
   - Installation method (Nix package, Flatpak, AppImage)
   - Account setup complexity
   - Performance with multiple accounts
   - Search functionality
   - Calendar/contacts integration
   - Keyboard shortcuts support
   - GNOME integration quality

4. **Configuration Integration**
   - Add chosen client to `nix/pc/packages.nix` if available in nixpkgs
   - Configure application settings
   - Test backup/restore of configuration
   - Document setup process

## Source Code Areas Affected

### NixOS Configuration
- `nix/pc/packages.nix` - Add mail client package
- `nix/pc/configuration.nix` - May need to enable additional services (e.g., GNOME Online Accounts)

### User Configuration
- `.config/{mail-client}/` - Application-specific config (if needed for dotfiles)
- May need stow package updates if configs are managed

### Documentation
- Update CLAUDE.md if mail client becomes part of standard workflow
- Add setup instructions if configuration is complex
