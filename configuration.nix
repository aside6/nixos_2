{ config, pkgs, ... }:

let
  # Fetch the correct Home Manager release for 25.05
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in

{  imports =
    [
      ./hardware-configuration.nix
      ./sunshine.nix
      (import "${home-manager}/nixos")
    ];

#  nix.settings.experimental.features = [ "nix-command" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;

#      fonts.packages = with pkgs; [ nerdfonts ];
#fonts.packages = [  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
#  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  fonts.packages = [
           pkgs.nerd-fonts.ubuntu
           pkgs.nerd-fonts.droid-sans-mono
         ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.aside6 = {
    isNormalUser = true;
    description = "aside6";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.aside6 = import ./home.nix;

#  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "aside6";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    kitty
    vscode
    micro
    nautilus
    ranger
    yazi
    pavucontrol
    helvum
    thunderbird
    vulkan-tools
    vulkan-loader
    lutris
    mpv
    neovim
    rofi-wayland
    discord
    slurp
    grim
    wl-clipboard
    feishin
    cava
    hyprpanel
  ];

  system.stateVersion = "25.05";  # Use the appropriate NixOS version
}
