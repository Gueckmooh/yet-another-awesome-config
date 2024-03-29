--[[

    Awesome WM configuration
    Module config
    init.lua

--]]

local awful           = require ("awful")
local hotkeys_popup   = require ("awful.hotkeys_popup").widget
local menu            = require ("config.menu")
local layout          = require ("config.layout")
local vars            = require ("config.vars")
local APW             = require ("apw/widget")
local mpd             = require ("cuddly.widgets.wibox.mpd")
local menubar         = require ("menubar")
-- local pulseaudio      = require ("widget.pulseaudio")
local pulseaudio      = require ("cuddly.widgets.wibox.pulseaudio")
local util            = require ("config.util")
-- local screenshot      = require ("widget.screenshot")
local screenshot     = require ("cuddly.widgets.wibox.screenshot")
local translate       = require ("widget.translate")
local naughty = require "naughty"

local client          = client
local root            = root
local quake = require "cuddly.util.quake"

local screenlayout_cmd = debug.getinfo(1, 'S').source:match[[^@(.*/).*$]] .. "scripts/screenlayout.sh"

local keys = {}

function spawn_async (cmd)
  awful.spawn.easy_async_with_shell (cmd, function (_, _, _, _) end)
end

keys.modkey         = "Mod4"
keys.metakey        = "Mod1"
keys.ctrlkey        = "Control"
keys.shiftkey       = "Shift"
keys.leftkey        = "h"
keys.rightkey       = "l"
keys.upkey          = "k"
keys.downkey        = "j"

local modkey        = keys.modkey
local metakey       = keys.metakey
local ctrlkey       = keys.ctrlkey
local shiftkey      = keys.shiftkey
local leftkey       = keys.leftkey
local rightkey      = keys.rightkey
local upkey         = keys.upkey
local downkey       = keys.downkey

keys.launcher_mode = {}

