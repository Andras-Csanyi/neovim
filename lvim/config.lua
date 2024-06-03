-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.cmdheight = 2;
vim.opt.relativenumber = true;
vim.opt.tabstop = 4;
vim.opt.shiftwidth = 4;
vim.opt.expandtab = true;

----------------
--- Settings ---
----------------

-- Core plugin settings --

lvim.builtin.nvimtree.setup.view.width = 50;

---------------
--- Plugins ---
---------------

lvim.plugins = {
  {
    "nvimtools/none-ls.nvim",
    config = function ()
      require("null-ls").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}

---------------
--- Linting ---
---------------

local null_ls = require("null-ls");
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.checkstyle.with({
      extra_args = { "-c", "google_checks.xml" },
      filetypes = { "java" },
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      command = "checkstyle"
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "json", "yaml", "grapql", "graphqls" },
      method = null_ls.methods.FORMATTING,
      command = "prettier"
    })
  }
})

