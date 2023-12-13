local automkdirGroup = vim.api.nvim_create_augroup("automkdirGroup", { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(t)
    -- Function gets a table that contains match key, which maps to `<amatch>` (a full filepath).
    local dirname = vim.fs.dirname(t.match)
    -- Attempt to mkdir. If dir already exists, it returns nil.
    -- Use 755 permissions, which means rwxr.xr.x
    vim.loop.fs_mkdir(dirname, tonumber("0755", 8))
  end,
  group = automkdirGroup
})
