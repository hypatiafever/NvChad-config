local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<C-Down>"] = {
      "<cmd> DapStepInto <CR>",
      "DAP Step Into",
    },
    ["<C-Up>"] = {
      "<cmd> DapStepOut <CR>",
      "DAP Step Out",
    },
    ["<C-Right>"] = {
      "<cmd> DapStepOver <CR>",
      "DAP Step Over",
    },
  }
}

M.dapui = {
  plugin = true,
  v = {
    ["<leader>de"] = {
      "<Cmd>lua require'dapui'.eval()<CR>",
      "Evaluate under cursor",
    },
  },
  n = {
    ["<leader>dx"] = {
      "<cmd>DapTerminate<CR><cmd>lua require'dapui'.close()<CR>",
      "Stop debugging",
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
