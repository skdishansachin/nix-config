{ pkgs, ... }:

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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.libinput.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    wl-clipboard
    unzip
    zip
    haruna
    hyprlauncher
    hyprlock
  ];

  users.users.sk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
