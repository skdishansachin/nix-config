# My NixOS Configuration

This repository contains my personal, modular NixOS configuration based on Flakes and Home Manager.

*Note: This is a personal configuration. Do not run it blindly as it contains specific user settings and hardware assumptions. Use it for inspiration or as a reference for your own setup.*

# Usage

This configuration assumes a standard NixOS installation where partitions are labeled `nixos`, `boot`, and `swap`. To apply this configuration, clone the repository and run the rebuild command.

```bash
git clone https://codeberg.com/skdishansachin/nix-config.git
cd nix-config/
sudo nixos-rebuild switch --flake .#sk
```
