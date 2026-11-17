{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ../modules/hardware-configuration.nix
    ../modules/system.nix
    ../modules/tty.nix
    ../modules/common-packages.nix
    ../modules/desktop.nix
    ../modules/wayland-common.nix
    ../modules/pipewire.nix
    ../modules/auto-mount.nix
    ../modules/games.nix
    ../modules/postgresql.nix
    ../modules/firewall-desktop.nix
    ../modules/services.nix
    ../modules/user.nix
    ../modules/root.nix
  ];

  networking.hostName = "leggrowm-mini";
  networking.networkmanager.enable = true;
  nix.settings.max-jobs = 2;

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    bat
    brightnessctl
    btop
    cachix
    delta
    eza
    fd
    file
    fastfetch
    firefox
    fzf
    gparted
    git
    gopass
    htop
    imv
    jq
    libnotify
    mpv
    neovim
    networkmanagerapplet
    nix-tree
    pavucontrol
    pciutils
    ripgrep
    rofi
    rsync
    tealdeer
    throne
    unzip
    usbutils
    vlc
    wget
    wl-clipboard
    yazi
    yt-dlp
    zellij
    zoxide

    discord-canary
    nodejs

    pkgs-unstable.alejandra
    pkgs-unstable.opencode
    pkgs-unstable.pi-coding-agent
  ];

  programs.fish.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-rofi;
  };

  hardware.wirelessRegulatoryDatabase = true;

  boot.loader.grub.splashImage = ../assets/wallpapers/akira.png;
  boot.loader.grub.splashMode = "stretch";
  boot.loader.grub.configurationLimit = 3;
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  # Throne is a user application. Connection profiles and credentials are kept
  # in its per-user data directory and must not be committed to this repository.
  # No NixOS-wide HTTP(S) proxy is configured.

  system.stateVersion = "25.05";
}
