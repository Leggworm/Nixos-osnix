{lib, pkgs, modulesPath, installedSystem, configurationSource, diskLayout, diskTools, ...}: let
  partitionDisk = diskTools._cliDestroyFormatMount diskLayout pkgs;
  installSystem = pkgs.writeShellApplication {
    name = "install-leggrowm";
    runtimeInputs = with pkgs; [coreutils util-linux jq];
    text = ''
      readonly expected_model='SK hynix HFM512GDHTNI-87A0B'
      readonly target_disk=${lib.escapeShellArg diskLayout.disko.devices.disk.main.device}
      readonly partition_script=${lib.getExe partitionDisk}
      readonly installed_system=${installedSystem}
      readonly configuration_source=${configurationSource}
    '' + builtins.readFile ./install.sh;
  };
in {
  imports = [(modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")];
  image.baseName = lib.mkForce "leggrowm-mini-installer";
  isoImage.storeContents = [installedSystem];
  isoImage.squashfsCompression = "zstd -Xcompression-level 6";
  environment.systemPackages = [installSystem];
  services.getty.helpLine = lib.mkForce "Offline installation for leggrowm-mini: run install-leggrowm";
}
