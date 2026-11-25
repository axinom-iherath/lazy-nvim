-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("x", "Y", [["+y]])

vim.keymap.set(
  "n",
  "<leader>cb",
  [[:set expandtab<cr>:center 80<cr>0<esc>vlc/*<esc>A<esc>40A<space><esc>d80<bar>vhc*/<esc>O/*<space><esc>74A-<esc>a<space>*/<esc>yyjp:set expandtab!<cr>]],
  { silent = true }
)

vim.keymap.set(
  "n",
  "<leader>cB",
  [[:set expandtab<cr>:center 80<cr>hhv0r-vllc/*<space><esc>A<space><esc>40A-<esc>d80<bar>vhh<space>c*/<esc>:set expandtab!<cr>]],
  { silent = true }
)

vim.keymap.set("n", "<leader>cL", "<cmd>LspRestart<cr>", { silent = true })

-- Copy the code location to the clipboard, e.g. to paste into a prompt:
--   normal: /abs/path/file.lua:12:5     visual: /abs/path/file.lua:12-20
vim.keymap.set({ "n", "x" }, "<leader>fy", function()
  local path = vim.fn.expand("%:p")
  if path == "" then
    return vim.notify("Buffer has no file", vim.log.levels.WARN)
  end
  local loc
  if vim.fn.mode():match("[vV\22]") then
    local s, e = vim.fn.line("v"), vim.fn.line(".")
    if s > e then
      s, e = e, s
    end
    loc = s == e and ("%s:%d"):format(path, s) or ("%s:%d-%d"):format(path, s, e)
    vim.cmd("normal! \27") -- leave visual mode
  else
    loc = ("%s:%d:%d"):format(path, vim.fn.line("."), vim.fn.col("."))
  end
  vim.fn.setreg("+", loc)
  vim.notify("Copied " .. loc)
end, { desc = "Copy File Location" })
