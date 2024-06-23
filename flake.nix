{
  description = "Reproducable configuration for all of my devices and gadgets. Now including netbooting!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    kicadpkgs.url = "github:NixOS/nixpkgs/e70e1370a88f86ea989902e140172e9cff0d379a";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft/a206a57f11acea07538b341c56dd9edd1c6f1193";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    playdatesdk = {
      url = "github:headblockhead/nix-playdatesdk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    playdatemirror = {
      url = "github:headblockhead/nix-playdatemirror";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rpicluster = {
      url = "github:headblockhead/rpicluster";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    templ = {
      url = "github:a-h/templ";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xc = {
      url = "github:joerdav/xc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcpelauncher = {
      url = "github:headblockhead/nix-mcpelauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , agenix
    , ...
    }@ inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
      ];

      # My public SSH key:
      sshkey = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvr2FrC9i1bjoVzg+mdytOJ1P0KRtah/HeiMBuKD3DX cardno:23_836_181'';

      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    rec {
      # Custom packages: accessible through 'nix build', 'nix shell', etc.
      packages = forAllSystems (system: import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; inherit inputs; });

      # Exported overlays. Includes custom packages and flake outputs.
      overlays = import ./overlays { inherit inputs; };

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # Network nodes.
        router = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs agenix sshkey; };
          modules = [
            ./systems/router/config.nix
            ./systems/router/hardware.nix

            agenix.nixosModules.default
          ];
        };

        # Client nodes.
        edward-desktop-01 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs agenix sshkey; };
          modules = [
            ./systems/edward-desktop-01/config.nix
            ./systems/edward-desktop-01/hardware.nix

            agenix.nixosModules.default
          ];
        };
        edward-laptop-01 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs agenix sshkey; };
          modules = [
            ./systems/edward-laptop-01/config.nix
            ./systems/edward-laptop-01/hardware.nix

            ./systems/edward-laptop-01/specialisations/away.nix

            agenix.nixosModules.default
          ];
        };
        edward-laptop-02 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs agenix sshkey; };
          modules = [
            ./systems/edward-laptop-02/config.nix
            ./systems/edward-laptop-02/hardware.nix

            agenix.nixosModules.default
          ];
        };

        # AWS EC2 nodes.
        barkup = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs agenix sshkey; };
          modules = [
            "${nixpkgs}/nixos/modules/virtualisation/amazon-image.nix"
            ./systems/barkup/config.nix
            {
              nixpkgs.hostPlatform = "x86_64-linux";
            }

            agenix.nixosModules.default
          ];
        };

        # Portable system.
        portable = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs agenix sshkey; };
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
            #"${nixpkgs}/nixos/modules/installer/sd-card/sd-image-x86_64.nix"
            ./systems/portable/config.nix
            ./systems/portable/hardware.nix
          ];
        };
      };

      # ISO image for a portable USB stick.
      portableiso = nixosConfigurations.portable.config.system.build.isoImage;

      homeConfigurations = {
        "headb@router" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./systems/router/users/headb.nix ];
        };
        "headb@edward-desktop-01" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./systems/edward-desktop-01/users/headb.nix ];
        };
        "headb@edward-laptop-01" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./systems/edward-laptop-01/users/headb.nix ];
        };
        "headb@edward-laptop-02" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./systems/edward-laptop-02/users/headb.nix ];
        };
        "headb@barkup" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./systems/barkup/users/headb.nix ];
        };
      };
    };
}
