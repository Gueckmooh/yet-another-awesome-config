local awful = require ("awful")
local wibox = require ("wibox")
local gears = require ("gears")
local naughty = require ("naughty")
local layout = require ("config.layout")
local menu  = require ("config.menu")
local util = require ("config.util")
local xresources      = require("beautiful.xresources")
local dpi             = xresources.apply_dpi
local lain            = require ("lain")
local markup          = lain.util.markup
local separators      = lain.util.separators
local arrow           = separators.arrow_left
local client          = client
local vars            = require ("config.vars")

local theme = {}


-- Default variables
theme.name = "powerarrow"
theme.dir = os.getenv ("HOME") .. "/.config/awesome/themes/" .. theme.name
-- theme.dir = "/home/brignone/git/yet-another-awesome-config/themes/" .. theme.name -- CONFIG
theme.font = "xos4 Terminus 9"
theme.wallpaper_dir = theme.dir .. "/wallpapers"
theme.wallpaper = util.get_wall(theme.dir .. "/wallpapers")

-- arcchart\
-- theme.arcchart_border_color = nil
-- theme.arcchart_color = nil
-- theme.arcchart_border_width = nil
-- theme.arcchart_paddings = nil
-- theme.arcchart_thickness = nil

-- awesome\
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"

-- bg\
theme.bg_normal   = "#222222"
theme.bg_focus    = "#1E2320"
theme.bg_urgent   = "#3F3F3F"
-- theme.bg_minimize = nil
theme.bg_systray  = "#343434"

-- fg\
theme.fg_normal   = "#FEFEFE"
theme.fg_focus    = "#32D6FF"
theme.fg_urgent   = "#C83F11"
theme.fg_minimize = "#888888"

-- border\
-- theme.border_marked = nil
theme.border_width = 1
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#6F6F6F"
theme.border_marked                             = "#CC9393"
-- theme.border_focus = nil
-- theme.border_normal = nil
-- theme.border_width = nil

-- calendar\
-- theme.calendar_style = nil
-- theme.calendar_font = nil
-- theme.calendar_spacing = nil
-- theme.calendar_week_numbers = nil
-- theme.calendar_start_sunday = nil
-- theme.calendar_long_weekdays = nil

-- checkbox\
-- theme.checkbox_border_width = nil
-- theme.checkbox_bg = nil
-- theme.checkbox_border_color = nil
-- theme.checkbox_check_border_color = nil
-- theme.checkbox_check_border_width = nil
-- theme.checkbox_check_color = nil
-- theme.checkbox_shape = nil
-- theme.checkbox_check_shape = nil
-- theme.checkbox_paddings = nil
-- theme.checkbox_color = nil

-- column\
-- theme.column_count = nil

-- cursor\
-- theme.cursor_mouse_resize = nil
-- theme.cursor_mouse_move = nil

-- enable\
-- theme.enable_spawn_cursor = nil

-- fullscreen\
-- theme.fullscreen_hide_border = nil

-- gap\
-- theme.gap_single_client = nil

-- graph\
-- theme.graph_bg = nil
-- theme.graph_fg = nil
-- theme.graph_border_color = nil

-- hotkeys\
-- theme.hotkeys_bg = nil
-- theme.hotkeys_fg = nil
-- theme.hotkeys_border_width = nil
-- theme.hotkeys_border_color = nil
-- theme.hotkeys_shape = nil
-- theme.hotkeys_modifiers_fg = nil
-- theme.hotkeys_label_bg = nil
-- theme.hotkeys_label_fg = nil
-- theme.hotkeys_font = nil
-- theme.hotkeys_description_font = nil
-- theme.hotkeys_group_margin = nil

-- icon\
-- theme.icon_theme = nil

-- layout\
theme.layout_tile                               = theme.dir .. "/icons/layouts/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/layouts/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/layouts/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/layouts/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/layouts/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/layouts/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/layouts/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/layouts/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/layouts/floating.png"
-- theme.layout_cornernw = nil
-- theme.layout_cornerne = nil
-- theme.layout_cornersw = nil
-- theme.layout_cornerse = nil

-- master\
-- theme.master_width_factor = nil
-- theme.master_fill_policy = nil
-- theme.master_count = nil

-- maximized\
-- theme.maximized_honor_padding = nil
-- theme.maximized_hide_border = nil

-- menu\
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
-- theme.menu_font = nil
theme.menu_height                               = 16
theme.menu_width                                = 140
-- theme.menu_border_color = nil
-- theme.menu_border_width = nil
-- theme.menu_fg_focus = nil
-- theme.menu_bg_focus = nil
-- theme.menu_fg_normal = nil
-- theme.menu_bg_normal = nil
-- theme.menu_submenu = nil

