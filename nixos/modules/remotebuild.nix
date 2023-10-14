{ config, pkgs, ... }:
{
  nix.buildMachines = [
    {
      hostName = "compute-01";
      system = "x86_64-linux";
      sshKey = "/home/headb/.ssh/id_rsa";
      sshUser = "headb";
      protocol = "ssh-ng";
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
      maxJobs = 8; # 8-Core CPU
      speedFactor = 10;
    }
    {
      hostName = "edwards-laptop";
      system = "x86_64-linux";
      sshKey = "/home/headb/.ssh/id_rsa";
      sshUser = "headb";
      protocol = "ssh-ng";
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
      maxJobs = 2; # 2-Core CPU
      speedFactor = 3; # Slower than compute-01
    }
  ];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
