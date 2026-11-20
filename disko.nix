{
  disko.devices = {
    disk.main = {
      # Verify this path from the NixOS installer with `lsblk` before running
      # disko. This layout permanently erases the selected disk.
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
              extraArgs = ["-n" "boot"];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              extraArgs = ["-L" "nixos"];
            };
          };
        };
      };
    };
  };
}
