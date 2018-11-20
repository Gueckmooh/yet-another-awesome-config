local wibox           = require ("wibox")
local naughty         = require ("naughty")
local awful           = require ("awful")
local xresources      = require("beautiful.xresources")
local dpi             = xresources.apply_dpi
local lain            = require ("lain")
local markup          = lain.util.markup

local translate = {}

translate.create_widget = function (theme)

    function translate.show_status(text)
        awful.spawn.easy_async([[markup-trans ]] .. text,
            function(stdout, _, _, _)
                local message = stdout
                naughty.notify{
                    text =  message,
                    title = "Translate",
                    timeout = 20,
                }
            end
        )
    end

    translate.notify = function (text)
        translate.show_status (text)
    end

end

return translate
