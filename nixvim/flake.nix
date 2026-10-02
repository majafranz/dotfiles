{
  description = "Maja's neovim config as nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, nixvim, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # host properties used when built standalone (`nix run`)
        defaultProperties = {
          isDevel = true;
        };
        nixvimModule = properties: {
          inherit pkgs;
          module = import ./config;
          extraSpecialArgs = {
            properties = defaultProperties // properties;
          };
        };
      in
      {
        # usage: mkNixVim.${system} host.properties
        mkNixVim = properties:
          nixvim.legacyPackages.${system}.makeNixvimWithModule (nixvimModule properties);

        packages.default =
          nixvim.legacyPackages.${system}.makeNixvimWithModule (nixvimModule { });

        checks.default =
          nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule (nixvimModule { });
      });
}
