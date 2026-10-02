{ ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./lsp.nix
    ./plugins
  ];

  vimAlias = true;
}
