{ config, lib, pkgs, ... }:

let
  cfg      = config.conf.features.keyboard;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.casks = lib.optionals isDarwin [
      "karabiner-elements"
    ];

    conf.packages.nix = lib.optionals (!isDarwin) (with pkgs; [
      xremap
    ]);
  };
}