--   ____ _       _           _   _
--  / ___| | ___ | |__   __ _| | | | _____ _   _ ___
-- | |  _| |/ _ \| '_ \ / _` | | | |/ / _ \ | | / __|
-- | |_| | | (_) | |_) | (_| | | |   <  __/ |_| \__ \
--  \____|_|\___/|_.__/ \__,_|_| |_|\_\___|\__, |___/
--                                         |___/

keys.globalkeys = awful.util.table.join(
  ----------------------------------------------------------------------------
  -- Super + s    -> show help
  awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + Left   -> Previous tag
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
    {description = "view previous", group = "tag"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + Right  -> Next tag
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
    {description = "view next", group = "tag"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + Escape -> Previous tag in history - Modified -> Super + Ctrl + Escape
  awful.key({ modkey, ctrlkey     }, "Escape", awful.tag.history.restore,
    {description = "go back", group = "tag"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + j      -> Focus next client - Modified : Super + !
  awful.key({ modkey,           }, "!",
    function ()
      awful.client.focus.byidx( 1)
    end,
    {description = "focus next by index", group = "client"}
  ),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + k      -> Focus previous client - Mofified : Super + :
  awful.key({ modkey,           }, ":",
    function ()
      awful.client.focus.byidx(-1)
    end,
    {description = "focus previous by index", group = "client"}
  ),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + w      -> Show main menu
  awful.key({ modkey,           }, "w", function () menu.mainmenu:show() end,
    {description = "show main menu", group = "awesome"}),
  ----------------------------------------------------------------------------

  --{{{ Layout manipulation
  ----------------------------------------------------------------------------
  -- Super + Shift + j -> Swap client to the left - Modifed : Super + Shift + !
  awful.key({ modkey, shiftkey   }, "!", function () awful.client.swap.byidx(  1)    end,
    {description = "swap with next client by index", group = "client"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + Shift + k -> Swap client to the left - Modifed : Super + Shift + :
  awful.key({ modkey, shiftkey   }, ":", function () awful.client.swap.byidx( -1)    end,
    {description = "swap with previous client by index", group = "client"}),
  ----------------------------------------------------------------------------
  -- }}}

  -- {{{ Screen manipulation
  ----------------------------------------------------------------------------
  -- Super + Control + j -> Go to next screen - Modified Super + Control + !
  awful.key({ modkey, "Control" }, "!", function () awful.screen.focus_relative(-1) end,
    {description = "focus the next screen", group = "screen"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + Control + k -> Go to previous screen - Modified Super + Control + :
  awful.key({ modkey, "Control" }, ":", function () awful.screen.focus_relative( 1) end,
    {description = "focus the previous screen", group = "screen"}),
  ----------------------------------------------------------------------------
  -- }}}

  ----------------------------------------------------------------------------
  -- Super + u -> Jump to urgent client
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + Tab -> Go back to previous client
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}),
  ----------------------------------------------------------------------------

  -- {{{ Standard program
  ----------------------------------------------------------------------------
  -- Super + Enter -> Open terminal
  awful.key({ modkey,           }, "Return", function () awful.spawn(vars.terminal) end,
    {description = "open a terminal", group = "launcher"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Super + b -> Open ranger
  awful.key({ modkey,           }, "b", function ()
      awful.spawn.with_shell(vars.terminal .. " -e 'ranger'") end,
    {description = "open ranger", group = "launcher"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),
  ----------------------------------------------------------------------------
  -- }}}

  ----------------------------------------------------------------------------
  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    {description = "increase the number of columns", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    {description = "decrease the number of columns", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
    {description = "select next", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    {description = "select previous", group = "layout"}),
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  awful.key({ modkey, "Control" }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    {description = "restore minimized", group = "client"}),
  ----------------------------------------------------------------------------

  -- {{{ Prompt
  ----------------------------------------------------------------------------
  awful.key({ modkey, shiftkey },  "r",     function () awful.screen.focused().mypromptbox:run() end,
    {description = "run prompt", group = "launcher"}),
  ----------------------------------------------------------------------------
  -- }}}

  ----------------------------------------------------------------------------
  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}),
  ----------------------------------------------------------------------------

  -- {{{ Menubar
  ----------------------------------------------------------------------------
  awful.key({ modkey }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "launcher"}),
  ----------------------------------------------------------------------------
  -- }}}

  -- {{{ PulseAudio
  ----------------------------------------------------------------------------
  awful.key({ }, "XF86AudioRaiseVolume",  function ()
      local pulse = pulseaudio.instance ()
      if pulse then pulse.increase (5) end
      -- APW.Up ()
      -- if pulseaudio.update then pulseaudio.update () end
                                          end,
    {description = "Increase volume", group = "peripherals"}),   -- Volume UP
  awful.key({ }, "XF86AudioLowerVolume",  function ()
      local pulse = pulseaudio.instance ()
      if pulse then pulse.decrease (5) end
                                          end,
    {description = "Decrease volume", group = "peripherals"}), -- Volume DOWN
  awful.key({ }, "XF86AudioMute",         function ()
      local pulse = pulseaudio.instance ()
      if pulse then pulse.toggle_mute () end
                                          end,
    {description = "Mute", group = "peripherals"}), -- Mute
  ----------------------------------------------------------------------------
  -- }}}

  -- {{{ TouchPad
  ----------------------------------------------------------------------------
  -- Does not work ? Touchpad is broken
  awful.key({ }, "XF86TouchpadToggle",    function () os.execute ('touchpad') end,
    {description = "Toggle touchpad", group = "peripherals"}),
  ----------------------------------------------------------------------------
    -- }}}

    -- {{{ Control the backlight
    ----------------------------------------------------------------------------
    -- Decrease backlight
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.spawn.with_shell (vars.deincrease_backlight_cmd)
                                            end,
      {description = "Decrease the screen backlight", group = "peripherals"}),
    --Increase backlight
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.spawn.with_shell (vars.increase_backlight_cmd)
                                          end,
      {description = "Increase the screen backlight", group = "peripherals"}),
    ----------------------------------------------------------------------------
    -- }}}

    -- {{{ MPD keys
    ----------------------------------------------------------------------------
    awful.key({ }, "XF86AudioPlay",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:toggle()
        end
      end,
      {description = "Play/Pause music", group = "Music"}),
    awful.key({ modkey }, "Down",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:toggle()
        end
      end,
      {description = "Play/Pause music", group = "Music"}),
    awful.key({ modkey }, "XF86AudioPlay",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:stop()
        end
      end,
      {description = "Stop Music", group = "Music"}),
    awful.key({ }, "XF86AudioPause",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:pause()
        end
      end,
      {description = "Stop Music", group = "Music"}),
    awful.key({ modkey }, "Up",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:stop()
        end
      end,
      {description = "Stop Music", group = "Music"}),
    awful.key({ }, "XF86AudioPrev",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:prev()
        end
      end, {description = "Play previous music", group = "Music"}),
    awful.key({ modkey }, "Prior",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:prev()
        end
        if mpd.update then mpd.update () end
      end, {description = "Play previous music", group = "Music"}),
    awful.key({ }, "XF86AudioNext",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:next()
        end
        if mpd.update then mpd.update () end
      end, {description = "Play next music", group = "Music"}),
    awful.key({ modkey }, "Next",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:next()
        end
        if mpd.update then mpd.update () end
      end, {description = "Play next music", group = "Music"}),
    awful.key({ }, "XF86AudioStop",
      function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:stop()
        end
        if mpd.update then mpd.update () end
      end, {description = "Stop Music", group = "Music"}),
    awful.key({ modkey, shiftkey }, "m",
      function ()
        local mpd = mpd.get_instance ()
        awful.spawn.with_shell(vars.terminal .. " -e ncmpcpp")
      end, {description = "Open ncmpcpp", group = "Music"}),
    ----------------------------------------------------------------------------
    -- }}}

    -- {{{ Browser
    ----------------------------------------------------------------------------
    -- Super + Control + f -> launch browser
    awful.key({ modkey, ctrlkey }, "f", function ()
        awful.spawn.with_shell(vars.browser)
                                        end, {description = "Open browser", group = "launcher"}),
    ----------------------------------------------------------------------------
    -- }}}

    -- {{{ Rofi
    ----------------------------------------------------------------------------
    -- Super + r -> launch browser
    awful.key({ modkey }, "r", function ()
        awful.spawn.with_shell(vars.rofi .. "run\"")
    end),
    ----------------------------------------------------------------------------
    -- }}}

    -- {{{ Lock
    ----------------------------------------------------------------------------
    -- Super + Escape -> Lock
    awful.key({ modkey }, "Escape", function ()
        local mpd = mpd.get_instance ()
        if mpd then
          mpd:pause()
        end
        spawn_async(vars.lock_command)
    end),
    -- Super + Shift + Escape -> Lock + suspend
    awful.key({ modkey, shiftkey }, "Escape", function ()
        spawn_async(vars.lock_command .. " -s")
    end),
    ----------------------------------------------------------------------------
    -- }}}

    -- {{{ Screenshot
    ----------------------------------------------------------------------------
    -- imprime écran -> Screenshot
    awful.key({ }, "#107", function ()
        -- local filename = util.simple_exec ("/home/brignone/bin/screenshot")
        -- if screenshot.show_warning then screenshot.show_warning (filename) end
        local scr = screenshot.instance ()
        if scr then scr.shot () end
                           end,
      {description = "Take screenshot", group = "util"}),
    -- Super + imprime écran -> Screenshot sur selection/client
    awful.key({ modkey }, "#107", function ()
        -- awful.util.spawn_with_shell("sleep 0.1 && screenshot -s")
        -- local filename = util.simple_exec ("sleep 0.1 && /home/brignone/bin/screenshot -s")
        -- if screenshot.show_warning then screenshot.show_warning (filename) end
        local scr = screenshot.instance ()
        if scr then scr.shot_s () end
                                  end,
      {description = "Take screenshot by selecting region/client", group = "util"}),
        ----------------------------------------------------------------------------
        -- }}}

        ----------------------------------------------------------------------------
        -- Super + e -> Open emacs client
        awful.key ({modkey}, "e",
          function ()
            awful.spawn.with_shell ("emacsclient -c -e '(create-scratch-buffer)' &")
          end,
          {description = "Launch emacs client", group = "launcher"}),
        ----------------------------------------------------------------------------

        ----------------------------------------------------------------------------
        -- Super + c -> Open caja
        awful.key ({modkey}, "c",
          function ()
            awful.spawn.with_shell ("caja &")
          end,
          {description = "Launch caja", group = "launcher"}),
        ----------------------------------------------------------------------------

        ----------------------------------------------------------------------------
        -- Super + Ctrl + o -> Open org dir
        awful.key ({modkey, ctrlkey}, "o",
          function ()
            awful.spawn.with_shell ("emacsclient -c " .. os.getenv ("HOME") ..
                                      "/org &")
          end,
          {description = "Open org directory with emacs", group = "launcher"}),
        ----------------------------------------------------------------------------

        ----------------------------------------------------------------------------
        -- Super + Shift + t -> translate
        awful.key({ modkey, ctrlkey }, "t",
          function ()
            awful.prompt.run {
              prompt       = "Translate: ",
              textbox      = awful.screen.focused().mypromptbox.widget,
              exe_callback = translate.notify,
              history_path = awful.util.get_cache_dir() .. "/history_translate"
            }
          end,
          {description = "Translate query", group = "util"}),
        ----------------------------------------------------------------------------

        ----------------------------------------------------------------------------
        -- Super + f8 -> screenlayout
        awful.key({ modkey,  }, "F8",
          function ()
            awful.spawn.with_shell (screenlayout_cmd)
          end,
          {description = "Translate query", group = "util"}),
        ----------------------------------------------------------------------------

        ----------------------------------------------------------------------------
        -- Super + z -> Show dropdown terminak
        awful.key({ modkey, }, "z", function ()
            -- if awful.screen.focused ().quake ~= nil then
            --   awful.screen.focused ().quake:toggle() end
            if quake.instance () then
              quake.instance():toggle()
            end
                                    end,
          {description = "show dropdown terminal", group = "util"}),
        ----------------------------------------------------------------------------

        ----------------------------------------------------------------------------
        awful.key({ modkey,           }, "a", function () util.add_tag ()
            util.rename_tags () end,
          {description = "add a tag", group = "tag"}),
        ----------------------------------------------------------------------------
        awful.key({ modkey, shiftkey  }, "a", function () util.delete_tag ()
            util.rename_tags () end,
          {description = "delete the current tag", group = "tag"}),
        ----------------------------------------------------------------------------
        awful.key({ modkey, ctrlkey  }, "a", util.rename_tag,
          {description = "rename the current tag", group = "tag"}),
        ----------------------------------------------------------------------------
        -- awful.key({ modkey, shiftkey  }, "o", function () root.keys (keys.launcher_mode) end,
        --     {description = "rename the current tag", group = "tag"})
        ----------------------------------------------------------------------------
        -- Super + Ctrl + m -> mutt
        awful.key({ modkey, ctrlkey }, "m",
          function ()
            awful.spawn.with_shell(vars.terminal .. " -t Mailer -e neomutt")
          end, {description = "Open neomutt", group = "launcher"}),
        ----------------------------------------------------------------------------
        awful.key({ modkey, ctrlkey }, "l",
          function ()
            awful.spawn.with_shell(vars.suspend)
          end, {description = "Suspend", group = "launcher"})
        ----------------------------------------------------------------------------

)

--[[
  ____ _ _            _     _
 / ___| (_) ___ _ __ | |_  | | _____ _   _ ___
| |   | | |/ _ \ '_ \| __| | |/ / _ \ | | / __|
| |___| | |  __/ | | | |_  |   <  __/ |_| \__ \
 \____|_|_|\___|_| |_|\__| |_|\_\___|\__, |___/
                                     |___/
--]]

keys.clientkeys = awful.util.table.join(

    ----------------------------------------------------------------------------
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
        {description = "close", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
        {description = "move to screen", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
        {description = "toggle keep on top", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey,           }, "y",      function (c) c.sticky = not c.sticky            end,
        {description = "toggle sticky", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey, shiftkey  }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
          -- minimized, since minimized clients can't have the focus.
          for _, cc in ipairs (awful.screen.focused().clients) do
            if c ~= cc then cc.minimized = true end
          end
        end ,
        {description = "minimize other", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"}),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.key({ modkey, shiftkey  }, "t",
        function (c)
            awful.titlebar.toggle (c)
        end ,
        {description = "toggle titlebar", group = "client"})
    ----------------------------------------------------------------------------
)

--[[
 _____             _
|_   _|_ _  __ _  | | _____ _   _
  | |/ _` |/ _` | | |/ / _ \ | | |
  | | (_| | (_| | |   <  __/ |_| |
  |_|\__,_|\__, | |_|\_\___|\__, |
           |___/            |___/
--]]

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, #layout.tags do
    keys.globalkeys = awful.util.table.join(
        keys.globalkeys,

        ------------------------------------------------------------------------
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),
        ------------------------------------------------------------------------

        ------------------------------------------------------------------------
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),
        ------------------------------------------------------------------------

        ------------------------------------------------------------------------
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),
        ------------------------------------------------------------------------

        ------------------------------------------------------------------------
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
        ------------------------------------------------------------------------
    )
end

keys.clientbuttons = awful.util.table.join(
    ----------------------------------------------------------------------------
    awful.button({        }, 1, function (c) client.focus = c; c:raise() end),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.button({ modkey }, 1, awful.mouse.client.move),
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    awful.button({ modkey }, 3, awful.mouse.client.resize)
    ----------------------------------------------------------------------------
)

-- keys.launcher_mode = awful.util.table.join(
--     ----------------------------------------------------------------------------
--     -- Super + s    -> show help
--     awful.key({           }, "Escape",      function () root.keys(keys.globalkeys) end,
--         {description="show help", group="awesome"}),
--     awful.key({           }, "e",      function () awful.spawn.with_shell ("emacsclient -c &") end,
--         {description="show help", group="awesome"})
-- )

-- {{{ Configure the keys
root.keys(keys.globalkeys)


return keys
