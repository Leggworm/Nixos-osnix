{lib, pkgs, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      backgroundColor = "#21202D";
      configurationLimit = lib.mkDefault 10;
      splashMode = lib.mkDefault "normal";
      splashImage = lib.mkDefault null;
    };
  };

  boot.kernelModules = ["tcp_bbr"];
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  nix = {
    package = pkgs.nixVersions.stable;
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 7;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      connect-timeout = 20;
      stalled-download-timeout = 20;
      fallback = true;
    };
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Moscow";
  location = {
    latitude = lib.mkDefault 55.75;
    longitude = lib.mkDefault 37.61;
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = ["Source Code Pro"];
        sansSerif = ["Roboto"];
        serif = ["Roboto Slab"];
      };
    };
    packages = with pkgs; [
      terminus_font
      source-sans-pro
      roboto
      cozette
      nerd-fonts.fira-code
      nerd-fonts.blex-mono
      nerd-fonts.caskaydia-mono
      siji
      ipafont
      noto-fonts-color-emoji
      source-code-pro
    ];
  };

  environment.systemPackages = with pkgs; [font-manager];
  services.journald.extraConfig = "SystemMaxUse=500M";
  documentation.enable = false;
  documentation.man.cache.enable = false;
}
