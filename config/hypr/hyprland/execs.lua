local vars = require("variables")
local fn   = require("hyprland.functions")

hl.on("hyprland.start", function()
    -- Shell: тот, что выбран в rice
    hl.exec_cmd(vars.rice .. " start")

    -- лок сразу после загрузки: автологин greetd, но стол сразу закрыт
    hl.exec_cmd(vars.lockCmd)

    -- во вложенной сессии системные демоны уже работают снаружи
    if vars.nested then return end

    -- Keyring and auth (polkit agent runs via systemd user unit: hyprpolkitagent)
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- polkit: hyprpolkitagent (~29 МБ PSS) заменён на lxqt-policykit (~5 МБ), юнит больше не нужен
    hl.exec_cmd("/usr/libexec/lxqt-policykit-agent")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Auto delete trash 30 days old
    hl.exec_cmd("trash-empty 30")

    -- Cursors
    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. vars.cursorTheme)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)

    -- Location provider
    hl.exec_cmd("/usr/libexec/geoclue-2.0/demos/agent")

    -- Forward bluetooth media commands to MPRIS
    hl.exec_cmd("mpris-proxy")

    -- hypridle поднимает шелл (Rules.idle): тайминги из house rules → ~/.config/demonshot/hypridle.conf

    -- (ghostty не умеет прятать окно при старте, как kitty --start-as=hidden — prewarm выключен)
end)

-- Resizer listener
hl.on("window.title", function(win)
    local d = {
        hl.dsp.window.float({ action = "on", window = win }),
        hl.dsp.window.center({ window = win }),
    }
    local pip = fn.move_actions(win) or {}

    fn.resizer(win, "Bitwarden", 20, 54, d, true)
    fn.resizer(win, "Picture[- ]in[- ][Pp]icture", 0, 0, pip, false)
end)

hl.on("window.open", function(win)
    local d = {
        hl.dsp.window.float({ action = "on", window = win }),
        hl.dsp.window.center({ window = win }),
    }
    local pip = fn.move_actions(win) or {}

    fn.resizer(win, "Bitwarden", 20, 54, d, true)
    fn.resizer(win, "Picture[- ]in[- ][Pp]icture", 0, 0, pip, false)
end)
