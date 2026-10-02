{ ... }:
let
  sign = { text = "▌"; };
in
{
  plugins.gitsigns = {
    enable = true;
    settings = {
      update_debounce = 50;
      current_line_blame_opts.delay = 0;
      preview_config.border = "rounded";
      signs = {
        add = sign;
        change = sign;
        delete = sign;
        topdelete = sign;
        changedelete = sign;
      };
    };
  };
}
