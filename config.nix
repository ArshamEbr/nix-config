{ config, lib, pkgs, user, ... }:

{
  imports =
    [
      ./nixosModules
    ];

hardware.graphics.enable = true;

boot.kernelPackages = pkgs.linuxPackages_latest;

nix.settings.experimental-features = [ "nix-command" "flakes" ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  time.timeZone = "Asia/Tehran";
  
 # environment.variables = {
 #   http_proxy = "http://192.168.211.134:10809";
 #   https_proxy = "http://192.168.211.134:10809";
 #   ftp_proxy = "http://192.168.211.134:10809";
 #  # no_proxy = "localhost,127.0.0.1,.example.com";
 # };

 # networking.proxy.default = "http://192.168.211.134:10809";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  networking = {
    hostName = "${user.host}";
    networkmanager.enable = true;
  };
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
    services = {
   # blueman.enable = true;
   # gnome.gnome-keyring.enable = true;
   # libinput.enable = true;
    udisks2.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

    programs = {
    #adb.enable = true;
    fish.enable = true;
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



  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

   virtual.enable = true;

  programs.nh = {
      enable = true;
      flake = "/home/${user.name}/nix-config";
      clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 3";
    };
  };

  services.openssh.enable = true;


   environment.systemPackages = with pkgs; [
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

  
  services.udev.packages = [ pkgs.libmtp pkgs.libinput ];
  services.gvfs.enable = true;


  services.libinput = {
    enable = true;  # Enable libinput for input devices
  };

services.xserver = {
  enable = true;
  xkb.layout = "us";  # Adjust to your preferred keyboard layout
 # xkbOptions = "ctrl:nocaps";  # Example for remapping Caps Lock to Control
};


  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};

security.polkit.enable = true;

# environment.sessionVariables = {
#  WLR_NO_HARDWARE_CURSORS = "1";
#  NIXOS_OZONE_WL = "1";
# };


services.displayManager.sddm = {
 enable = true;
 wayland.enable = true;
 package = pkgs.kdePackages.sddm;
};

nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";

}

