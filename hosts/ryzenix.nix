{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7a3feef4-328d-4c8f-a5d9-ed336af0c770";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1778-D488";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/201313a4-c9a5-4cb2-89c5-bd6f22780542"; } ];

  networking.useDHCP = lib.mkDefault true;

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c20", SYMLINK+="h100i", TAG+="systemd"
    '';
  };

  systemd.services.liquidctl = {
    enable = true;
    description = "liquidctl, an AIO management tool";
    wantedBy = [ "multi-user.target" ];
    requires = [ "dev-h100i.device" ];
    after = [ "dev-h100i.device" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.liquidctl}/bin/liquidctl initialize --pump-mode balanced"
        "${pkgs.liquidctl}/bin/liquidctl --match hydro set fan speed 20 20 30 40 40 70 50 90 60 100"
      ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