-- menubar\
-- theme.menubar_fg_normal = nil
-- theme.menubar_bg_normal = nil
-- theme.menubar_border_width = nil
-- theme.menubar_border_color = nil
-- theme.menubar_fg_normal = nil
-- theme.menubar_bg_normal = nil

-- notification\
-- theme.notification_font = nil
-- theme.notification_bg = nil
-- theme.notification_fg = nil
-- theme.notification_border_width = nil
-- theme.notification_border_color = nil
-- theme.notification_shape = nil
-- theme.notification_opacity = nil
-- theme.notification_margin = nil
-- theme.notification_width = nil
-- theme.notification_height = nil
-- theme.notification_max_width = nil
-- theme.notification_max_height = nil
-- theme.notification_icon_size = nil

-- piechart\
-- theme.piechart_border_color = nil
-- theme.piechart_border_width = nil
-- theme.piechart_colors = nil

-- progressbar\
-- theme.progressbar_bg = nil
-- theme.progressbar_fg = nil
-- theme.progressbar_shape = nil
-- theme.progressbar_border_color = nil
-- theme.progressbar_border_width = nil
-- theme.progressbar_bar_shape = nil
-- theme.progressbar_bar_border_width = nil
-- theme.progressbar_bar_border_color = nil
-- theme.progressbar_margins = nil
-- theme.progressbar_paddings = nil

-- prompt\
-- theme.prompt_fg_cursor = nil
-- theme.prompt_bg_cursor = nil
-- theme.prompt_font = nil
-- theme.prompt_fg = nil
-- theme.prompt_bg = nil

-- radialprogressbar\
-- theme.radialprogressbar_border_color = nil
-- theme.radialprogressbar_color = nil
-- theme.radialprogressbar_border_width = nil
-- theme.radialprogressbar_paddings = nil

-- separator\
-- theme.separator_thickness = nil
-- theme.separator_border_color = nil
-- theme.separator_border_width = nil
-- theme.separator_span_ratio = nil
-- theme.separator_color = nil
-- theme.separator_shape = nil

-- slider\
-- theme.slider_bar_border_width = nil
-- theme.slider_bar_border_color = nil
-- theme.slider_handle_border_color = nil
-- theme.slider_handle_border_width = nil
-- theme.slider_handle_width = nil
-- theme.slider_handle_color = nil
-- theme.slider_handle_shape = nil
-- theme.slider_bar_shape = nil
-- theme.slider_bar_height = nil
-- theme.slider_bar_margins = nil
-- theme.slider_handle_margins = nil
-- theme.slider_bar_color = nil

-- snap\
-- theme.snap_bg = nil
-- theme.snap_border_width = nil
-- theme.snap_shape = nil

-- snapper\
-- theme.snapper_gap = nil

-- systray\
-- theme.systray_icon_spacing = nil

-- taglist\
theme.taglist_fg_focus    = "#00CCFF"
-- theme.taglist_bg_focus = nil

-- theme.taglist_fg_urgent   = nil
-- theme.taglist_bg_urgent = nil

-- theme.taglist_fg_occupied = nil
-- theme.taglist_bg_occupied = nil

-- theme.taglist_fg_empty    = nil
-- theme.taglist_bg_empty = nil

-- theme.taglist_fg_volatile = nil
-- theme.taglist_bg_volatile = nil

-- theme.taglist_font = nil
-- theme.taglist_spacing = nil
-- theme.taglist_disable_icon = nil

theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
-- theme.taglist_squares_sel_empty = nil
-- theme.taglist_squares_unsel_empty = nil
-- theme.taglist_squares_resize = nil

-- theme.taglist_shape = nil
-- theme.taglist_shape_border_width = nil
-- theme.taglist_shape_border_color = nil
-- theme.taglist_shape_empty = nil
-- theme.taglist_shape_border_width_empty = nil
-- theme.taglist_shape_border_color_empty = nil
-- theme.taglist_shape_focus = nil
-- theme.taglist_shape_border_width_focus = nil
-- theme.taglist_shape_border_color_focus = nil
-- theme.taglist_shape_urgent = nil
-- theme.taglist_shape_border_width_urgent = nil
-- theme.taglist_shape_border_color_urgent = nil
-- theme.taglist_shape_volatile = nil
-- theme.taglist_shape_border_width_volatile = nil
-- theme.taglist_shape_border_color_volatile = nil

-- tasklist\
-- theme.tasklist_fg_normal = nil
-- theme.tasklist_bg_normal = nil

