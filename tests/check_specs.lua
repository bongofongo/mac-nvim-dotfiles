-- Validate that every plugin file returns a well-formed lazy.nvim spec.
-- Checks: file returns a table, plugin id is a string, keys/dependencies
-- have the right shape, and no plugin is declared twice across files.
-- Usage: nvim -l tests/check_specs.lua <config-root>
local root = assert(arg[1], "usage: nvim -l tests/check_specs.lua <config-root>")
local spec_dir = root .. "/lua/ollie/plugins"

local files = vim.fs.find(function(name)
  return name:sub(-4) == ".lua"
end, { path = spec_dir, type = "file", limit = math.huge })
table.sort(files)

local errors = {}
local seen = {} -- short plugin name -> file that declared it

local function rel(file)
  return file:sub(#root + 2)
end

local function check_one(s, file)
  local id = s[1] or s.url or s.dir
  if type(id) ~= "string" then
    table.insert(errors, rel(file) .. ": spec has no plugin id (spec[1]/url/dir)")
    return
  end

  local short = id:match("[^/]+$"):lower()
  if seen[short] then
    table.insert(errors, ("%s: plugin %q already declared in %s"):format(rel(file), short, rel(seen[short])))
  else
    seen[short] = file
  end

  if s.dependencies ~= nil and type(s.dependencies) ~= "table" and type(s.dependencies) ~= "string" then
    table.insert(errors, rel(file) .. ": " .. short .. ": dependencies must be a table or string")
  end

  if s.keys ~= nil then
    local keys = s.keys
    if type(keys) == "table" then
      for i, k in ipairs(keys) do
        if type(k) == "table" then
          if type(k[1]) ~= "string" then
            table.insert(errors, ("%s: %s: keys[%d] missing lhs string"):format(rel(file), short, i))
          end
        elseif type(k) ~= "string" then
          table.insert(errors, ("%s: %s: keys[%d] must be a string or table"):format(rel(file), short, i))
        end
      end
    elseif type(keys) ~= "function" then
      table.insert(errors, rel(file) .. ": " .. short .. ": keys must be a table or function")
    end
  end

  if s.config ~= nil and type(s.config) ~= "function" and s.config ~= true then
    table.insert(errors, rel(file) .. ": " .. short .. ": config must be a function or true")
  end

  if s.opts ~= nil and type(s.opts) ~= "table" and type(s.opts) ~= "function" then
    table.insert(errors, rel(file) .. ": " .. short .. ": opts must be a table or function")
  end
end

for _, file in ipairs(files) do
  local chunk, load_err = loadfile(file)
  if not chunk then
    table.insert(errors, "FAIL " .. load_err)
  else
    local ok, spec = pcall(chunk)
    if not ok then
      table.insert(errors, rel(file) .. ": error while loading: " .. tostring(spec))
    elseif type(spec) ~= "table" then
      table.insert(errors, rel(file) .. ": must return a table, got " .. type(spec))
    elseif type(spec[1]) == "table" then
      -- file returns a list of specs
      for _, s in ipairs(spec) do
        check_one(s, file)
      end
    else
      check_one(spec, file)
    end
  end
end

for _, e in ipairs(errors) do
  io.stderr:write("FAIL " .. e .. "\n")
end
print(("specs: %d files checked, %d errors"):format(#files, #errors))
if #errors > 0 then
  os.exit(1)
end
