--[[

    Awesome WM configuration
    Module config
    quake.lua

--]]

-- local quake = {}

-- local lain      = require ("lain")
-- local vars      = require ("config.vars")


-- quake.quake = lain.util.quake({ app = vars.terminal })

local quake = require "cuddly.util.quake"
local qq = quake ({sticky = true, border=0,
                   extra = "-c ".. os.getenv("HOME")
                     .."/.config/termite/config_quake"})

return qq
-- return quake
