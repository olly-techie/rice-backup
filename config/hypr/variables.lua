local scheme = require("scheme.demonshot")
local home   = os.getenv("HOME")

-- DEMONSHOT_NESTED=1 Hyprland -c …/rice/config/hypr/hyprland.lua — вложенная сессия для отладки:
-- системные демоны уже работают снаружи
local nested = os.getenv("DEMONSHOT_NESTED") ~= nil
-- какой шелл живой (demonshot, glyph…), решает rice: `rice switch <имя>` или приложение Rice.
-- Путь полный: ~/.local/bin в PATH у hypr нет
local rice   = home .. "/.config/quickshell/rice/rice"

return {
    ------------------
    ---- HYPRLAND ----
    ------------------

    nested                     = nested,

    -- Shell
    rice                       = rice,
    lockCmd                    = rice .. " lock", -- лок текущего шелла; второй не запускает

    -- Apps
    terminal                   = "ghostty",
    browser                    = "zen-browser",
    fileExplorer               = "nautilus",
    audioSettings              = "pavucontrol",
    -- программы спец-воркспейсов (запускаются, если там пусто) и редактор. Бинды читают их при нажатии,
    -- так что свои — в user.lua: require("variables").apps.editor = "codium". Не установлено — откроется пустой
    -- воркспейс. telegram и spotify ставит install.sh --with
    apps                       = {
        sysmon        = "ghostty --class=btop -e btop",
        music         = "spicetify watch -s",
        communication = "Telegram",
        todo          = "flatpak run io.github.alainm23.planify",
        editor        = "codium",
    },

    -- Touchpad
    touchpadDisableTyping      = false,
    touchpadScrollFactor       = 0.3,
    gestureFingers             = 4,
    workspaceSwipeFingers      = 3,
    gestureFingersMore         = 5,

    -- Blur (reduced for iGPU performance)
    blurEnabled                = true,
    blurSpecialWs              = false,
    blurPopups                 = true,
    blurInputMethods           = true,
    blurSize                   = 4,
    blurPasses                 = 1,
    blurXray                   = false,

    -- Shadow (reduced for iGPU performance)
    -- лёгкое красное свечение у фокуса
    shadowEnabled              = true,
    shadowRange                = 6,
    shadowRenderPower          = 2,
    shadowColour               = "rgba(" .. scheme.crimson .. "15)",

    -- Gaps
    workspaceGaps              = 15,
    windowGapsIn               = 6,
    windowGapsOut              = 14,

    -- Window styling
    windowOpacity              = 1,
    windowRounding             = 0,
    windowBorderSize           = 2,
    activeWindowBorderColour   = {
        colors = { "rgb(" .. scheme.crimson .. ")", "rgb(" .. scheme.rose .. ")", "rgb(" .. scheme.crimson .. ")" },
        angle = 135,
    },
    inactiveWindowBorderColour = "rgb(" .. scheme.wine .. ")",

    -- Misc
    volumeStep                 = 5,
    volumeMax                  = 100,
    cursorTheme                = "Bibata-Modern-Classic",
    cursorSize                 = 23,
    sleepGestureCmd            = "systemctl suspend-then-hibernate || systemctl suspend", -- нет гибернации — обычный сон

    ------------------
    ---- KEYBINDS ----
    ------------------

    -- Workspaces
    kbMoveWinToWs              = "SUPER + ALT",
    kbMoveWinToWsGroup         = "CTRL + SUPER + ALT",
    kbGoToWs                   = "SUPER",
    kbGoToWsGroup              = "CTRL + SUPER",
    kbNextWs                   = "CTRL + SUPER + Right",
    kbPrevWs                   = "CTRL + SUPER + Left",

    -- Window Group
    kbWindowGroupCycleNext     = "ALT + TAB",
    kbWindowGroupCyclePrev     = "SHIFT + ALT + TAB",
    kbUngroup                  = "SUPER + U",
    kbToggleGroup              = "SUPER + Comma",

    -- Window Action
    kbMoveWindow               = "SUPER + Z",
    kbResizeWindow             = "SUPER + X",
    kbWindowPip                = "SUPER + ALT + backslash",
    kbPinWindow                = "SUPER + SHIFT + P", -- Super+P — vpn-договор
    kbWindowFullscreen         = "SUPER + F",
    kbWindowBorderedFullscreen = "SUPER + ALT + F",
    kbToggleWindowFloating     = "SUPER + ALT + space",
    kbCloseWindow              = "SUPER + C",

    -- Special workspaces toggles
    kbSpecialWs                = "SUPER + S",
    kbSystemMonitorWs          = "CTRL + SHIFT + Escape",
    kbMusicWs                  = "CTRL + SUPER + M",
    kbCommunicationWs          = "SUPER + D",
    kbTodoWs                   = "CTRL + SUPER + R",

    -- Apps
    kbTerminal                 = "SUPER + Q",
    kbBrowser                  = "SUPER + W",
    kbEditor                   = "SUPER + SHIFT + K",
    kbFileExplorer             = "SUPER + E",

    -- Misc
    kbSession                  = "CTRL + ALT + Delete",
    kbPower                    = "SUPER + Escape",
    kbAltar                    = "SUPER + Space",
    kbLock                     = "SUPER + L",
    kbRestoreLock              = "SUPER + ALT + L",
}
