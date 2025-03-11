local automkdirGroup = vim.api.nvim_create_augroup("automkdirGroup", { clear = true })

--- Returns an array of paths to `path`'s parent directories. Starts from top-most directory (filesystem root) and continues to `path`'s parent.
---@param path string Path to a file. Doesn't have to be normalized.
---@return string[]
local function get_parent_directories(path)
  path = vim.fs.normalize(path)
  local parents = {}
  local parent = vim.fs.dirname(path)

  while parent ~= path do
    table.insert(parents, 1, parent)
    parent, path = vim.fs.dirname(parent), parent
  end

  return parents
end

vim.api.nvim_create_autocmd('BufWritePre', {
  -- Callback function gets a table that contains match key, which maps to `<amatch>` (a full filepath).
  callback = function(t)
    -- Attempt to mkdir all parent directories of filepath: from filesystem root directory all the way to filepath's parent dir.
    for _, dirname in ipairs(get_parent_directories(t.match)) do
      -- Use 755 permissions, which means rwxr.xr.x
      -- If dir already exists, fs_mkdir returns nil and does nothing.
      vim.uv.fs_mkdir(dirname, tonumber("0755", 8))
    end
  end,
  group = automkdirGroup
})
