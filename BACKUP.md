# Rice backup — personal restore notes

Fork of [glyph-rice](https://github.com/Nebelung-cloud/glyph-rice) (GPL-3.0) with olly's local changes, personal overlay and desktop state. Private — do not publish.

## What's here

- **git history** — full upstream history plus local commits (Fedora/WhiteSur/Ghostty tweaks, suspend/resume clock fix, Brave, cava via pulse, slimmer starship).
- **`config/hypr/user.lua`** — personal hyprland binds and tweaks (in upstream's `.gitignore` on purpose).
- **`config/hypr/hyprlock.conf`** — fallback lock for hyprlock (unused in practice — `rice lock` is qs).
- **`config/hypr/monitors.conf`, `workspaces.conf`** — empty stubs kept from the old config.
- **`state/glyph.json`** — shell prefs: palette, bar/home layout, widgets, corners, recording options (copy to `~/.local/state/rice/glyph.json`).
- **`state/rules.json`** — Prefs state: gaps, blur, lock/DPMS/sleep timeouts, refresh rate, power profile (copy to `~/.config/demonshot/rules.json`). The shell rewrites `~/.config/demonshot/hypridle.conf` from this on start-up — no need to back that up.
- **`state/shell`** — which shell is current (`glyph`). Copy to `~/.local/state/rice/shell` or it defaults fine.

Note: `glyph.json` has absolute paths (`wallDir` → `/home/olly/Pictures/wallpapers`). Fix paths if the username or layout differs. Wallpapers are not in this repo.

## Restore on a new machine

```sh
git clone https://github.com/olly-techie/rice-backup.git ~/.local/share/glyph
cd ~/.local/share/glyph
./install.sh              # packages + symlinks (~/.config/* → this repo)
cp state/glyph.json ~/.local/state/rice/glyph.json
mkdir -p ~/.config/demonshot
cp state/rules.json ~/.config/demonshot/rules.json
cp state/shell ~/.local/state/rice/shell
# wallpapers by hand to ~/Pictures/wallpapers
rice restart              # or log out/in
```

`~/.git` credentials are **not** part of the backup — set up SSH or a token on the new machine.