theme.tasklist_fg_focus = "#00CCFF"
theme.tasklist_bg_focus = "#222222"

-- theme.tasklist_fg_urgent = nil
-- theme.tasklist_bg_urgent = nil

-- theme.tasklist_fg_minimize = nil
-- theme.tasklist_bg_minimize = nil

-- theme.tasklist_bg_image_normal = nil
-- theme.tasklist_bg_image_focus = nil
-- theme.tasklist_bg_image_urgent = nil
-- theme.tasklist_bg_image_minimize = nil
-- theme.tasklist_font = nil

theme.tasklist_disable_icon                     = true
-- theme.tasklist_disable_task_name = nil
theme.tasklist_plain_task_name                  = true
-- theme.tasklist_align = nil
-- theme.tasklist_font_focus = nil
-- theme.tasklist_font_minimized = nil
-- theme.tasklist_font_urgent = nil
-- theme.tasklist_spacing = nil
-- theme.tasklist_shape = nil
-- theme.tasklist_shape_border_width = nil
-- theme.tasklist_shape_border_color = nil
-- theme.tasklist_shape_focus = nil
-- theme.tasklist_shape_border_width_focus = nil
-- theme.tasklist_shape_border_color_focus = nil
-- theme.tasklist_shape_minimized = nil
-- theme.tasklist_shape_border_width_minimized = nil
-- theme.tasklist_shape_border_color_minimized = nil
-- theme.tasklist_shape_urgent = nil
-- theme.tasklist_shape_border_width_urgent = nil
-- theme.tasklist_shape_border_color_urgent = nil


--[[
    Titlebar
--]]

-- theme.titlebar_fg_normal = nil
theme.titlebar_bg_normal = "#3F3F3F"
-- theme.titlebar_bgimage_normal = nil

-- theme.titlebar_fg = nil
-- theme.titlebar_bg = nil
-- theme.titlebar_bgimage = nil

-- theme.titlebar_fg_focus = nil
theme.titlebar_bg_focus = "#3F3F3F"
-- theme.titlebar_bgimage_focus = nil

-- ???
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

-- {{ titlebar_floating_button
-- theme.titlebar_floating_button_normal                = nil
theme.titlebar_floating_button_normal_active         = theme.dir .. "/icons/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_normal_active_hover   = nil
-- theme.titlebar_floating_button_normal_active_press   = nil

theme.titlebar_floating_button_normal_inactive       = theme.dir .. "icons/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_normal_inactive_hover = nil
-- theme.titlebar_floating_button_normal_inactive_press = nil

-- theme.titlebar_floating_button_focus                 = nil
theme.titlebar_floating_button_focus_active          = theme.dir .. "/icons/titlebar/floating_focus_active.png"
-- theme.titlebar_floating_button_focus_active_hover    = nil
-- theme.titlebar_floating_button_focus_active_press    = nil

theme.titlebar_floating_button_focus_inactive        = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_focus_inactive_hover  = nil
-- theme.titlebar_floating_button_focus_inactive_press  = nil
-- }}

-- {{ titlebar_maximized_button
-- theme.titlebar_maximized_button_normal                = nil
theme.titlebar_maximized_button_normal_active         = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_normal_active_hover   = nil
-- theme.titlebar_maximized_button_normal_active_press   = nil

theme.titlebar_maximized_button_normal_inactive       = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_normal_inactive_hover = nil
-- theme.titlebar_maximized_button_normal_inactive_press = nil

-- theme.titlebar_maximized_button_focus                 = nil
theme.titlebar_maximized_button_focus_active          = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
-- theme.titlebar_maximized_button_focus_active_hover    = nil
-- theme.titlebar_maximized_button_focus_active_press    = nil

theme.titlebar_maximized_button_focus_inactive        = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive_hover  = nil
-- theme.titlebar_maximized_button_focus_inactive_press  = nil
-- }}

-- {{ titlebar_sticky_button
-- theme.titlebar_sticky_button_normal                = nil
theme.titlebar_sticky_button_normal_active         = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_normal_active_hover   = nil
-- theme.titlebar_sticky_button_normal_active_press   = nil

theme.titlebar_sticky_button_normal_inactive       = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_normal_inactive_hover = nil
-- theme.titlebar_sticky_button_normal_inactive_press = nil

-- theme.titlebar_sticky_button_focus                 = nil
theme.titlebar_sticky_button_focus_active          = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
-- theme.titlebar_sticky_button_focus_active_hover    = nil
-- theme.titlebar_sticky_button_focus_active_press    = nil

theme.titlebar_sticky_button_focus_inactive        = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive_hover  = nil
-- theme.titlebar_sticky_button_focus_inactive_press  = nil
-- }}

