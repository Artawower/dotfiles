# Dotfiles — AI Agent Reference

Source: `~/.local/share/chezmoi/`
Target: `$HOME` (chezmoi apply deploys here)

## VCS Rules

- **Always `jj`**, never `git commit` or `git add`
- Before each atomic change: `jj log --no-graph -r @ --template 'description'`
- If current revision description **doesn't match** intent → `jj new -m "<description>"`
- If it **matches** (or is empty/WIP) → reuse `@`, set description: `jj desc -m "<description>"`
- **No empty commits** — every revision must have file changes
- Never push without user confirmation

## Edit workflow

1. `chezmoi edit <file>` — edit in source (`~/.local/share/chezmoi/`)
2. OR edit target (`~/.config/...`, `~/.pi/...`) then `chezmoi re-add <file>`
3. `chezmoi diff` — verify before apply
4. `chezmoi apply` — deploy to target
5. Commit in chezmoi source: `cd ~/.local/share/chezmoi && jj new -m "..."` etc.

## Source tree (chezmoi source → target)

```
dot_config/                          → ~/.config/
  xonsh/                               Shell — rc.xsh is entry point, sources all .xsh modules
  helix/                                Editor — config.toml, themes/, utils/, languages.toml
  helix/                                Editor
    config.toml                          Main config (HNEI keybindings, LSP roots)
    languages.toml                       Language-specific settings
    themes/                              catppuccin + custom themes
    utils/                               blame, git-hunk scripts
    theme_switcher.sh                    Auto dark/light theme
  emacs/                                Editor — literate config (README.org → init.el), templates/, elpaca.lock
  ghostty/config                        Terminal
  zellij/config.kdl                     Multiplexer
  starship.toml                         Prompt
  git/config + ignore                   Git
  jj/config.toml                        Jujutsu (signing, aliases, max-new-file-size)
  mise.toml                             Runtimes + global npm packages via "npm:" prefix
  Justfile                              Setup recipes (init-linux, init-mac, mise, uv, cargo, go)
  scripts/                              jj-bisect, layout-presets
  nix/ + nix-linux/ + home-manager/     Nix configs
  wallboy/config.toml                   Wallpaper
  wezterm/wezterm.lua                   Alt terminal
  rassumfrassum/                        Lint helpers

  Linux-only:
    niri/                                Compositor
    xremap/config.yml                    Keyboard remap (Colemak)
    hypr/hyprland.conf                   Alt compositor
    cava/                                Audio visualizer
    noctalia/                            Desktop shell
    vicinae/                             Desktop utils
    systemd/user/                        User services

  macOS-only:
    skhd/skhdrc                          Hotkey daemon
    aerospace/aerospace.toml             Tiling WM
    karabiner/karabiner.json             Keyboard remap
    sketchybar/                          Bar
    yabai/                               Tiling WM
    launchagents/                        System services

  AI tools:
    opencode/                            OpenCode AI — config, agents, plugin
    eca/                                  ECA AI — config, agents, commands (from shared prompts), rules

dot_pi/                              → ~/.pi/
  agent/
    agents/                            Agent definitions
    mcp.json                           MCP servers
    AGENTS.md                          Agent instructions
    settings.json                      ← SYMLINK to ~/.config/.pi/agent/settings.json — DO NOT chezmoi-edit
    prompts/                           From shared prompts (with YAML frontmatter)
  docs/                                Pi docs
  themes/                              Pi themes

dot_agents/                          → ~/.agents/
  skills/                              Pi skills
  AGENTS.md                            Skills registry

.chezmoiexternal/prompt/             Shared prompts (single source of truth for pi/opencode/eca)
run_always_sync-prompts.sh           Copies prompts → pi (w/ frontmatter), opencode/eca (w/o frontmatter)
```

## Key behaviors

- **pi settings.json** — symlink to git repo. Pi writes here. DO NOT chezmoi-edit or template.
- **Shared prompts** — edit in `.chezmoiexternal/prompt/`, `chezmoi apply` syncs to all 3 tools
- **Colemak HNEI** — `h`=left, `n`=down, `e`=up, `i`=right. Spread across xonsh, helix, xremap, karabiner, niri.
- **mise** — manages runtimes + global packages. All declarative in mise.toml.
