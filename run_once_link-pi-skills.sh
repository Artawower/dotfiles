#!/bin/bash
# Symlink pi skills dir to shared agents skills (chezmoi-managed)
mkdir -p "$HOME/.pi/agent"
ln -sf "$HOME/.agents/skills" "$HOME/.pi/agent/skills"
