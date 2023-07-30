-- ChungUtils.lua

local function getContent(path)
    local file = fs.open(path, "r")
    local content = file.readAll()
    file.close()
    return content
end


local function getLuaFiles(path)
    local files = {}

    for i, file in pairs(fs.list(path)) do
        if not fs.isDir(file)
            local name, extension = string.match(file, "(.*)%.(.*)")

            if extension == "lua" then
                table.insert(files, file)
            end
        end
    end

    return files
end


local function minify(content)
    -- FIXME: Minify
    return content
end


local content = ""

for i, path in fs.list(shell.getRunningProgram()) do
    if fs.isDir(path) then
        for i, file in pairs(getLuaFiles(path)) do
            content = content .. getContent(path .. "/" .. file) .. "\n"
        end
    end
end


packaged = fs.open("ChungUtils.lua", "w")
packaged.write(minify(content))
packaged.close()
