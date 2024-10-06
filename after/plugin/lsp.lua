local lsp = require("lsp-zero").preset({manage_nvim_cmp = false})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup_servers({'pyright', 'emmet_language_server', "java_language_server", "djlsp", "gopls"})


local lspconfig = require('lspconfig')

lspconfig.java_language_server.setup{}

lspconfig.djlsp.setup{}

lspconfig.gopls.setup{}

lspconfig.pyright.setup {
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportIncompatibleVariableOverride = "none"
        }
      }
    }
  }
}

lspconfig.emmet_language_server.setup{}

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }, 
   mapping = {
    ['<ENTER>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

