let
  edward-desktop-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOs2G2Yt7+A53v5tymBcbAlWnT9tLZYNSW+XGqZU6ITh";
  edward-laptop-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGOkGgaa7J85LK4Vfe3+NvxxQObZspyRd50OkUQz/Ox";
  edward-dell-01 = "";
  edwardh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlOFRdX4CqbBfeikQKXibVIxhFjg0gTcTUdTgDIL7H8";
  rpi5-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHz1QPfx3+31Tw+w/cjBh/oNBWAZ5WU2wEgYe3JDdj5";
  gateway = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFl5CJU+QEKdSV/ybMegoKGT+NamF1FBYcMcSRACZLvJ";
in
{
  "mail-hashed-password.age".publicKeys = [ edward-desktop-01 edwardh ];
  "grafana-admin-password.age".publicKeys = [ edward-desktop-01 gateway ];
  "radicale-htpasswd.age".publicKeys = [ edward-desktop-01 edwardh ];

  "harmonia-signing-key.age".publicKeys = [ edward-desktop-01 rpi5-01 ];
  "ncps-signing-key.age".publicKeys = [ edward-desktop-01 rpi5-01 ];

  "wg0-edwardh-key.age".publicKeys = [ edward-desktop-01 edwardh ];
  "wg0-gateway-key.age".publicKeys = [ edward-desktop-01 gateway ];

  "wg1-shared-secret.age".publicKeys = [ edward-desktop-01 edward-laptop-01 edward-dell-01 gateway ];
  "wg1-edward-laptop-01-key.age".publicKeys = [ edward-desktop-01 edward-laptop-01 ];
  "wg1-edward-dell-01-key.age".publicKeys = [ edward-desktop-01 edward-dell-01 ];
  "wg1-gateway-key.age".publicKeys = [ edward-desktop-01 gateway ];
}
