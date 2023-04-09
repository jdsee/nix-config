local rt = require 'rust-tools'
local config = require 'jdsee.lsp.config'

rt.setup {
  server = {
    on_attach = config.on_attach,
  },
}
