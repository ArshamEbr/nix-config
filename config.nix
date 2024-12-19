{ config, lib, pkgs, user, ... }:

{
  imports =
    [
      ./nixosModules
    ];

 # Systemd-Boot
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

 # OpenGL
   hardware.graphics.enable = true;

 # Use Latest Stable Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

 # Enable-Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

 # Time Zone
  time.timeZone = "Asia/Tehran";

 # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

 # Enabling Virtual Related Stuff
  virtual.enable = true;

  networking = {
    hostName = "${user.host}";
    networkmanager.enable = true;
  };
  
  services = {
    udev.packages = [ pkgs.libmtp pkgs.libinput ];
    # Enable CUPS to print documents.
    # printing.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    libinput.enable = true;
    gvfs.enable = true;

    displayManager.sddm = {
       enable = true;
       wayland.enable = true;
       package = pkgs.kdePackages.sddm;
      };

    pipewire = {
      enable = true;
      pulse.enable = true;
     };
  };

    programs = {
    #adb.enable = true;
    fish.enable = true;


      hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      nh = {
      enable = true;
      flake = "/home/${user.name}/nix-config";
      clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 3";};
      };
    };

    users.users.${user.name} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "NetworkManager"
      "wheel"
      "plugdev"
      "adbusers"
    ];
  };


   environment.systemPackages = with pkgs; [
     tree
     helix
     mesa-demos
     libglvnd
     egl-wayland
     polkit_gnome
     lutris
     nix-prefetch-git
     wget
     neofetch
     git
     curl
     networkmanager
     ffmpegthumbs
     kde-cli-tools
     sbctl
     p7zip
     btop
     lshw
     rustc
     gnumake
     libmtp
     gvfs
     glib
     jmtpfs
      ];

# environment.sessionVariables = {
#  WLR_NO_HARDWARE_CURSORS = "1";
#  NIXOS_OZONE_WL = "1";
# };




security.polkit.enable = true;

systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};

  system.stateVersion = "24.05";

}

