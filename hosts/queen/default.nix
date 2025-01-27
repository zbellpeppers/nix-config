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
    ../../system
    ../../desktop
    ../../user
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.sarah = import ../../home-manager;
      home-manager.backupFileExtension = "backup";
    }
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "uas" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/66851046-b19f-4d83-828a-e523b927b3c9";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5819-AC61";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/b64bc7e5-5609-4031-b009-b707186c8afc";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0u5.useDHCP = lib.mkDefault true;

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
    # Monitor Brightness Control
    i2c.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };
  };
}
