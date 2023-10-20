local dap = require('dap')
require("dap-python").setup('~/src/.virtualenvs/debugpy/bin/python')

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {"/home/ec2-user/src/vscode-php-debug.git/out/phpDebug.js"},
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/usr/bin/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = '9003',
        log = true,
        serverSourceRoot = '/var/www/',
        localSourceRoot = vim.fn['getcwd'](),

    },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
  {
      type = 'remote_python',
      name = 'Generic remote',
      request = 'attach',
      host = 'localhost',
      port = 5678,
      pathMappings = {{
        -- Update this as needed
        localRoot = vim.fn.getcwd();
        remoteRoot = "/code/";
      }};
  },
  {
      type = 'python',
      name = 'Container',
      request = 'attach',
      host = 'localhost',
      port = 5678,
      mode = "remote",
      pathMappings = {{
        -- Update this as needed
        localRoot = vim.fn.getcwd();
        remoteRoot = "/code/";
      }};
  }
}
