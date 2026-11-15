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
