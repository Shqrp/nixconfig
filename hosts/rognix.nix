{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/99acd982-0710-407c-a676-eaf0e2625483";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0E56-013C";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  hardware = {
    graphics = {
      enable = true;
      # driSupport = true;
      # driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = false;
      open = false;
      gsp.enable = false;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "550.107.02";
      #   sha256_64bit = "sha256-+XwcpN8wYCjYjHrtYx+oBhtVxXxMI02FO1ddjM5sAWg=";
      #   sha256_aarch64 = "sha256-mVEeFWHOFyhl3TGx1xy5EhnIS/nRMooQ3+LdyGe69TQ=";
      #   openSha256 = "sha256-Po+pASZdBaNDeu5h8sgYgP9YyFAm9ywf/8iyyAaLm+w=";
      #   settingsSha256 = "sha256-WFZhQZB6zL9d5MUChl2kCKQ1q9SgD0JlP4CMXEwp2jE=";
      #   persistencedSha256 = "sha256-Vz33gNYapQ4++hMqH3zBB4MyjxLxwasvLzUJsCcyY4k=";
      # };
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
	      version = "570.181";
        sha256_64bit = "sha256-8G0lzj8YAupQetpLXcRrPCyLOFA9tvaPPvAWurjj3Pk=";
        settingsSha256 = "sha256-U/uqAhf83W/mns/7b2cU26B7JRMoBfQ3V6HiYEI5J48=";
        persistencedSha256 = "sha256-RoAcutBf5dTKdAfkxDPtMsktFVQt5uPIPtkAkboQwcQ=";
      };
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  services.thermald.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
