final: prev: {
        kernelPXP = prev.pkgs.linuxPackagesFor (prev.pkgs.linux.override {
          extraConfig = ''
            DRM_I915_PXP y
            INTEL_MEI_PXP m
          '';
        });
}
