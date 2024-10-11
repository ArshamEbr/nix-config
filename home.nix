{ config, lib, pkgs, inputs, user, ... }:

{
  imports =
    [
     ./homeModules
    ];

  home = {
    username = "${user.name}";
    homeDirectory = "/home/${user.name}";
    stateVersion = "24.05";

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  hyprland = {
    enable = true;
    hyprpaper = false;
  };
  guiPrograms.enable = true;
  modules.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.home-manager.enable = true;
}
