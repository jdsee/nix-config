local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify('JDTLS not found, install with `:LspInstall jdtls`', 'error')
  return
end

local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local config_dir = jdtls_dir .. '/config/config_linux'
local plugins_dir = jdtls_dir .. '/plugins'
local path_to_jar = plugins_dir .. '/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
-- local path_to_lombok = jdtls_dir .. '/lombok.jar'
local jdtls_bin = vim.fn.stdpath('data') .. '/mason/bin/jdtls'
local home = os.getenv("HOME")

local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gralde' }
local root_dir = jdtls.setup.find_root(root_markers)
if root_dir == '' then
  vim.notify("unable to setup nvim-jdtls", "error")
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace_root/' .. project_name
os.execute('mkdir ' .. workspace_dir)


local config = {
  cmd = {
    '/home/jdsee/.nix-profile/bin/java', -- Consider to change this
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    -- '-javaagent:' .. lombok_path,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', path_to_jar,
    '-configuration', path_to_lsp_server,

    -- jdtls_bin,
    -- '-javaagent:' .. lombok_path,
    '-data', workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      home = '/home/jdsee/.nix-profile/bin/java',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-19',
            path = '/home/jdsee/.nix-profile/bin/java',
          },
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath('config') .. '/lang-servers/intellij-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
      signatureHelp = {
        enabled = true,
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
      },
      extendedClientCapabilities = extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      bundles = {},
    },
  },
  on_attach = function(client, bufnr)
    jdtls.setup.add_commands()
    require('jdsee.lsp.config').on_attach(client, bufnr)
  end
}

jdtls.start_or_attach(config)
