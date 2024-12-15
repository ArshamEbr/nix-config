{ config, lib, pkgs, ... }:

{
  options.modules.packages = lib.mkEnableOption "enables packages";
  config = lib.mkIf config.modules.packages {

    home.packages = with pkgs; [
      aria2
      celluloid
      cmatrix
      fragments
      gitui
      libreoffice-fresh
      materialgram
      nautilus
      protonvpn-gui
      tg
      vscodium
     # waybar
      webcord
      brave
      firefox
      dunst
      rofi-wayland
      swww
      cliphist
      hyprpicker
      wlogout
     # discord-ptb
    # networkmanagerapplet
    ];

  };
}