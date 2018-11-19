local wibox           = require ("wibox")
local naughty         = require ("naughty")
local awful           = require ("awful")
local xresources      = require("beautiful.xresources")
local dpi             = xresources.apply_dpi
local lain            = require ("lain")
local markup          = lain.util.markup
local vars            = require ("config.vars")
local util            = require ("config.util")
local startup         = require ("config.startup")
local my_table        = awful.util.table or gears.table -- 4.{0,1} compatibility

local pack = {}

pack.get_widget = function (theme)

    pack.get_update = function ()
        local pfile = io.popen (
            vars.checkupdate
        )
        local upgradables = util.get_lines (pfile)
        pfile:close ()
        return upgradables
    end

    pack.get_update_infos = function ()
        local pfile = io.popen (
            vars.checkupdate_f
        )
        local upgradables = util.get_lines (pfile)
        pfile:close ()
        local infos = {}
        for _, line in pairs (upgradables)
        do
            infos[#infos + 1] = {}
            local i = infos[#infos]
            i.package, i.repo, i.next, i.current =
                line:match("([^\\]+)/(%a+) ([^ ]+)[^[]+%[upgradable from: ([^%]]+)%]")
        end
        return infos
    end

    local pack_notification
    function pack.show_status()
        awful.spawn.easy_async([[echo]],
            function(_, _, _, _)
                local upgradables = pack.get_update ()
                local message = #upgradables .. " package(s) to upgrade"
                for i = 1, math.min (5, #upgradables)
                do
                    message = message .. "\n"..upgradables[i]
                end
                if #upgradables > 5 then
                    message = message .. "\nAnd " .. #upgradables - 5 .. " more..."
                end
                pack_notification = naughty.notify{
                    text =  message,
                    title = "Package status",
                    timeout = 5, hover_timeout = 0.5,
                    width = 200,
                }
            end
        )
    end

    pack.nb = #(pack.get_update ())

    function pack.show_warning()
        naughty.notify{
            -- icon = HOME .. "/.config/awesome/nichosi.png",
            -- icon_size=100,
            title = "A stranger.. From the outside ! OOooo",
            text = "New packages available\n" .. pack.nb ..
                " packages upgradable.",
            timeout = 5, hover_timeout = 0.5,
            position = "top_right",
            bg = theme.bg_normal,
            fg = "#EEE9EF",
            width = 300,
        }
    end

    function pack.show_more_infos ()
        local message = ""
        local function printm (...)
            message = message .. string.format (...)
        end
        local groups = util.group_by (pack.get_update_infos (), "repo")
        if groups == nil then return end
        for repo, _pack in pairs (groups)
        do
            printm ("\n%d package(s) in %s:\n", #_pack, repo)
            for _, p in pairs (_pack)
            do
                printm ("\t%s: %s -> %s\n", p.package, p.current, p.next)
            end
        end
        naughty.notify{
            title = "List of packages to update:",
            text = message,
            timeout = 15, hover_timeout = 0.5,
            position = "top_right",
            bg = theme.bg_normal,
            fg = "#EEE9EF",
        }
    end

    startup.register (function () if pack.nb ~= 0 then pack.show_warning () end end)

    pack.text = awful.widget.watch (
        "echo",
        300,
        function (widget)
            local upgradables = pack.get_update ()
            local color = theme.fg_normal
            local message = ""
            if #upgradables ~= 0 then message = tostring(#upgradables) end
            if #upgradables ~= 0 and #upgradables ~= pack.nb then
                pack.show_warning ()
                pack.nb = #upgradables
            end
            widget:set_markup (markup.fontfg (theme.font, color,
                                              message))
        end
    )

    pack.icon = wibox.widget.imagebox (theme.widget_pacman)

    local pack_widget = wibox.widget {
        pack.icon,
        {
            pack.text,
            left = dpi(4),
            right = dpi(4),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
    }

    pack_widget:connect_signal("mouse::enter", function()
                                      pack.show_status() end)
    pack_widget:connect_signal("mouse::leave", function()
                                      naughty.destroy(pack_notification) end)

    pack_widget:buttons (
        my_table.join(
            awful.button({ }, 1, function ()
                    pack.show_more_infos ()
            end)
    ))

    return pack_widget

end

return pack
