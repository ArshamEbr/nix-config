{ config, lib, pkgs, user, ... }:

{
  options.hyprland.hyprpaper = lib.mkEnableOption "hyprpaper";
  config = lib.mkIf config.hyprland.hyprpaper {

    services.hyprpaper = {
      enable = true;
      settings = {
      "$wall" = "${user.assets}";

      preload = [
      	"$wall/nixos-catppuccin-latte.png"
      	"$wall/nixos-catppuccin-mocha.png"
      	"$wall/quasar-catppuccin-mocha.png"
      ];

      wallpaper = [",$wall/quasar-catppuccin-mocha.png"];

      };
    };

  };
}
