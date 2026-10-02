{ ... }:
let
  # set buffer-independent indentation like the old lua config did
  indent = width: expandtab: {
    __raw = ''
      function()
          vim.o.shiftwidth = ${toString width}
          vim.o.tabstop = ${toString width}
          vim.o.expandtab = ${if expandtab then "true" else "false"}
      end
    '';
  };
  cmd = event: pattern: callback: {
    inherit event pattern callback;
    group = "UserSettings";
  };
in
{
  autoGroups.UserSettings.clear = true;

  autoCmd = [
    # highlight yank for 250ms
    (cmd [ "TextYankPost" ] [ "*" ] {
      __raw = ''
        function()
            vim.highlight.on_yank({ on_visual = false, timeout = 250 })
        end
      '';
    })
    # toggle hiding invisible chars on insert
    (cmd [ "InsertEnter" ] [ "*" ] { __raw = "function() vim.wo.list = false end"; })
    (cmd [ "InsertLeave" ] [ "*" ] { __raw = "function() vim.wo.list = true end"; })

    (cmd [ "BufNewFile" "BufRead" ] [ "*.tex" ] (indent 2 true))
    # set tab width dynamically on c-like files
    (cmd [ "FileType" ] [ "c" "cpp" "sh" "make" "arduino" ] (indent 2 false))
    # set tab width dynamically on vue and ts files
    (cmd [ "FileType" ] [ "vue" "ts" ] (indent 4 false))
    (cmd [ "FileType" ] [ "r" ] (indent 2 true))
  ];
}
