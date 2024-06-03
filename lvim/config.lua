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
        config = function()
            require("null-ls").setup()
        end,
        dependencies = { "nvim-lua/plenary.nvim" }
    }
}

---------------
--- Linting ---
---------------

local null_ls_status_ok, null_ls = pcall(require, "null-ls");
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting;
local diagnostics = null_ls.builtins.diagnostics;

null_ls.setup({
    sources = {

        -- java

        diagnostics.checkstyle.with({
            extra_args = { "-c", "google_checks.xml" },
            filetypes = { "java" },
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            command = "checkstyle"
        }),

        formatting.google_java_format.with({
            filetypes = { "java" },
            method = null_ls.methods.FORMATTING,
            command = "google-java-format",
            extra_args = { "--aosp" }
        }),

        -- json, yml, graphql

        formatting.prettier.with({
            filetypes = { "json", "yaml", "grapql", "graphqls" },
            method = null_ls.methods.FORMATTING,
            command = "prettier"
        })
    }
})
