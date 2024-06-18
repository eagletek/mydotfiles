function ColorMyPencils(color)
  color = color or "srcery"
  vim.cmd.colorscheme(color)

  -- Keep transparent background
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- ...but not floating windows
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  'tpope/vim-fugitive', -- git
  'tpope/vim-sleuth', -- detect tabstop and shiftwidth automatically
  'tpope/vim-commentary', -- commenting
  'tpope/vim-surround', -- surround things
  'tpope/vim-obsession', -- session saving
  'tpope/vim-unimpaired', -- surround things
  'tpope/vim-repeat', -- expanded repeat (`.`)

  -- srcery colors
  { 'srcery-colors/srcery-vim',
    config = function ()
      ColorMyPencils()
    end
  },

  -- nvim-tree
  { "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
      }
    end,
  },

  -- Quick file jumping
  {'theprimeagen/harpoon',
    config = function ()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-;>", function() ui.nav_file(4) end)
    end
  },

  -- undo tree
  { 'mbbill/undotree',
    config = function ()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  -- indentline
  { 'lukas-reineke/indent-blankline.nvim',
    config = function ()
      require("ibl").setup {
        -- space_char_blankline = " ",
        -- show_current_context = true,
        -- show_current_context_start = true,
      }
    end,
  },

  -- statusline
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('lualine').setup({
        options = {
          theme = 'gruvbox'
        }
      })
    end,
  },

  -- rainbow parens
  { 'HiPhish/rainbow-delimiters.nvim' },

  -- colorizer
  { 'norcalli/nvim-colorizer.lua',
    config = function() 
      vim.opt.termguicolors = true
      require('colorizer').setup()
    end
  }

}
