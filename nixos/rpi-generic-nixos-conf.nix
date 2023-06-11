{ config, pkgs, lib, ... }:

let
  sshkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9IxocfA5legUO3o+cbbQt75vc19UG9yrrPmWVLkwbmvGxCtEayW7ubFNXo9CwlPRqcudOARZjas3XJ4+ZwrDJC8qWrSNDSw1izZizcE5oFe/eTaw+E7jT8KcUWWfdUmyx3cuJCHUAH5HtqTXc5KtZ2PiW91lgx77CYEoDKtt14cqqKvBvWCgj8xYbuoZ5lS/tuF2TkYstxI9kNI2ibk14/YyUfPs+hVTeBCz+0/l87WePzYWwA6xkkZZzGstcpXyOKSrP/fchFC+CWs7oeoJSJ5QGkNqia6HFQrdw93BtGoD2FdR3ruNJa27lOFQcXRyijx43KVr4iLuYvdGw5TEt headb@Edwards-Laptop";
in
{
  imports = [
    ./modules/basesystemsettings.nix
    ./modules/homemanager.nix
    ./modules/zsh.nix
  ];

  imports = [
    /root/rpi-wireless.nix
  ];
imports = [
  "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"
];
  boot.loader.raspberryPi = {
    enable = true;
    version = 4;
  };
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = lib.mkForce false;

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
     # Networks are defined in the import at the top.
    # Example:
    #networks = {
    #   "networkSSID" = {
    #     psk = "networkPassword";
    #   };
    # };
    };

    networking.interfaces.wlan0.ipv4.addresses = [ {
  address = "192.168.155.235";
  prefixLength = 24;
} ];
networking.defaultGateway = "192.168.155.1";
networking.nameservers = [ "192.168.155.1" "1.1.1.1" ];

systemd.services.customstartnetworking = {
  script = ''
    systemctl start wpa_supplicant
  '';
  wantedBy = [ "multi-user.target" ];
};

    users.users.pi = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };

   environment.systemPackages = with pkgs; [
     vim
     wget
     git
   ];

services.openssh = {
  enable = true;
  passwordAuthentication = false;
  kbdInteractiveAuthentication = false;
  permitRootLogin = "yes";
};

users.users.root.openssh.authorizedKeys.keys = [ sshkey ];
users.users.pi.openssh.authorizedKeys.keys = [ sshkey ];

    # Enable GPU acceleration
    hardware.raspberry-pi."4".fkms-3d.enable = true;
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-runtime
      ];
    };
  };
    nixpkgs.config.allowUnsupportedSystem = true;

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
};

  # Networking settings.
  networking.hostName = "nixospi";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  }
