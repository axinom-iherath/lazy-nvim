local opt = vim.opt

opt.relativenumber = false
opt.colorcolumn = "100"

-- Root dir for <leader><space> etc. When no file is open (dashboard / empty
-- buffer), use the folder nvim was started in instead of searching upward for
-- `.git` / `lua`, which can resolve to a parent folder.
LazyVim.root.detectors.startdir = function(buf)
  if vim.api.nvim_buf_get_name(buf) == "" or vim.bo[buf].buftype ~= "" then
    return { vim.uv.cwd() }
  end
  return {}
end

vim.g.root_spec = {
  "startdir",
  "lsp",
  { ".git", "lua" },
  "cwd",
}

-- eslint
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_prettier_needs_config = true

if vim.g.neovide then
  vim.opt.linespace = 1
  -- vim.g.neovide_opacity = 0.8
  -- vim.g.neovide_window_blur = true
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_cursor_vfx_mode = "railgun" -- Visual effect on cursor jump

  vim.keymap.set("t", "<C-S-v>", function()
    local keys = vim.api.nvim_replace_termcodes('<C-\\><C-n>"+pi', true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { desc = "Paste from system clipboard" })

  local function paste()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end
  -- Not mapped in normal mode so <C-v> keeps starting visual block mode
  -- (`p` already pastes the system clipboard via clipboard=unnamedplus)
  vim.keymap.set({ "i", "c", "t" }, "<C-v>", paste, { desc = "Paste from system clipboard" })
end
