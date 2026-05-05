{ config, lib, ... }:

{
  homebrew = {
    enable = true;
    brews  = lib.unique config.conf.packages.brews;
    casks  = lib.unique config.conf.packages.casks;
    onActivation = {
      autoUpdate = true;
      cleanup    = "uninstall";
      upgrade    = true;
    };
  };
}
