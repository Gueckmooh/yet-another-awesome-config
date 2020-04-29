--[[

    Awesome WM configuration
    Module config
    vars.lua

--]]

local vars          = {}


vars.terminal       = "termite"
vars.editor         = os.getenv ("EDITOR") or "emacsclient -t"
vars.editor_cmd     = vars.terminal .. " -e " .. vars.editor
-- vars.checkupdate    = "apt list --upgradable 2> /dev/null | awk -v FS=/ 'NR>1 {print $1}'"
vars.checkupdate    = "pacman -Qu 2> /dev/null | awk -v FS=/ 'NR>1 {print $1}'"
vars.checkupdate_f  = "pacman -Qu 2> /dev/null | awk -v FS=/ 'NR>1 {print}'"
vars.browser        = "firefox"
vars.cores          = 4
vars.battery        = "BAT0"
vars.user           = os.getenv ("USER")
vars.rofi           = "bash -c \"rofi -terminal " .. vars.terminal .. " -show "

vars.unclutter_command = "unclutter -root"
vars.network_command   = "nm-applet"
vars.pulse_command     = "pulseaudio --start"
-- vars.compton_command   = "compton --backend glx --paint-on-overlay"..
--     " --glx-no-stencil --vsync opengl-swc --unredir-if-possible &"
vars.compton_command   = "compton &"
-- vars.autolock_command  = "xautolock -time 10 -locker 'i3lock-fancy -f Courier"..
--     " -p -t Locked'"
-- vars.lock_command      = "i3lock-fancy -f Courier -p -t Locked"
vars.lock_command      = "/home/brignone/bin/awlock"
vars.autolock_command  = "goautolock --time 250 --locker '".. vars.lock_command .. "'"
vars.redshift_command  = "redshift"

vars.music_dir         = os.getenv ("HOME") .. "/Musique"

vars.conky             = os.getenv ("HOME") .. '/.config/conky/conky.sh'

return vars
