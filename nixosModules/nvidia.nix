{ config, lib, pkgs, user, ... }:

{

hardware.graphics = { enable = true; };

####NVIDIA ENABLE#####

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  powerManagement.finegrained = true;
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

	hardware.nvidia.prime = {
		offload = {
			enable = true;
			enableOffloadCmd = true;
    };
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
	};


  # nvidia minor fixes:    
  
# boot.initrd.kernelModules = [ "nvidia" ];
# boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
# hardware.nvidia.forceFullCompositionPipeline = true;

# services.xserver.enable = true;

####NVIDIA DISABLE#####

# boot.extraModprobeConfig = ''
#   blacklist nouveau
#   options nouveau modeset=0
# ''; 
# services.udev.extraRules = ''
#   # Remove NVIDIA USB xHCI Host Controller devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA USB Type-C UCSI devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA Audio devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA VGA/3D controller devices
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
# '';
# boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

}