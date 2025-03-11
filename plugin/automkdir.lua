local automkdirGroup = vim.api.nvim_create_augroup("automkdirGroup", { clear = true })

local function get_parent_directories(path)
  path = vim.fs.normalize(path)
  local parents = {path}
  local parent = vim.fs.dirname(path)

  while parent ~= path do
    table.insert(parents, 1, parent)
    parent, path = vim.fs.dirname(parent), parent
  end

  return parents
end

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(t)
    -- Function gets a table that contains match key, which maps to `<amatch>` (a full filepath).
    local target_dir = vim.fs.dirname(t.match)
    -- Attempt to recursively mkdir. If dir already exists, it returns nil.
    -- Use 755 permissions, which means rwxr.xr.x
    for _, dirname in pairs(get_parent_directories(target_dir)) do
      if not vim.loop.fs_stat(dirname) then
        vim.loop.fs_mkdir(dirname, tonumber("0755", 8))
      end
    end
  end,
  group = automkdirGroup
})
