{ pkgs, ... }:
let
  # lua is bundled with neovim
  languages = [
    "gitcommit"
    "diff"
    "git_rebase"
    "c"
    "python"
    "cpp"
    "make"
    "bash"
    "markdown"
    "markdown_inline"
  ];
in
{
  # nvim-treesitter (main branch) only provides parsers and queries,
  # highlighting is started per filetype
  extraPlugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: map (l: p.${l}) languages))
  ];

  autoCmd = [{
    event = [ "FileType" ];
    pattern = languages ++ [ "lua" ];
    callback.__raw = "function() vim.treesitter.start() end";
  }];
}
