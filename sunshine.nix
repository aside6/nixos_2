# /etc/nixos/sunshine.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sunshine
    moonlight-qt
  ];

  services.sunshine = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    settings.video_encoder = "auto";
    settings.enable_vsync = false;
  };

}
