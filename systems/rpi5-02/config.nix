{ outputs, ... }:
{
  networking.hostName = "rpi5-02";

  imports = with outputs.nixosModules; [
    basicConfig
    distributedBuilds
    fzf
    git
    headless
    monitoring
    fileSystems
    ssh
    users
    zsh
  ];

  networking.firewall.allowedTCPPorts = [ 9002 ];

  environment.systemPackages = [
  ];

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.05";
}
