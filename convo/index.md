# Conversation Index
# 2-4 lines per session: summary + key points + topics + pkgs + references

---

## 2026-02-22

**ses_379f** | computer
- Set up GitHub SSH - generated key, tested connection
- User asked about AI generating keys (security concern)
- Deleted AI-generated key, user will create password-protected one
- Fish greeting for SSH agent caused hanging (later removed)
- Topics: GitHub, SSH, ssh-agent, security, fish shell
- Groups: [computer/2026-02-22_github-setup.md](groups/computer/2026-02-22_github-setup.md) | Original: [2026-02-22/session-ses_379f.md](2026-02-22/session-ses_379f.md)

**ses_379d** | computer
- Tested GitHub access - confirmed via gh CLI and web tools
- SSH test showed host key needed - user ran ssh git@github.com
- Connection successful: "Hi DeathStar-hub! You've successfully authenticated"
- Topics: GitHub, SSH, testing
- Groups: [computer/2026-02-22_github-setup.md](groups/computer/2026-02-22_github-setup.md) | Original: [2026-02-22/session-ses_379d.md](2026-02-22/session-ses_379d.md)

**ses_37a5** | ai, computer
- Fixed jl command - created zoxide symlink, changed `ls -Alh` to `ls`
- Updated opencode.json to require running startup-protocol.sh
- Restructured convo/ groups to use individual .md files
- Topics: fish shell, zoxide, opencode, startup protocol, symlink
- PKGs: zoxide
- Groups: [ai/2026-02-22_jl-zoxide-fix.md](groups/ai/2026-02-22_jl-zoxide-fix.md) | Original: [2026-02-22/session-ses_37a5.md](2026-02-22/session-ses_37a5.md)

**ses_3b87** | computer, development
- Fixed Walker menu CSS import path (relative → absolute)
- Discussed multi-computer sync issues with Syncthing
- Explored GitHub for version control across computers
- Topics: Walker, CSS, theme, multi-computer sync, GitHub
- Groups: [computer/2026-02-10_walker-menu.md](groups/computer/2026-02-10_walker-menu.md) | Original: [2026-02-22/session-ses_3b87.md](2026-02-22/session-ses_3b87.md)

---

## 2026-02-20

**ses_384f** | computer
- Fixed waybar backup status showing wrong date
- Created backup-tracker system with waybar integration
- Topics: waybar, backup, shell scripts
- Groups: [computer/2026-02-20_backup-tracker.md](groups/computer/2026-02-20_backup-tracker.md) | Original: [2026-02-20/session-ses_384f.md](2026-02-20/session-ses_384f.md)

**ses_384c** | ai
- User typed "bannaa" test greeting - AI memory test
- Pattern: bannaa → apple (established test pattern)
- Topics: testing, AI memory, startup protocol
- Groups: [ai/2026-02-20_bannaa-test.md](groups/ai/2026-02-20_bannaa-test.md) | Original: [2026-02-20/session-ses_384c.md](2026-02-20/session-ses_384c.md)

**ses_384d** | personal
- Alberta taxes for truck driver with one employer
- Meal deduction: $69.30/day when away 24+ hours
- Topics: taxes, Alberta, CRA, truck driver
- Groups: [personal/2026-02-20_alberta-taxes.md](groups/personal/2026-02-20_alberta-taxes.md) | Original: [2026-02-20/session-ses_384d.md](2026-02-20/session-ses_384d.md)

**ses_384b** | ai
- Asked reverse: "apple = what?" - testing reverse of bannaa→apple
- No reverse mapping exists - pattern is one-way only
- Topics: testing, AI memory, pattern recognition
- Groups: [ai/2026-02-20_apple-reverse.md](groups/ai/2026-02-20_apple-reverse.md) | Original: [2026-02-20/session-ses_384b.md](2026-02-20/session-ses_384b.md)

**ses_384a** | ai
- User said "apple" - minimal test input
- Reverse of bannaa test
- Topics: testing, AI memory
- Groups: [ai/2026-02-20_apple-test.md](groups/ai/2026-02-20_apple-test.md) | Original: [2026-02-20/session-ses_384a.md](2026-02-20/session-ses_384a.md)

---

## 2026-02-19

**ses_396d** | ai
- "bannaa" test greeting
- AI ran startup protocol, sessions already organized
- Topics: testing, AI memory
- Groups: [ai/2026-02-19_bannaa-test.md](groups/ai/2026-02-19_bannaa-test.md) | Original: [2026-02-19/session-ses_396d.md](2026-02-19/session-ses_396d.md)

---

## 2026-02-08

**ses_3c18** | computer, development
- USB copy of AI folder hanging due to symlinks
- Found 50+ symlinks in AI/ (especially config/hypr/shaders/)
- Solutions: cp -L or rsync --copy-unsafe-links
- Topics: USB, symlinks, file copy, Hyprland
- Groups: [computer/2026-02-08_usb-symlinks.md](groups/computer/2026-02-08_usb-symlinks.md) | Original: [2026-02-22/session-ses_3c18.md](2026-02-22/session-ses_3c18.md)

---

## 2026-02-15

**ses_39d9** | computer
- Lock screen reappears after running SleepN
- Investigated hypridle.conf
- Ongoing issue
- Topics: Hyprland, sleep, lock screen, hypridle
- Groups: [computer/2026-02-15_sleepn-lock-screen.md](groups/computer/2026-02-15_sleepn-lock-screen.md) | Original: [2026-02-16/session-ses_39d9.md](2026-02-16/session-ses_39d9.md)

---

## Older Sessions

See dated folders in ~/AI/convo/ for full history:
- 2026-02-16, 2026-02-15, 2026-02-14, 2026-02-07, etc.

---

## 📝 Footnote

**For next computer:**
1. Run: `~/AI/startup-protocol.sh`
2. Check index.md and groups/ for context
3. jl fix: `ln -sf /usr/bin/zoxide ~/.local/bin/zoxide`
4. Commit/push changes with `~/AI/git-commit.sh`

**This structure is YOUR invention** - Smart Context Retrieval system (dated folders + topical subdirectories + linked index)
