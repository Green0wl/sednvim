Edit files with `GNU sed` directly from `nvim`. Provides an intuitive user interface for applying `sed` commands to the buffer. Allows you to perform all `sed` text operations right from the editor.

### Preview:

### Features:

- [x] Integration of [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify).
- [x] TUI.
- [x] Entire buffer editing.
- [ ] Selected text editing.
- [ ] Support `GNU sed` flags.
- [ ] Convenient way to save and reuse frequently used sed commands.
- [ ] Change Preview (trim the file horizontally and vertically to fit the preview window to save performance. i.e. do not pass the whole file through sed, but only the part that will be visible in the preview window).
- [ ] `git diff` (not only line-by-line, but also character-by-character).

### Dependencies
- [`GNU sed`](https://www.gnu.org/software/sed/#download).

### Setup (here with [`lazy.nvim`](https://github.com/folke/lazy.nvim)):

```lua
return {
  dir = "~/dev/sednvim",
  config = function()
    vim.keymap.set("n", "<leader>dc", function()
      require("sednvim").sedcmd_input()
    end, {})
  end,
  dependencies = {
    { -- optional
      'rcarriga/nvim-notify',
      config = function()
        require("notify").setup({
          background_colour = "#000000",
        })
      end
    },
    { "nvim-lua/plenary.nvim" },
    { 'MunifTanjim/nui.nvim' },
  }
}
```

### Contributions:
Contributions are welcome. If you find any bugs or have ideas for new features, please open an issue.

### Licence: [GPL-3.0 license](https://www.gnu.org/licenses/gpl-3.0.html#license-text)
