{
  basicConfig = import ./basicConfig.nix;
  bluetooth = import ./bluetooth.nix;
  bootloaderGraphical = import ./bootloaderGraphical.nix;
  bootloaderText = import ./bootloaderText.nix;
  cachesGlobal = import ./cachesGlobal.nix;
  cachesLocal = import ./cachesLocal.nix;
  desktop = import ./desktop.nix;
  desktopApps = import ./desktopApps.nix;
  development = import ./development.nix;
  distributedBuilds = import ./distributedBuilds.nix;
  docker = import ./docker.nix;
  fileSystems = import ./fileSystems.nix;
  firewall = import ./firewall.nix;
  fonts = import ./fonts.nix;
  fzf = import ./fzf.nix;
  git = import ./git.nix;
  gpg = import ./gpg.nix;
  homeManager = import ./homeManager.nix;
  mail = import ./mail.nix;
  network = import ./network.nix;
  openrgb = import ./openrgb.nix;
  p2pool = import ./p2pool.nix;
  printer = import ./printer.nix;
  router = import ./router.nix;
  sdr = import ./sdr.nix;
  sheepit = import ./sheepit.nix;
  snapclient = import ./snapclient.nix;
  sound = import ./sound.nix;
  ssd = import ./ssd.nix;
  ssh = import ./ssh.nix;
  users = import ./users.nix;
  virtualBox = import ./virtualBox.nix;
  wireguard = import ./wireguard.nix;
  xmrig = import ./xmrig.nix;
  yubikey = import ./yubikey.nix;
  zsh = import ./zsh.nix;
}
