{
  description = "emptyExample";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import ./nix/overlays/tess2-overlay.nix)
          ];
        };
      in rec {
        # nix build
        packages.default = import ./default.nix { inherit pkgs; };

        # nix run
        apps.default = flake-utils.lib.mkApp { drv = packages.default; };

        # nix develop
        devShell = import ./shell.nix { inherit pkgs; inherit packages; };
      });
}
