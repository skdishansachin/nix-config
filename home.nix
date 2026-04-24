{ pkgs, config, ... }:

{
  home.username = "sk";
  home.homeDirectory = "/home/sk";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    librewolf
    age
    tmux
    ripgrep
    nixfmt
    python3
    nodejs_24
    pnpm
    zig
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_10_0
      dotnetCorePackages.sdk_9_0
    ])
    jadx
  ];
  home.sessionPath = [ "$HOME/.local/bin" ];

  imports = [
    ./modules/hyprland.nix
    ./modules/theme.nix
    ./modules/git.nix
    ./modules/bash.nix
    ./modules/nvim.nix
    ./modules/alacritty.nix
  ];
}
