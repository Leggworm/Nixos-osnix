{lib, ...}: {
  # As in baton: start sshd manually with `sudo systemctl start sshd`.
  systemd.services.sshd.wantedBy = lib.mkForce [];

  services.openssh = {
    enable = true;
    extraConfig = ''
      permitRootLogin = no
    '';
  };

  services.avahi = {
    enable = true;
    ipv6 = false;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      userServices = true;
      workstation = true;
    };
  };

}
