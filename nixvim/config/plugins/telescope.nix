{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    settings.defaults = {
      borderchars = [ "─" "│" "─" "│" "╭" "╮" "╯" "╰" ];
      set_env.COLORTERM = "truecolor";
      mappings.i."<c-c>".__raw = ''
        function()
            vim.cmd('stopinsert!')
        end
      '';
      file_ignore_patterns = [
        "%.jpg" "%.jpeg" "%.png" "%.otf" "%.ttf" "%.o" "%.arxml" "%.dvg" "%.dll*" "%.exe" "%.defines" "%.jar"
      ];
      layout_strategy = "flex";
    };
  };

  extraPackages = with pkgs; [
    fd
    ripgrep # live_grep
  ];
}
