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


    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, disko, hyprland, hyprpanel, ... }@inputs:

  let

    inherit (self) outputs;

  in {

    ## SYSTEM SPACE ##
    nixosConfigurations = {

      oakstation = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          #disko.nixosModules.disko
          ./hosts/oakstation
        ];

      };

      oaktop = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          ./hosts/oaktop
          nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
        ];

      };

      oaknas = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          disko.nixosModules.disko
          ./hosts/oaknas
        ];

      };

      iso = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ./.iso
        ];

      };

    };

    ## USER SPACE ##
    homeConfigurations = {

      "mysteroak@oakstation" = home-manager.lib.homeManagerConfiguration {

        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [
            hyprpanel.overlay
          ];
        };
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          #nix-flatpak.homeManagerModules.nix-flatpak
          ./home/mysteroak/oakstation.nix
        ];

      };

      "mysteroak@oaktop" = home-manager.lib.homeManagerConfiguration {

        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [
            hyprpanel.overlay
          ];
        };
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/mysteroak/oaktop.nix
        ];

      };

    };

  };

}
