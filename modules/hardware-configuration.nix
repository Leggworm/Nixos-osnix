{lib, ...}: {
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = ["umask=0077"];
  };

  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.amdgpu.initrd.enable = true;

  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "0.3";
      disableWhileTyping = true;
      naturalScrolling = false;
      scrollMethod = "twofinger";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.ratbagd.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  services.fstrim.enable = true;
}
