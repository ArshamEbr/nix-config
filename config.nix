{ config, lib, pkgs, user, ... }:

{
  imports =
    [
      ./nixosModules
    ];

nix.settings.experimental-features = [ "nix-command" "flakes" ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  time.timeZone = "Asia/Tehran";

  # Configure network proxy if necessary
# networking.proxy.default = "http://192.168.226.124:10809";
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

   users.users.${user.name} = {
     isNormalUser = true;
     extraGroups = [ "wheel" "NetworkManager" "plugdev" "NetworkManager" ];
   };

   virtual.enable = true;

  programs.nh = {
      enable = true;
      flake = "/home/${user.name}/nix-config";
 #    flake = "/home/nix-config";
      clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 3";
    };
  };

   environment.systemPackages = with pkgs; [
     #vim
     wget
     neofetch
     git
     curl
#    dolphin
#    qt5-imageformats
     networkmanager
     ffmpegthumbs
     kde-cli-tools
#    swaylock-effects-git
#    polkit-kde-agent
     sbctl
     p7zip
     btop
     lshw
     rustc
     cmake
     gnumake
     gcc
     freetype
     wayland
     ninja
     binutils
     libiberty
     libmtp
     mtpfs
     gvfs
     android-file-transfer
     glib
     jmtpfs
     go-mtpfs
     xorg.xf86inputevdev
     xorg.xinput
     libinput
     gcc
     cmake
     ninja
     SDL2.dev
     xorg.libX11
     xorg.libXrandr
     xorg.libXi
     xorg.libXcursor
     freetype
     mesa
     pkg-config
     libGLU
     SDL2_ttf
     fontconfig
     gmp
     spice-protocol
     nettle
     harfbuzz
     xorg.libXdmcp
     glib
     pcre
     pcre2
     expat
     wayland
     wayland-protocols
     binutils
     libiberty
     libbfd
     libxkbcommon
     xscreensaver
     xorg.libXScrnSaver
     xorg.libXinerama
     xorg.libXpresent
     pipewire
     pulseaudio
     libsamplerate
     wayland-scanner
    # wayland-egl
    # waylandProtocols
      ];

  
  services.udev.packages = [ pkgs.libmtp pkgs.libinput ];
  services.gvfs.enable = true;


services.xserver = {
  enable = true;
  layout = "us";  # Adjust to your preferred keyboard layout
 # xkbOptions = "ctrl:nocaps";  # Example for remapping Caps Lock to Control

  libinput = {
    enable = true;  # Enable libinput for input devices
  };
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

 # Set HTTP and HTTPS proxies
# environment.variables = {
#   http_proxy = "http://192.168.152.148:10809";
#   https_proxy = "http://192.168.152.148:10809";
#  # no_proxy = "localhost,127.0.0.1,.example.com";  # Optional
# };


# environment.variables = {
#   CURL_PROXY = "http://192.168.152.148:10809";
# };

  # Create a wrapper script for curl
# system.activationScripts.curlProxy = {
#   text = ''
#     export http_proxy="$CURL_PROXY"
#     export https_proxy="$CURL_PROXY"
#   '';
# };

  system.stateVersion = "24.05";

}

