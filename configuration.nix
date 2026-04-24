{ pkgs, lib, ... }:

let
  devLibs = with pkgs; [
    openssl
    zlib
    libffi
  ];
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.hostName = "sk";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 8081 ];

  programs.nix-ld.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.libinput.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages =
    with pkgs;
    [
      curl
      wl-clipboard
      unzip
      zip
      haruna
      hyprlauncher
      hyprlock
      hyprpaper

      gcc
      gnumake
      cmake
      pkg-config
    ]
    ++ devLibs;

  environment.variables = {
    PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" devLibs;
    LIBRARY_PATH = lib.makeLibraryPath devLibs;
    C_INCLUDE_PATH = lib.makeSearchPath "include" devLibs;
    CPLUS_INCLUDE_PATH = lib.makeSearchPath "include" devLibs;
  };

  users.users.sk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
