{ outputs, lib, ... }:

{
  networking.hostName = "dell-netboot-client";

  imports = with outputs.nixosModules; [
    basicConfig
    fzf
    git
    gpg
    network
    sound
    ssd
    zsh
  ];

  boot.loader.timeout = lib.mkForce 5;
  users.ldap = {
    enable = true;
    timeLimit = 15;
    server = "ldap://BRIDGE.ENTERPRISE";
    base = "dc=BRIDGE,dc=ENTERPRISE";
  };

  environment.systemPackages = [
  ];

  system.stateVersion = "22.05";
}
