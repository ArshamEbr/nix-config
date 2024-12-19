{ config, lib, pkgs, ... }:

{
  options.guiPrograms.kitty = lib.mkEnableOption "kitty";
  config = lib.mkIf config.guiPrograms.kitty {

    programs.kitty = {
      enable = true;

      settings = {
        window_padding_width = 5;
        background_opacity = lib.mkForce "0.7";
        dynamic_background_opacity = true;
        background_blur = 5;
        confirm_os_window_close = 0;
        enable_audio_bell = true;
      };
    };

  };
}