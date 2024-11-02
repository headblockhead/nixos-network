{ inputs, outputs, config, pkgs, lib, ... }:

{
  networking.hostName = "printerpi";

  imports = with outputs.nixosModules; [
    basicConfig
    cachesGlobal
    cachesLocal
    distributedBuilds
    git
    firewall
    homeManager
    users
    ssh
    zsh
  ];

  services.klipper = {
    enable = true;
    logFile = "/var/log/klipper.log";
    settings = { };
    firmwares.sv01 = {
      enable = true;
      serial = "/dev/ttyUSB0";
      enableKlipperFlash = true;
    };
  };

  services.moonraker = {
    enable = true;
    settings = { };
    allowSystemControl = true;
  };

  services.mainsail = {
    enable = true;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # Extra packages to install
  environment.systemPackages = [
    pkgs.xc
  ];

  # Use firmware even if it has a redistributable license
  hardware.enableRedistributableFirmware = lib.mkForce true;

  # Passwordless sudo for wheel group.
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.05";
}
