{ pkgs, ... }: {
# SSH login support.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;
  users.users.headb.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9IxocfA5legUO3o+cbbQt75vc19UG9yrrPmWVLkwbmvGxCtEayW7ubFNXo9CwlPRqcudOARZjas3XJ4+ZwrDJC8qWrSNDSw1izZizcE5oFe/eTaw+E7jT8KcUWWfdUmyx3cuJCHUAH5HtqTXc5KtZ2PiW91lgx77CYEoDKtt14cqqKvBvWCgj8xYbuoZ5lS/tuF2TkYstxI9kNI2ibk14/YyUfPs+hVTeBCz+0/l87WePzYWwA6xkkZZzGstcpXyOKSrP/fchFC+CWs7oeoJSJ5QGkNqia6HFQrdw93BtGoD2FdR3ruNJa27lOFQcXRyijx43KVr4iLuYvdGw5TEt headb@compute-01'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzHYmvZTtOnxEcv+/pqGC7bp8aHsWRLl+cXvn1druMOXgDF+7Ioj+sII56FGUG2NCXsdkvtJinEBGSZOaojI1e4iCIMZaZS7Q11JiCGhgoDHSmeJoKpG7+qE8Xeh71KOw2NbtXIQeAXVgmRk07iYzVD+KowwLs1p9u23oFfF+zgj698SBx3ZQyaXJ8c10U23YjABT0zHXPTfRbC5pwZLzbbfSMkvJ5iDQgGrshwxgHB93imUpRqQ4SWLTnSxDn8WzvcCJ+zPFvLi8nc7YfXO6iPGLoB7DGhI4FUjKxvDU+H2kX00GiXzouItZDi3UijuvP04HtmpE16ZtBBahXuY1lkJOYM+vrkKhcgMAwgdHxycXxmHN9PeJmvayentwtQN9T4BSehRCIhuOIxWVyI+wUEIyRJTRpaEh5gqwuXxbYNmHnWaCoP+BRmYuCviWBnYyn2HI9HnspWSmq3wueFH7K+/VyRBpBfsRaKoObv/i7nDDUm60JpCE8givOrvP1lfvhNJIXnz216pkBvvsqzioYM7hv5N8z9WpoYsg+9B0RGcunjuVn9R4DrPJ5j5gFe7gdDdq7gZRiKFm5thKbsjhK3BGr/p4Yvn3TvhdVfZzOU8Ttn1LbdcNDnh0qB0/qsC8jSuSdDnvArC7hQtflc0l7+3hx6up7IZOEfpjGcmq9dQ== root@edwards-laptop''];

  networking.firewall.allowedTCPPorts = [ 22 ]; # Allow SSH connections
  }
