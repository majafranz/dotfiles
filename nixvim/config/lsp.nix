{ lib, pkgs, properties, ... }:
{
  # language servers and formatters only on development systems
  lsp.servers = {
    "*".config = {
      capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
      root_markers = [ ".git" ];
    };
    pyright = {
      enable = properties.isDevel;
      config = {
        cmd = [ "pyright-langserver" "--stdio" ];
        filetypes = [ "python" ];
      };
    };
  };

  # default server configs (lsp/*.lua) for vim.lsp.config
  plugins.lspconfig.enable = properties.isDevel;

  extraPackages = lib.optionals properties.isDevel (with pkgs; [
    ruff
    ty
  ]);

  diagnostic.settings = {
    severity_sort = true;
    float = {
      border = "rounded";
      header = "";
      source = "if_many";
    };
  };
}
