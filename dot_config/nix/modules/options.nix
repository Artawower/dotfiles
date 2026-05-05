{ lib, ... }:

{
  options.conf = {
    layout = lib.mkOption {
      type    = lib.types.enum [ "qwerty" "colemak" ];
      default = "qwerty";
    };

    features = lib.mapAttrs (_: lib.mkEnableOption) {
      core     = "core CLI tools";
      vcs      = "version control tooling";
      terminal = "terminal, TUI tools, and shell";
      emacs    = "Emacs editor";
      keyboard = "keyboard layout tooling";
      frontend = "frontend development tooling";
      go       = "Go development tooling";
      python   = "Python development tooling";
      rust     = "Rust development tooling";
      ai       = "AI coding agents";
      tiling   = "tiling window manager";
    };

    packages = {
      nix = lib.mkOption {
        type    = lib.types.listOf lib.types.package;
        default = [];
      };
      brews = lib.mkOption {
        type    = lib.types.listOf lib.types.str;
        default = [];
      };
      casks = lib.mkOption {
        type    = lib.types.listOf lib.types.str;
        default = [];
      };
    };
  };
}
