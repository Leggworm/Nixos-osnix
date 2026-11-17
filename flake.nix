{
  description = "NixOS configuration for leggrowm-mini";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    flake-programs-sqlite,
    agenix,
    disko,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
    };
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = [
        (pkgs.writeShellApplication {
          name = "size";
          runtimeInputs = with pkgs; [coreutils gawk];
          text = ''
            system_path="$(readlink -f /run/current-system)"
            nix path-info -rSh "$system_path" | tail -n 1 | awk '{print $2, $3}'
          '';
        })
        (pkgs.writeShellApplication {
          name = "format";
          text = ''
            nix fmt -- --exclude ./.git .
          '';
        })
      ];
    };

    nixosConfigurations.leggrowm-mini = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs pkgs-unstable;
      };
      modules = [
        home-manager.nixosModules.home-manager
        flake-programs-sqlite.nixosModules.programs-sqlite
        agenix.nixosModules.default
        ./hosts/leggrowm-mini.nix
      ];
    };
  };
}
