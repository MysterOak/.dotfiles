{

  description = " OakFlake ";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hyprland.url = "github:hyprwm/Hyprland";
    #hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, disko, impermanence, ... }@inputs:

  let

    inherit (self) outputs;

  in {

    ## SYSTEM SPACE ##
    nixosConfigurations = {

      oakstation = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          ./hosts/oakstation
        ];

      };

      oaktop = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-nvidia-disable
          ./hosts/oaktop
        ];

      };

      oaknas = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          ./hosts/oaknas
        ];

      };

      iso = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./.iso
        ];

      };

    };

    ## USER SPACE ##
    homeConfigurations = {

      "mysteroak@oakstation" = home-manager.lib.homeManagerConfiguration {

        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/mysteroak/oakstation.nix
        ];

      };

      "mysteroak@oaktop" = home-manager.lib.homeManagerConfiguration {

        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/mysteroak/oaktop.nix
        ];

      };

    };

  };

}
