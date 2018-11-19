local socket = require ("socket")
local awful  = require ("awful")

local util = {}

util.simple_exec = function (cmd)
    local pfile = io.popen (cmd)
    local line = pfile:read "*l"
    pfile:close ()
    return line
end

function util.run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        local findme = cmd
        local firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

util.scandir = function (directory)
    local t, popen = {}, io.popen
    local pfile = popen ("ls '" .. directory .. "'")
    for filename in pfile:lines ()
    do
        t[#t + 1] = filename
    end
    pfile:close ()
    return t
end

util.get_wall = function (directory)
    local walls = util.scandir (directory)
    math.randomseed (os.time ())
    local chosen = math.random (1, #walls)
    return directory .. "/" .. walls[chosen]
end

util.get_lines = function (file)
    local lines = {}
    while true
    do
        local line = file:read "*l"
        if line == nil or line == "" then break end
        lines[#lines+1] = line
    end
    return lines
end

util.sleep = function (sec)
    socket.select(nil, nil, sec)
end

function util.group_by (tab, entry)
    local group = {}
    if tab == nil then return nil end
    if #tab == 0 then return nil end
    for _, t in pairs (tab)
    do
        if t[entry] ~= nil
        then
            if group[t[entry]] == nil then group[t[entry]] = {} end
            local g = group[t[entry]]
            g[#g + 1] = t
        end
    end
    return group
end

return util
