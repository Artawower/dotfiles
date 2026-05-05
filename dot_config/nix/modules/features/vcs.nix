{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.conf.features.vcs;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix =
      with pkgs;
      [
        git
        gh
      ]
      ++ lib.optionals (!isDarwin) [
        jujutsu
        delta
      ];

    conf.packages.brews = lib.optionals isDarwin [
      "jj"
      "git-delta"
      "pinentry-mac"
    ];
  };
}
