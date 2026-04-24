return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    { 'mxsdev/nvim-dap-vscode-js', dependencies = { 'microsoft/vscode-js-debug' } },
  },
  keys = {
    { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<leader>dx', function() require('dap').terminate() end, desc = 'Debug: Stop' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Conditional Breakpoint',
    },
    { '<leader>dn', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<leader>do', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve', -- Go
        'debugpy', -- Python
        'codelldb', -- C, C++, Rust
        'js-debug-adapter', -- JavaScript, TypeScript
      },
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '↓',
          step_over = '→',
          step_out = '↑',
          step_back = '←',
          run_last = '↺',
          terminate = '□',
          disconnect = '⏏',
        },
      },
    }

    -- Auto-open/close UI with session
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Go
    require('dap-go').setup {
      delve = { detached = vim.fn.has 'win32' == 0 },
    }

    -- Python
    local debugpy_path = require('mason-registry').get_package('debugpy'):get_install_path()
    dap.adapters.python = {
      type = 'executable',
      command = debugpy_path .. '/venv/bin/python',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_DEFAULT_ENV'
          if venv then
            return venv .. '/bin/python'
          end
          return vim.fn.exepath 'python3' or vim.fn.exepath 'python' or 'python'
        end,
      },
    }

    -- C, C++, Rust
    local codelldb_path = require('mason-registry').get_package('codelldb'):get_install_path()
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path .. '/codelldb',
        args = { '--port', '${port}' },
      },
    }
    dap.configurations.c = {
      {
        type = 'codelldb',
        request = 'launch',
        name = 'Launch executable',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = {
      {
        type = 'codelldb',
        request = 'launch',
        name = 'Launch Rust program',
        program = function()
          local metadata = vim.fn.system 'cargo metadata --format-version 1 --no-deps'
          local json = vim.fn.json_decode(metadata)
          local target_dir = json.target_directory
          local name = json.packages[1].name:gsub('-', '_')
          return target_dir .. '/debug/' .. name
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- JavaScript / TypeScript
    local js_debug_path = require('mason-registry').get_package('js-debug-adapter'):get_install_path()
    require('dap-vscode-js').setup {
      debugger_path = js_debug_path,
      adapters = { 'pwa-node', 'pwa-chrome' },
    }
    for _, lang in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
      dap.configurations[lang] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Node program',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to Node process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end

    -- Load .vscode/launch.json if present
    local function load_launch_json()
      local launch_json = vim.fn.getcwd() .. '/.vscode/launch.json'
      if vim.fn.filereadable(launch_json) == 1 then
        require('dap.ext.vscode').load_launchjs(launch_json, {
          ['node'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
          ['pwa-node'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
          ['pwa-chrome'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
          ['python'] = { 'python' },
          ['codelldb'] = { 'c', 'cpp', 'rust' },
          ['cppdbg'] = { 'c', 'cpp' },
          ['go'] = { 'go' },
        })
      end
    end

    load_launch_json()
    vim.api.nvim_create_autocmd('DirChanged', { callback = load_launch_json })
  end,
}
