local socket = require ("socket")

local util = {}

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

return util
