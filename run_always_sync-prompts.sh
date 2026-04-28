#!/usr/bin/env bash
# Syncs shared prompts to pi/opencode/eca, stripping YAML frontmatter for opencode/eca
set -euo pipefail

CHEZMOI_SRC="$HOME/.local/share/chezmoi"
PROMPTS_DIR="$CHEZMOI_SRC/.chezmoiexternal/prompt"

strip_frontmatter() {
  # Remove YAML frontmatter (--- ... ---) from file
  sed '/^---$/,/^---$/d' "$1"
}

# === PI: keep frontmatter ===
PI_DIR="$HOME/.pi/agent/prompts"
mkdir -p "$PI_DIR"
for f in "$PROMPTS_DIR"/*.md; do
  name=$(basename "$f")
  cp "$f" "$PI_DIR/$name"
done
echo "✅ pi prompts synced"

# === OPENCODE: strip frontmatter ===
OC_DIR="$HOME/.config/opencode/command"
mkdir -p "$OC_DIR"
for f in "$PROMPTS_DIR"/*.md; do
  name=$(basename "$f")
  strip_frontmatter "$f" > "$OC_DIR/$name"
done
echo "✅ opencode commands synced"

# === ECA: strip frontmatter ===
ECA_DIR="$HOME/.config/eca/commands"
mkdir -p "$ECA_DIR"
for f in "$PROMPTS_DIR"/*.md; do
  name=$(basename "$f")
  strip_frontmatter "$f" > "$ECA_DIR/$name"
done
echo "✅ eca commands synced"