-- {{ titlebar_ontop_button
-- theme.titlebar_ontop_button_normal                = nil
theme.titlebar_ontop_button_normal_active         = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_normal_active_hover   = nil
-- theme.titlebar_ontop_button_normal_active_press   = nil

theme.titlebar_ontop_button_focus_active          = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
-- theme.titlebar_ontop_button_focus_active_hover    = nil
-- theme.titlebar_ontop_button_focus_active_press    = nil

-- theme.titlebar_ontop_button_focus                 = nil
theme.titlebar_ontop_button_normal_inactive       = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_normal_inactive_hover = nil
-- theme.titlebar_ontop_button_normal_inactive_press = nil

theme.titlebar_ontop_button_focus_inactive        = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive_hover  = nil
-- theme.titlebar_ontop_button_focus_inactive_press  = nil
-- }}

-- {{ titlebar_minimize_button
theme.titlebar_minimize_button_normal       = theme.dir .. "/icons/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_normal_hover = nil
-- theme.titlebar_minimize_button_normal_press = nil

theme.titlebar_minimize_button_focus        = theme.dir .. "/icons/titlebar/minimize_focus.png"
-- theme.titlebar_minimize_button_focus_hover  = nil
-- theme.titlebar_minimize_button_focus_press  = nil
-- }}

---{{ titlebar_close_button
theme.titlebar_close_button_normal          = theme.dir .. "/icons/titlebar/close_normal.png"
-- theme.titlebar_close_button_normal_hover    = nil
-- theme.titlebar_close_button_normal_press    = nil

theme.titlebar_close_button_focus           = theme.dir .. "/icons/titlebar/close_focus.png"
-- theme.titlebar_close_button_focus_hover     = nil
-- theme.titlebar_close_button_focus_press     = nil
-- }}

-- tooltip\
-- theme.tooltip_border_color = nil
-- theme.tooltip_bg = nil
-- theme.tooltip_fg = nil
-- theme.tooltip_font = nil
-- theme.tooltip_border_width = nil
-- theme.tooltip_opacity = nil
-- theme.tooltip_shape = nil
-- theme.tooltip_align = nil

-- useless\
theme.useless_gap                               = 7
theme.max_useless_gap                           = 7

-- wibar\
-- theme.wibar_stretch = nil
-- theme.wibar_border_width = nil
-- theme.wibar_border_color = nil
-- theme.wibar_ontop = nil
-- theme.wibar_cursor = nil
-- theme.wibar_opacity = nil
-- theme.wibar_type = nil
-- theme.wibar_width = nil
-- theme.wibar_height = nil
-- theme.wibar_bg = nil
-- theme.wibar_bgimage = nil
-- theme.wibar_fg = nil
-- theme.wibar_shape = nil

-- widget\
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_music_default_art                  = theme.dir .. "/icons/no_cover.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
theme.widget_pacman                             = theme.dir .. "/icons/pacman.png"

