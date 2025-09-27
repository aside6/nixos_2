{ config, pkgs, ... }:

let

in {
  home.username = "aside6";
  home.homeDirectory = "/home/aside6";

  programs.home-manager.enable = true;
#  programs.hyprpanel.enable = true;  
 
  home.stateVersion = "25.05";

 }
