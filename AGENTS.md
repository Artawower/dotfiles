# Dotfiles — AI Agent Reference

This repository is a chezmoi source tree for personal dotfiles.

- Source: `~/.local/share/chezmoi/`
- Target: `$HOME` after `chezmoi apply`
- Main deployed config subtree: `dot_config/` → `~/.config/`
- Supported hosts:
  - macOS / Apple Silicon via `nix-darwin` + Home Manager
  - Fedora Asahi Linux via Home Manager + Fedora packages

Do not assume the current host is Linux-only. Check `uname -s`, `.chezmoidata.toml`, or the Nix host modules before adding platform-specific logic.

## Version control

- Use `jj` only. Never run `git add` or `git commit`.
- Before each atomic change, inspect the current revision:
  `jj log --no-graph -r @ --template 'description'`
- If the current revision is unrelated, create a new one:
  `jj new -m "<type(scope): summary>"`
- If the current revision matches the task, reuse it and update the description if needed:
  `jj desc -m "<type(scope): summary>"`
- No empty revisions. Every described revision should contain file changes.
- Keep revisions atomic; split mixed shell/editor/Nix/desktop changes before presenting work as done.
- Never push without explicit user confirmation.

## Edit workflow

Prefer changing chezmoi source files, not deployed targets.

1. Edit files under `~/.local/share/chezmoi/` directly, or use `chezmoi edit <target-file>`.
2. If you edit deployed files under `$HOME` / `~/.config`, run `chezmoi re-add <target-file>` afterwards.
3. Verify with `chezmoi diff`.
4. Run `chezmoi apply` only when deployment is intended or explicitly requested.
5. Preserve executable bits for files represented as `executable_*` in the source tree.

## Configuration model

- `.chezmoidata.toml` controls feature flags and keyboard layout. Do not hardcode enabled features when this file already provides them.
- `dot_config/Justfile` is the operational entry point:
  - `just init` bootstraps the current OS
  - `just update` updates OS, Nix/Home Manager, and toolchains
  - `just sync` runs update with flake re-add and mise version bumping
  - `just layout`, `just nix`, `just mise`, `just clean`, `just doctor` are focused helpers
- `dot_config/mise.toml.tmpl` owns language runtimes and global developer tools (`npm:`, `pipx:`, `cargo:`, `go:` entries).
- `dot_config/nix/` owns the current Nix flake, host modules, feature modules, Home Manager adapter, and nix-darwin integration.
- Fedora-only packages and services belong in guarded Linux recipes or Linux modules.
- macOS-only packages and services belong in Darwin modules or guarded Darwin recipes.

## Source tree map

```text
dot_config/                         → ~/.config/
  xonsh/                              Shell; rc.xsh sources modular *.xsh files
  helix/                              Primary terminal editor config, themes, LSP, layout keymaps
  nix/                                Nix flake, hosts, feature modules, Darwin/Linux adapters
  mise.toml.tmpl                      Runtime and global tool versions
  Justfile                            Setup, update, sync, cleanup, layout recipes
  scripts/                            Helper executables: jj-bisect, layout, mise-bump, layouts
  jj/, git/, jjui/, gitu/             VCS tooling configuration
  ghostty/, zellij/, yazi/, starship  Terminal/TUI configuration
  opencode/, eca/                     AI tooling configuration

  Linux desktop:
    niri/, xremap/, hypr/, noctalia/, vicinae/, systemd/, cava/

  macOS desktop:
    aerospace/, skhd/, private_karabiner/, sketchybar/, yabai/, launchagents/

dot_pi/                             → ~/.pi/
  agent/                              Pi agents, MCP config, prompts, settings
  docs/, themes/                      Pi docs/themes

dot_agents/                         → ~/.agents/
  skills/                             Pi skills

```

## Platform notes

### Fedora Asahi Linux

- Fedora provides kernel, Mesa/GPU stack, Hyprland-related system packages, Docker, Flatpak apps, and manual desktop dependencies.
- Home Manager provides user-level packages and shell/editor/tooling integration.
- `dot_config/xonsh/rc.xsh` unsets `LD_LIBRARY_PATH` on Linux after sourcing Home Manager session variables because Nix library paths can break Fedora system binaries.
- Use `sudo env -u LD_LIBRARY_PATH ...` for Fedora system package commands when needed.
- Linux desktop work should respect the current Niri-first setup while keeping existing Hypr/Noctalia files intact unless explicitly asked.
- Trackpad palm rejection is handled by `trackpad-is-too-damn-big` (`titdb`) through `manual-deps` and `systemd-services` recipes.

### macOS

- `dot_config/nix/darwin.nix` and `dot_config/nix/modules/darwin.nix` own nix-darwin and Homebrew integration.
- Home Manager host config is `dot_config/nix/hosts/macbook.nix`.
- Window-management configs are split between Aerospace, skhd, Karabiner, SketchyBar, and legacy Yabai files.
- Do not add Linux-only assumptions to shared shell, editor, or mise config without guards.

## Keyboard and editor conventions

- The active layout is controlled by `.chezmoidata.toml` and `just layout`.
- Colemak HNEI navigation means: `h` left, `n` down, `e` up, `i` right.
- Layout-sensitive bindings are split where possible:
  - Helix: `dot_config/helix/keys-colemak.toml`, `keys-qwerty.toml`, selection keymaps
  - xonsh: `dot_config/xonsh/keybindings_colemak.xsh`, `keybindings_qwerty.xsh`
  - desktop: xremap, Karabiner, Niri, and skhd configs
- Helix is the primary terminal editor configuration in this repository. Do not add Neovim-specific instructions unless a Neovim config is reintroduced.

## AI tooling notes

- Pi-specific configuration lives under `dot_pi/`, not under `dot_config/`.

## Safety rules

- Keep OS-specific commands behind `case "$(uname -s)"` guards or platform-specific modules.
- Do not edit generated caches, deployed symlinks, or lock files unless the task explicitly targets them.
- Do not put secrets into templates. Use chezmoi private/encrypted mechanisms for sensitive files.
- Prefer small focused helpers in `dot_config/scripts/` over large inline scripts in `Justfile` when logic grows.
- Avoid broad cleanups that mix unrelated shell, editor, Nix, AI, and desktop changes in one revision.
