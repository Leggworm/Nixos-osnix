{inputs, pkgs, ...}: {
  programs.command-not-found.enable = true;
  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.ssh = {
    askPassword = "";
    startAgent = true;
    extraConfig = ''
      Host *
        ServerAliveInterval 20
        ServerAliveCountMax 5
    '';
  };

  environment.defaultPackages = with pkgs; [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
    strace
    nix-tree
    direnv
    bat
    cachix
    ccze
    file
    fzf
    git
    delta
    jq
    lnav
    mkpasswd
    ripgrep
    sd
    tealdeer
    translate-shell
    procs
    zellij

    iw
    nmap
    tcpdump

    gotop
    bottom
    inxi
    hwinfo
    inetutils
    iotop
    lm_sensors
    lshw
    lsof
    fastfetch
    pciutils
    smartmontools
    usbutils

    cryptsetup
    pwgen

    yazi
    atool
    bind
    dosfstools
    eza
    exfat
    fd
    ffsend
    gptfdisk
    mtools
    ncdu
    ntfs3g
    parted
    rsync
    sshfs
    sshfs-fuse
    unar
    unzip
    p7zip
    viu
    zip
    zoxide
    termusic
  ];
}
