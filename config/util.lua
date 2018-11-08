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

return util
