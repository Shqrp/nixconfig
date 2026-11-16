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
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    "${inputs.nixos-hardware}/common/wifi/mediatek/mt7925"
    "${inputs.nixos-hardware}/common/wifi/mediatek/mt7925/iwd.nix"
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

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

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
  networking.networkmanager.unmanaged = [ "lo" "tailscale0" "docker0" ];
  systemd.services.iwd = {
    after = [ "sys-subsystem-net-devices-wlan0.device" ];
    wants = [ "sys-subsystem-net-devices-wlan0.device" ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.initrd.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
