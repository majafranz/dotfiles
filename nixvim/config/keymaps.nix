{ ... }:
let
  map = mode: key: action: {
    inherit mode key action;
    options.silent = true;
  };
  lspMap = key: fn: map "n" key "<cmd>lua ${fn}<CR>";
in
{
  keymaps = [
    # clear highlight on space
    (map "n" "<space>" "<cmd>noh<CR>")

    # nerdtree
    (map "n" "<C-t>" ":NERDTreeToggle<CR>")

    # line navigation
    (map "n" "ö" "^")
    (map "n" "ä" "$")
    (map "n" "dä" "d$")
    (map "n" "dö" "d^")
    (map "n" "yä" "y$")
    (map "n" "yö" "y^")
    (map "n" "cä" "c$")
    (map "n" "cö" "c^")
    (map "v" "ö" "^")
    (map "v" "ä" "$")

    # file navigation
    (map "n" "<C-p>" "<C-i>")

    # pane navigation
    (map "n" "<Right>" "<C-w>l")
    (map "n" "<Left>" "<C-w>h")
    (map "n" "<Up>" "<C-w>k")
    (map "n" "<Down>" "<C-w>j")

    # tab navigation
    (map "n" "<Tab>" "gt")
    (map "n" "<S-Tab>" "gT")

    # terminal
    (map "n" "<F1>" "<C-w>s<C-w>j:terminal<CR><C-w>20-i")
    (map "t" "<F1>" "<C-\\><C-n>:q!<CR>")
    (map "n" "<F2>" "<C-w>ji")
    (map "t" "<F2>" "<C-\\><C-n><C-w>k")
    (map "n" "<F3>" "<C-w>v<C-w>l:terminal<CR>i")
    (map "t" "<F3>" "<C-\\><C-n><C-w>v<C-w>l:terminal<CR>i")
    (map "t" "<C-o>" "<C-\\><C-n>") # get out of terminal wo closing

    # gitsigns
    (map "n" "<leader>gn" ":Gitsigns next_hunk<CR>")
    (map "n" "<leader>gp" ":Gitsigns prev_hunk<CR>")
    (map "n" "<leader>gs" ":Gitsigns preview_hunk<CR>")
    (map "n" "<leader>gr" ":Gitsigns reset_hunk<CR>")
    (map "n" "<leader>gd" ":Gitsigns diffthis<CR>")
    (map "n" "<leader>ga" ":Gitsigns stage_hunk<CR>")
    (map "n" "<leader>gu" ":Gitsigns undo_stage_hunk<CR>")

    # lsp
    (lspMap "gD" "vim.lsp.buf.declaration()")
    (lspMap "gd" "vim.lsp.buf.definition()")
    (lspMap "gi" "vim.lsp.buf.implementation()")
    (lspMap "gr" "vim.lsp.buf.references()")
    (lspMap "<leader>e" "vim.diagnostic.open_float()")
    (lspMap "]d" "vim.diagnostic.goto_next()")
    (lspMap "[d" "vim.diagnostic.goto_prev()")
    (lspMap "K" "vim.lsp.buf.hover()")
    (lspMap "<C-k>" "vim.lsp.buf.signature_help()")
    (lspMap "<leader>rn" "vim.lsp.buf.rename()")
    (lspMap "<leader>ca" "vim.lsp.buf.code_action()")
    (lspMap "<leader>f" "vim.lsp.buf.format({timeout_ms = 2000})")

    # telescope
    (map "n" "<C-f><C-f>" ":Telescope find_files<CR>")
    (map "n" "<C-f><C-g>" ":Telescope live_grep<CR>")
  ];
}
