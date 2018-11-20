local wibox           = require ("wibox")
local util            = require ("config.util")
local awful           = require ("awful")
local xresources      = require("beautiful.xresources")
local dpi             = xresources.apply_dpi
local lain            = require ("lain")
local markup          = lain.util.markup
local naughty         = require ("naughty")

local clock = {}

clock.get_widget = function (theme)

    clock.text = awful.widget.watch(
        -- "date +'%a %d %b %R'", 60,
        "date +'%R'", 5,
        function(widget, stdout)
            widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, stdout))
        end
    )

    clock.get_cal = function ()
        local ndate = util.simple_exec ("date +%d")
        local pfile = io.popen (
            [[cal | ]]..
                [[sed "s/_\\x08//g" | ]]..
                [[sed -r -e "s/(^| )(]]..
                ndate..
                [[)($| )/\1<b><span background=\"]]..
                theme.fg_normal..
                [[\" foreground=\"]]..
                theme.bg_normal..
                [[\">\2<\/span><\/b>\3/"]]..
                [[| head -$(($(cal | wc -l) -1))]]
        )
        local line = pfile:read "*a"
        pfile:close ()
        local icon = theme.dir .. "/icons/cal/white/" .. ndate .. ".png"
        return line, icon
    end

    local clock_cal
    clock.show_cal = function ()
        local message , icon = clock.get_cal ()
        clock_cal = naughty.notify {
            text = message,
            icon = icon
        }
    end

    local clock_widget = wibox.widget {
        {
            clock.text,
            left = dpi(4),
            right = dpi(4),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
    }

    clock_widget : connect_signal ("mouse::enter",
                                   function () clock.show_cal () end
                                  )

    clock_widget : connect_signal ("mouse::leave",
                                   function () naughty.destroy (clock_cal) end
                                  )

    return clock_widget

end

return clock
