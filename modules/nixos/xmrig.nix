{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    monero-cli
    xmrig
  ];
  services.xmrig = {
    enable = true;
    package = pkgs.xmrig;
    settings = {
      autosave = true;
      cpu = true;
      #      opencl = {
      #enabled = true;
      #loader = "${pkgs.ocl-icd}/lib/libOpenCL.so";
      #platform = 0;
      #};
      cuda = false;
      pools = [
        {
          # P2Pool
          url = "edward-desktop-01:3333";
        }
      ];
    };
  };
  systemd.services.xmrig-stop = {
    description = "Stop xmrig";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/true";
    };
  };
  systemd.services.xmrig = {
    conflicts = [ "xmrig-stop.service" ];
    requires = [ "p2pool.service" ];
  };

  systemd.timers.xmrig-start = {
    enable = true;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "xmrig.service";
      OnCalendar = "*-*-* 00:30:00";
    };
  };
  systemd.timers.xmrig-stop = {
    enable = true;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "xmrig-stop.service";
      OnCalendar = "*-*-* 05:30:00";
    };
  };
}
