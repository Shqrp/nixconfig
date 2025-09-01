{
  config,
  lib,
  modulesPath,
  inputs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [
    "acpi_backlight=native"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5bde3ebc-d13c-4dd8-ab0b-a8ac225cd02a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/668C-5E92";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/ca9d3cdc-40ec-4f3b-8c98-63c97e608531"; }
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];
  services.fprintd.enable = true;

  networking.useDHCP = lib.mkDefault true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.initrd.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
