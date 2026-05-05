{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.conf.features.frontend;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.brews = lib.optionals isDarwin [
      "lua-language-server"
      "google-java-format"
      "staticcheck"
    ];

    conf.packages.nix = lib.optionals (!isDarwin) (
      with pkgs;
      [
        lua-language-server
      ]
    );
  };
}
