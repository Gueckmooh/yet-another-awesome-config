--[[

    Awesome WM configuration
    Module config
    vars.lua

--]]

local vars          = {}


vars.terminal       = "kitty"
vars.editor         = os.getenv ("EDITOR") or "emacsclient -t"
vars.editor_cmd     = vars.terminal .. " -e " .. vars.editor
vars.checkupdate    = "apt list --upgradable 2> /dev/null | awk -v FS=/ 'NR>1 {print $1}'"
vars.browser        = "firefox"
vars.cores          = 4
vars.battery        = "BAT0"
vars.user           = os.getenv ("USER")

return vars
