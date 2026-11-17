{lib, pkgs, ...}: {
  users.defaultUserShell = pkgs.fish;
  users.users.leggrowm = {
    isNormalUser = true;
    description = "leggrowm";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "dialout"
      "docker"
      "jackaudio"
      "scanner"
      "lp"
    ];
  };

  systemd.tmpfiles.rules = lib.mkDefault [
    "d /home/leggrowm/code        0700 leggrowm 1000"
    "d /home/leggrowm/.secrets    0700 leggrowm 1000"
    "d /home/leggrowm/wallpapers  0700 leggrowm 1000"
    "d /home/leggrowm/screenshots 0700 leggrowm 1000"
    "d /home/leggrowm/documents   0700 leggrowm 1000"
    "d /home/leggrowm/downloads   0700 leggrowm 1000"
    "d /home/leggrowm/notes       0700 leggrowm 1000"
    "d /home/leggrowm/pics        0700 leggrowm 1000"
    "d /home/leggrowm/photos      0700 leggrowm 1000"
    "d /home/leggrowm/sshfs       0700 leggrowm 1000"
  ];

  age.identityPaths = lib.mkDefault [
    "/home/leggrowm/.ssh/id_ed25519"
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
    users.leggrowm = import ../home;
  };
}
