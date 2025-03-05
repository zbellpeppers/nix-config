{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  flake,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "uas" "sd_mod"];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/169dd824-4dfb-4b8a-ae18-f18b9ad4a9ea";
    fsType = "btrfs";
    options = ["subvol=@"];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/169dd824-4dfb-4b8a-ae18-f18b9ad4a9ea";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=zstd"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/169dd824-4dfb-4b8a-ae18-f18b9ad4a9ea";
    fsType = "btrfs";
    options = ["subvol=@nix" "compress=zstd"];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/169dd824-4dfb-4b8a-ae18-f18b9ad4a9ea";
    fsType = "btrfs";
    options = ["subvol=@var" "compress=zstd"];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/169dd824-4dfb-4b8a-ae18-f18b9ad4a9ea";
    fsType = "btrfs";
    options = ["subvol=@tmp" "compress=zstd" "noatime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B0B5-30D9";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/988be623-6397-4431-8f0d-c9712f486761"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0u5.useDHCP = lib.mkDefault true;

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amdgpu = {
      opencl.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    # Monitor Brightness Control
    i2c.enable = true;
    # Enable bluetooth - Activate on boot
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    xone.enable = true; # support for the xbox controller USB dongle
  };
}
