-- Syntax-check every Lua file in the config without executing it.
-- Usage: nvim -l tests/check_syntax.lua <config-root>
local root = assert(arg[1], "usage: nvim -l tests/check_syntax.lua <config-root>")

local function find_lua(dir)
  return vim.fs.find(function(name)
    return name:sub(-4) == ".lua"
  end, { path = dir, type = "file", limit = math.huge })
end

local files = { root .. "/init.lua" }
vim.list_extend(files, find_lua(root .. "/lua"))
vim.list_extend(files, find_lua(root .. "/after"))
vim.list_extend(files, find_lua(root .. "/tests"))

local failed = 0
for _, file in ipairs(files) do
  local chunk, err = loadfile(file)
  if not chunk then
    io.stderr:write("FAIL " .. err .. "\n")
    failed = failed + 1
  end
end

print(("syntax: %d files checked, %d failed"):format(#files, failed))
if failed > 0 then
  os.exit(1)
end
