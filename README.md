# automkdir.nvim
Automatically creates non-existent parent directories when writing a file.

Pure lua. Single file.

## Usage
1. Edit a file.
2. Write with `:write /foo/bar/file.txt`.
3. Let's assume the `bar` directory doesn't exist.
    * Without this plugin, you'd get the "E212: Can't open file for writing: no such file or directory" error.
    * With this plugin, the `bar` directory will be silently created and the write command will succeed.

## Installation
Use your favorite package manager.

lazy.nvim
```
require("lazy").setup({
  {
    "mateuszwieloch/automkdir.nvim",
    opts = {},
  },
})
```

vim-plug
```
call plug#begin()

Plug "mateuszwieloch/automkdir.nvim"

call plug#end()

lua <<< EOF

require "automkdir".setup()

EOF
```

## Configuration

Here are the default config options for automkdir:
```lua
{
  ---@type string[] Array of regexes to try to match filepaths against.
  blacklist = { "oil:.*" },
}
```

## See also
* Since Neovim 0.9+ you can create non-existent parent directories when writing a file by adding `++p` flag to `:write`, for example `:write ++p /path/to/file.txt`. However, that's still some extra keystrokes that I prefer to avoid.
* [mkdir.nvim](https://github.com/jghauser/mkdir.nvim) accomplishes the same goal, but uses Vimscript inside of Lua code.
