{ config, lib, pkgs, user, ... }:

{
  options.virtual.enable = lib.mkEnableOption "enables virtualisation";
  config = lib.mkIf config.virtual.enable {

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
      	package = pkgs.qemu_kvm;
      	swtpm.enable = true;
      	ovmf.enable = true;
      	ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    boot.kernelParams = [
    # "split_lock_detect=off"
    #  "i915.max_vfs=7"
    #  "i915.force_probe=7d55"
      "intel_iommu=on"
      "iommu=pt"
      #"vfio-pci.ids=10de:1c94"
      #"vfio-pci.ids=8086:9a49"
      ];
      
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
    };

      # SR-IOV Module
 # boot.extraModulePackages = with pkgs; [ intel-gfx-sriov ];
    

    boot.blacklistedKernelModules = [ "nouveau" ];

    virtualisation.spiceUSBRedirection.enable = true;
    users.users.${user.name}.extraGroups = [ "libvirtd" ];
    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-boxes
      spice
      spice-gtk
      spice-protocol
      usbutils
      virt-manager
      virt-viewer
#     virtio-win
      win-spice
    ];


    virtualisation.kvmgt.enable = true;
    boot.extraModprobeConfig = "options i915 enable_guc=2";

    home-manager.users.${user.name}.dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

  };
}
