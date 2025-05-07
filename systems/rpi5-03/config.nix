{ outputs, ... }:
{
  networking.hostName = "rpi5-03";

  imports = with outputs.nixosModules; [
    basicConfig
    distributedBuilds
    fzf
    git
    headless
    fileSystems
    monitoring
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
