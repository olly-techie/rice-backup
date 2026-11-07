local vars = require("variables")

hl.config({
    input = {
        kb_layout          = "es",
        kb_options         = "",
        numlock_by_default = false,
        repeat_delay       = 250,
        repeat_rate        = 35,
        focus_on_close     = 1,

        touchpad           = {
            natural_scroll       = true,
            disable_while_typing = vars.touchpadDisableTyping,
            scroll_factor        = vars.touchpadScrollFactor,
        },
    },

    binds = {
        scroll_event_delay = 0,
    },

    cursor = {
        hotspot_padding = 1,
    },
})

-- pointer speed: sensitivity -1..1, 0 = default
hl.device({
    name        = "ps/2-generic-mouse",
    sensitivity = 0.7,
})

hl.device({
    name        = "synps/2-synaptics-touchpad",
    sensitivity = 0.5,
})
