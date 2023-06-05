local util = require 'lspconfig.util'
local env = {
  HOME = vim.loop.os_homedir(),
  JDTLS_HOME = os.getenv 'JDTLS_HOME',
  JAVA_HOME = os.getenv 'JAVA_HOME',
  XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
  JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
  JAVA_DEBUG = os.getenv 'JAVA_DEBUG',
  JDTLS_CONFIG = os.getenv 'JDTLS_CONFIG',
}
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or util.path.join(env.HOME, '.cache')
end

local function get_jdtls_cache_dir()
  return util.path.join(get_cache_dir(), 'jdtls')
end

local function get_jdtls_config_dir()
  return util.path.join(get_jdtls_cache_dir(), 'config')
end

local function get_jdtls_workspace_dir()
  return util.path.join(get_jdtls_cache_dir(), 'workspace' ) .. project_name
end

local function get_os_config()
  local os_info = vim.loop.os_uname()
  if env.JDTLS_CONFIG then
    return env.JDTLS_CONFIG
  elseif os_info.sysname == "Windows" then
    return "config_win"
  elseif os_info.sysname == "Linux" then
    return "config_linux"
  elseif os_info.sysname == "Darwin" then
    return "config_mac"
  else
    return "unknown"
  end
end

local jdtls_bin = util.path.join(env.JDTLS_HOME, '/bin/jdtls')
local java_bin = util.path.join(env.JAVA_HOME, '/bin/java')
local java_debug_path = util.path.join(env.JAVA_DEBUG, 'com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/jdtls.lua

local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    java_bin, -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob(util.path.join(env.JDTLS_HOME, '/plugins/org.eclipse.equinox.launcher_*.jar'),1),
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', util.path.join(env.JDTLS_HOME, get_os_config()),
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', get_jdtls_workspace_dir(),
    get_jdtls_jvm_args()
  },
  filetypes = {'java'} ,

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
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
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {name = "JavaSE-1.8", path= "/opt/jdk-8"},
          {name = "JavaSE-13", path= "/opt/jdk-13"},
          {name = "JavaSE-17", path= "/opt/jdk-17"}
        }
      }
    }
  },
  signatureHelp = { enabled = true },
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
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {
      vim.fn.glob(java_debug_path, 1)
    }
  },
}
config['on_attach'] = function(client, bufnr)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  -- You can use the `JdtHotcodeReplace` command to trigger it manually
  -- require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  require('jdtls.setup').add_commands()
end
vim.cmd([[
  nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
  nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
  vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
  nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
  vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
  vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
  nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
  nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
]])

require('jdtls').start_or_attach(config)
