{ pkgs, ... }:

{
  programs.neovim = {
	  enable = true;
		plugins = with pkgs.vimPlugins; [
		  catppuccin-nvim
			telescope-nvim
			nvim-treesitter
			nvim-treesitter-parsers.c
			nvim-treesitter-parsers.cpp
			nvim-treesitter-parsers.lua
			nvim-treesitter-parsers.javascript
			nvim-treesitter-parsers.typescript
			nvim-treesitter-parsers.python
			nvim-treesitter-parsers.html
			nvim-treesitter-parsers.css
			nvim-treesitter-parsers.svelte
			nvim-treesitter-parsers.rust
			nvim-treesitter-parsers.vue
			nvim-treesitter-parsers.php
			nvim-treesitter-parsers.nix
			nvim-treesitter-parsers.yaml
			nvim-treesitter-parsers.toml
			nvim-treesitter-parsers.bash
			nvim-treesitter-parsers.markdown
			nvterm
			nvim-lspconfig
			nvim-cmp
			luasnip
			cmp-nvim-lsp
		];
		extraLuaConfig = ''
		  -- Global neovim
		  vim.g.mapleader = ' '
		  vim.g.maplocalleader = ' '
		  vim.wo.number = true
		  vim.opt.colorcolumn = "80"
		  vim.wo.relativenumber = true

		  -- Catppuccin
			vim.cmd.colorscheme('catppuccin-mocha')
		  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		  -- Telescope
		  local telescope = require('telescope.builtin')
		  vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
		  vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
		  vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
		  vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

		  -- Treesitter
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})

      -- NVTerm
      require("nvterm").setup()
			local nvterm = require('nvterm.terminal')
			local toggle_modes = { 'n', 't' }
			local nvterm_mappings = {
				{
					toggle_modes, '<A-i>', function () nvterm.toggle('float') end
				},
			}
			local opts = { noremap = true, silent = true }
			for _, mapping in ipairs(nvterm_mappings) do
				vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
			end

			-- nvim-cmp
			local cmp = require('cmp')
			require('luasnip.loaders.from_vscode').lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({select = true}),
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				},
			})

			-- nvim-lspconfig
			local cmp_nvim_lsp = require('cmp_nvim_lsp')
			local keymap = vim.keymap
			local opts = { noremap = true, silent = true }
			local lsp_servers = {
				'ts_ls',
				'cssls',
				'lua_ls',
				'pyright',
				'volar',
				'clangd',
				'svelte',
				'rust_analyzer',
				'pyright',
				'nixd'
			}
			local on_attach = function(client, bufnr)
				opts.buffer = buffer
				keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)
				keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
				keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
				keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
				keymap.set({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
				keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
				keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
				keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
				keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
			end
			local capabilities = cmp_nvim_lsp.default_capabilities()
			for _, lsp in ipairs(lsp_servers) do
				vim.lsp.config[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities
				})
			end
		'';
	};
}
