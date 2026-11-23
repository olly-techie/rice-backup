-- user.lua — свои бинды и правки поверх риса (в .gitignore, обновления репо не трогают)
local vars = require("variables")
local fn   = require("hyprland.functions")

-- привычки со старого конфига
hl.bind("SUPER + R", hl.dsp.global("shell:launcher"))     -- было: wofi
hl.bind("SUPER + TAB", hl.dsp.global("shell:launcher"))   -- было: wofi drun
hl.bind("SUPER + M", hl.dsp.global("shell:power"))        -- было: exit; меню безопаснее

-- новый бинд на обои (зарегистрированный в keybinds не срабатывал физически)
hl.bind("SUPER + SHIFT + W", hl.dsp.global("shell:wall"))
hl.bind("CTRL + SUPER + W", hl.dsp.global("shell:wall")) -- запасной комбо, если Shift+W не доходит

-- остальное уже совпадает: Super Q терминал, Super E файлы, Super C закрыть окно,
-- Print / Super+Shift+S скриншот, XF86 звук и яркость, Super+1..9 воркспейсы

-- ресайз потянув за край окна (без модификаторов), зона захвата 15px
hl.config({ general = { resize_on_border = true, extend_border_grab_area = 15 } })

-- iGPU (HD 520): blur и тени вдвое дешевле, на глаз при rounding 0 почти не отличить.
-- Только size/passes/render_power — вкл/выкл ставит Theme.apply() шелла из rules.json
hl.config({ decoration = { blur = { size = 4, passes = 1 }, shadow = { render_power = 2 } } })

-- === Session tweaks (Nov 23) ===
-- Spanish layout (rice default is us,ru)
hl.config({ input = { kb_layout = "es", kb_options = "" } })

-- 3-finger workspace swipe settings (the swipe itself is the custom gesture below)
hl.config({
    gestures = {
        workspace_swipe_distance           = 100,
        workspace_swipe_cancel_ratio       = 0.15,
        workspace_swipe_min_speed_to_force = 10,
        workspace_swipe_invert             = true,
        workspace_swipe_create_new         = false,
        workspace_swipe_forever            = false,
    },
})

-- ghostty instead of kitty (not installed)
vars.terminal = "ghostty"
vars.apps.sysmon = "ghostty --class btop -T btop btop"

-- Emoji picker
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("rofimoji"), { description = "Emoji picker" })

-- Custom 3-finger vertical workspace swipe.
-- This Hyprland/libinput build only emits generic "swipe" events (horizontal/vertical
-- never match) and action="workspace" doesn't work with generic swipe, so we track
-- delta.y ourselves and dispatch one workspace step in the swiped direction on finish.
local swipe_dy = 0
hl.gesture({
    fingers = 3,
    direction = "swipe",
    action = {
        start  = function() swipe_dy = 0 end,
        update = function(e) swipe_dy = swipe_dy + (e.delta.y or 0) end,
        finish = function(e)
            if not e.cancelled and math.abs(swipe_dy) > 15 then
                -- natural scroll: swipe up = negative dy = next workspace
                hl.dispatch(hl.dsp.focus({ workspace = swipe_dy < 0 and "+1" or "-1" }))
            end
            swipe_dy = 0
        end,
    },
})
