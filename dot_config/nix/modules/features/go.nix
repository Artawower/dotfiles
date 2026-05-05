{ config, lib, pkgs, ... }:

let
  cfg      = config.conf.features.go;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = lib.optionals (!isDarwin) (with pkgs; [
      go
    ]);

    conf.packages.brews = lib.optionals isDarwin [
      "go"
      "gopls"
    ];
  };
}
