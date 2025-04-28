let
  # Yubikey access for editing of secrets
  crystal-peak = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvr2FrC9i1bjoVzg+mdytOJ1P0KRtah/HeiMBuKD3DX cardno:23_836_181";
  depot-37 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvDaJmOSXV24B83sIfZqAUurs+cZ7582L4QDePuc3p7 cardno:17_032_332";
  thunder-mountain = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBexdKZYlyseEcm1S3xNDqPTGZMfm/NcW1ygY91weDhC cardno:30_797_561";
  editing-keys = [ crystal-peak depot-37 thunder-mountain ];

  # Machine keys
  edward-desktop-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOs2G2Yt7+A53v5tymBcbAlWnT9tLZYNSW+XGqZU6ITh";
  edward-laptop-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGOkGgaa7J85LK4Vfe3+NvxxQObZspyRd50OkUQz/Ox";
  #edward-dell-01 = "";
  edwardh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlOFRdX4CqbBfeikQKXibVIxhFjg0gTcTUdTgDIL7H8";
  rpi5-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAHz1QPfx3+31Tw+w/cjBh/oNBWAZ5WU2wEgYe3JDdj5";
  gateway = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFl5CJU+QEKdSV/ybMegoKGT+NamF1FBYcMcSRACZLvJ";
in
{
  # Passwords
  "mail-hashed-password.age".publicKeys = [ edwardh ];
  "grafana-admin-password.age".publicKeys = [ gateway ];
  "radicale-htpasswd.age".publicKeys = [ edwardh ];

  # Dendrite/Matrix
  "dendrite-environment-file.age".publicKeys = [ rpi5-01 ];
  "dendrite-matrix-key.age".publicKeys = editing-keys ++ [ rpi5-01 ];

  # Nix Cache signing private keys
  "harmonia-signing-key.age".publicKeys = [ rpi5-01 ];
  "ncps-signing-key.age".publicKeys = [ rpi5-01 ];

  # WG0 (remote access to home servers): 172.16.10.0/24
  # Server
  "wg0-edwardh-key.age".publicKeys = [ edwardh ];
  # Client
  "wg0-gateway-key.age".publicKeys = [ gateway ];
  "wg0-gateway-preshared-key.age".publicKeys = [ edwardh gateway ];

  # WG1 (remote access to home servers and LAN): 172.16.11.0/24
  # Server
  "wg1-edwardh-key.age".publicKeys = [ edwardh ];
  # Clients
  "wg1-gateway-key.age".publicKeys = [ gateway ];
  "wg1-gateway-preshared-key.age".publicKeys = [ edwardh gateway ];
  "wg1-edward-laptop-01-key.age".publicKeys = [ edward-laptop-01 ];
  "wg1-edward-laptop-01-preshared-key.age".publicKeys = [ edwardh edward-laptop-01 ];
  #"wg1-edward-dell-01-key.age".publicKeys = [ edward-dell-01 ];
  #"wg1-edward-dell-01-preshared-key.age".publicKeys = [ edwardh edward-dell-01 ];

  # WG2 (remote access to home WAN): 172.16.12.0/24
  # Server
  "wg2-edwardh-key.age".publicKeys = [ edwardh ];
  # Clients
  "wg2-gateway-key.age".publicKeys = [ gateway ];
  "wg2-gateway-preshared-key.age".publicKeys = [ edwardh gateway ];
  "wg2-edward-laptop-01-key.age".publicKeys = [ edward-laptop-01 ];
  "wg2-edward-laptop-01-preshared-key.age".publicKeys = [ edwardh edward-laptop-01 ];
  #"wg2-edward-dell-01-key.age".publicKeys = [ edward-dell-01 ];
  #"wg2-edward-dell-01-preshared-key.age".publicKeys = [ edwardh edward-dell-01 ];
  # Clients: Phones
  "wg2-edwards-iphone-preshared-key.age".publicKeys = [ edwardh ];
}
