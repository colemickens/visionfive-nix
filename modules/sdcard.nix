{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # ../../profiles/base.nix
    "${modulesPath}/installer/sd-card/sd-image.nix"
  ];

  sdImage = {
    imageName = "${config.sdImage.imageBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}-visionfive.img";

    # We have to use custom boot firmware since we do not support
    # StarFive's Fedora MMC partition layout. Thus, we include this in
    # the image's firmware partition so the user can flash the custom firmware.
    
    # TODO: we really /shouldn't/ need to do this because of matthew's
    # awesome u-boot flashing work
    populateFirmwareCommands = ''
    '';

    populateRootCommands = ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';
  };
}
