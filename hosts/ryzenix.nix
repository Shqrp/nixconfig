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

  fileSystems."/home/shqrp/Vienna" = {
    device = "/dev/disk/by-uuid/98B6-27DB";
    fsType = "exfat";
    options = [
      "uid=1000"
      "gid=100"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/086424cb-de28-4691-9e9f-d6e7e7f36627"; } ];

  networking.useDHCP = lib.mkDefault true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "580.95.05";
        sha256_64bit = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
        openSha256 = "sha256-RFwDGQOi9jVngVONCOB5m/IYKZIeGEle7h0+0yGnBEI=";
        settingsSha256 = "sha256-F2wmUEaRrpR1Vz0TQSwVK4Fv13f3J9NJLtBe4UP2f14=";
        persistencedSha256 = "sha256-QCwxXQfG/Pa7jSTBB0xD3lsIofcerAWWAHKvWjWGQtg=";
      };
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
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
