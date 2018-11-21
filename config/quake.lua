--[[

    Awesome WM configuration
    Module config
    quake.lua

--]]

local quake = {}

local lain      = require ("lain")
local vars      = require ("config.vars")

quake.quake = lain.util.quake({ app = vars.terminal })

return quake
