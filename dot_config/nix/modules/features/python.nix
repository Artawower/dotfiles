{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.conf.features.python;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = with pkgs; [ uv ];

    conf.packages.brews = lib.optionals isDarwin [
      "python"
    ];

    conf.packages.nix = lib.optionals (!isDarwin) (
      with pkgs;
      [
        python3
      ]
    );
  };
}
