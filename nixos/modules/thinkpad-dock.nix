{ pkgs, config, ... }: 
let
hass-api-key = config.age.secrets.home-assistant-api-key.path;
in
  {
    age.secrets.home-assistant-api-key.file = ../../secrets/home-assistant-api-key.age;
  imports = [
    ../../nixos-thinkpad-dock
  ];
  hardware = {
    thinkpad-dock = {
      enable = true;

      # Tell my HomeAssistant server that the laptop has been docked.
      dockEvent = ''
      ${pkgs.curl}/bin/curl -X POST -H 'Authorization: Bearer `cat ${hass-api-key}`' -H 'Content-Type: application/json' -d '{ \"state\": true}' http://192.168.155.222:8123/api/states/sensor.Laptop_Docked > /tmp/acpiDock.log
      '';
      undockEvent = ''
${pkgs.curl}/bin/curl -X POST -H 'Authorization: Bearer `cat ${hass-api-key}`' -H 'Content-Type: application/json' -d ' {\"state\": false}' http://192.168.155.222:8123/api/states/sensor.Laptop_Docked > /tmp/acpiUndock.log
      '';
    };
  };
}
