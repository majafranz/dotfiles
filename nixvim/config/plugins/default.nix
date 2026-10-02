{ pkgs, ... }:
{
  imports = [
    ./blink.nix
    ./git.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  colorschemes.gruvbox.enable = true;
  opts.background = "dark";

  plugins = {
    nvim-autopairs.enable = true;
    # no nerd fonts on the servers
    web-devicons.enable = false;
  };

  # plugins without a nixvim module
  extraPlugins = with pkgs.vimPlugins; [
    csv-vim
    nerdtree
  ];
}