-- arrows colors\
theme.arrows = {}
theme.arrows.color = {}
theme.arrows.color[1] = "#777E76"
theme.arrows.color[2] = "#8DAA9A"
theme.arrows.color[3] = "#b23998"
theme.arrows.color[4] = "#CB755B"
theme.arrows.color[5] = "#4B3B51"
theme.arrows.color[6] = "#4B696D"
theme.arrows.color[7] = "#777E76"
theme.arrows.color[8] = "#343434"
theme.arrows.color[9] = "alpha"
theme.arrows.color[#theme.arrows.color + 1] =  "#343434"

--[[
__        ___ _
\ \      / (_) |__   __ _ _ __
 \ \ /\ / /| | '_ \ / _` | '__|
  \ V  V / | | |_) | (_| | |
   \_/\_/  |_|_.__/ \__,_|_|

--]]

theme.launcher =
    awful.widget.launcher({
            image = theme.awesome_icon,
            menu = menu.mainmenu
    })

--[[
__        ___     _            _
\ \      / (_) __| | __ _  ___| |_ ___
 \ \ /\ / /| |/ _` |/ _` |/ _ \ __/ __|
  \ V  V / | | (_| | (_| |  __/ |_\__ \
   \_/\_/  |_|\__,_|\__, |\___|\__|___/
                    |___/
--]]
theme.widgets = {}

-------------------- {{{ Clock }}} ---------------------------------------------

local clock = require ("cuddly-succotash.widgets.wibox.clock")
theme.widgets.clock_widget = clock.factory ({}, theme).widget

-------------------- {{{ End Clock }}} -----------------------------------------

-------------------- {{{ Battery }}} -------------------------------------------

local battery = require ("cuddly-succotash.widgets.wibox.battery")
theme.widgets.battery_widget = battery.factory ({}, theme).widget

-------------------- {{{ End Battery }}} ---------------------------------------

-------------------- {{{ Pulse Audio }}} ---------------------------------------

local pulse = require ("widget.pulseaudio")
theme.widgets.pulse_widget = pulse.get_widget (theme)

-------------------- {{{ End Pulse Audio }}} -----------------------------------


-------------------- {{{ Heat }}} ----------------------------------------------

local temp = require ("widget.temperature")
theme.widgets.temp_widget = temp.get_widget (theme)

-------------------- {{{ End Heat }}} ------------------------------------------

-------------------- {{{ CPU }}} -----------------------------------------------

local cpu = require ("widget.cpu")
theme.widgets.cpu_widget = cpu.get_widget (theme)

-------------------- {{{ End CPU }}} -------------------------------------------

-------------------- {{{ MEM }}} -----------------------------------------------

local mem = require ("widget.mem")
theme.widgets.mem_widget = mem.get_widget (theme)

-------------------- {{{ End MEM }}} -------------------------------------------

-------------------- {{{ FS }}} ------------------------------------------------

local fs = require ("widget.fs")
theme.widgets.fs_widget = fs.get_widget (theme)

-------------------- {{{ End FS }}} --------------------------------------------

-------------------- {{{ PACK }}} ----------------------------------------------

local pack = require ("widget.pack")
theme.widgets.pack_widget = pack.get_widget (theme)

-------------------- {{{ End PACK }}} ------------------------------------------

-------------------- {{{ MPD }}} ----------------------------------------------

local mpd = require ("cuddly-succotash.widgets.wibox.mpd")
theme.widgets.mpd_widget = mpd.factory (
  {
    music_dir = os.getenv("HOME") .. "/Musique",
    port = "6601"
  }, theme).widget

-------------------- {{{ End MPD }}} ------------------------------------------

-------------------- {{{ SCREENSHOT }}} ----------------------------------------

local screenshot = require ("widget.screenshot")
theme.widgets.screenshot_widget = screenshot.get_widget (theme)

-------------------- {{{ End SCREENSHOT }}} ------------------------------------

-------------------- {{{ TRANSLATE }}} -----------------------------------------

local translate = require ("widget.translate")
translate.create_widget (theme)

-------------------- {{{ End TRANSLATE }}} -------------------------------------

function theme.set_wallpaper(s)
    -- Wallpaper
    if theme.wallpaper then
        local wallpaper = theme.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

theme.at_screen_connect = function (s)
    -- Wallpaper
    theme.set_wallpaper(s)
    s.quake = lain.util.quake({ app = vars.terminal, screen = s })

    -- Each screen has its own tag table.
    awful.tag(layout.tags, s, layout.default_layout)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist (
        s,
        -- awful.widget.taglist.filter.all,
        function (t)
            return #t:clients() > 0 or t.selected or t.index < 6
        end,
        menu.taglist_buttons
    )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, menu.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            theme.launcher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            --------------------------------------------------------------------
            arrow("alpha", theme.arrows.color[#theme.arrows.color]),
            wibox.container.background(
                wibox.container.margin (wibox.widget.systray (), 3, 3),
                theme.arrows.color[#theme.arrows.color]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[10], theme.arrows.color[9]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.mpd_widget, 8, 3),
                theme.arrows.color[9]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[9], theme.arrows.color[8]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.pack_widget, 8, 3),
                theme.arrows.color[8]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[8], theme.arrows.color[7]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.fs_widget, 3, 3),
                theme.arrows.color[7]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[7], theme.arrows.color[6]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.mem_widget, 3, 3),
                theme.arrows.color[6]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[6], theme.arrows.color[5]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.cpu_widget, 3, 3),
                theme.arrows.color[5]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[5], theme.arrows.color[4]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.temp_widget, 3, 3),
                theme.arrows.color[4]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[4], theme.arrows.color[3]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.pulse_widget, 3, 3),
                theme.arrows.color[3]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[3], theme.arrows.color[2]),
            wibox.container.background(
                wibox.container.margin (theme.widgets.battery_widget, 3, 3),
                theme.arrows.color[2]),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            arrow(theme.arrows.color[2], theme.arrows.color[1]),
            wibox.container.background(theme.widgets.clock_widget, theme.arrows.color[1]),
            arrow(theme.arrows.color[1], "alpha"),
            --------------------------------------------------------------------

            --------------------------------------------------------------------
            s.mylayoutbox,
        },
    }
end

return theme
