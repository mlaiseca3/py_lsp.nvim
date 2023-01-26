local lsp_utils = require("py_lsp.lsp")


local M = {}

M.check_setup = function ()
  local client = lsp_utils.get_client()

  if not client then
    vim.health.report_error("No client attached")
    return false
  end
  -- 
  -- vim.pretty_print(client)
  -- client.settings.python.venv_name / PythonPath
  if client.config.settings.python.venv_name then
    local name = client.config.settings.python.venv_name
    vim.health.report_ok("Virtual Environment '" .. name .. "' found and activated")
  else
    vim.health.report_error("Path to virtual environment not detected")
  end

  if client.config.settings.python.pythonPath then
    local path = client.config.settings.python.pythonPath
    vim.health.report_ok("Virtual Environment '" .. path .. "' found and activated")
  else

    vim.health.report_error("Path of virtual env not found")
    return false
  end

  return true
end


M.check = function()
  vim.health.report_start("py_lsp.nvim Report")

  -- Check for set path and venv
  if M.check_setup() then
    vim.health.report_ok("Setup is correct")
  else
    vim.health.report_error("Setup is incorrect")
  end

  -- TODO: Check for used strategy might need some adjustments
end

return M