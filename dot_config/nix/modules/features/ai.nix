{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.conf.features.ai;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.brews = lib.optionals isDarwin [

    ];

    conf.packages.nix = lib.optionals (!isDarwin) (
      with pkgs;
      [

      ]
    );

  };
}
