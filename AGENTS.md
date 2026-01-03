# Agent Guide for dotfiles.work

This document provides guidelines for AI coding agents working in this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environments, focusing on:

- Shell configuration (Fish shell)
- Development tool setup (Go, Node.js, Python, Rust)
- Git configuration and workflows
- Container environment (Docker via Colima)
- Editor configuration (Helix, Ghostty terminal)

## Build/Test/Lint Commands

### Setup Commands

```bash
# Install Homebrew packages
sh brew.sh

# Configure macOS system preferences
sh darwin.sh

# Sync dotfiles to home directory
sh bootstrap.sh

# Install language runtimes (Node.js, Python, Rust)
sh mise.sh
```

### Linting & Formatting

This repository doesn't have project-specific linters, but the following tools are available:

```bash
# Go code
gofumpt -l -w .                    # Format Go files (stricter than gofmt)
goimports -w .                     # Organize Go imports
golangci-lint run                  # Run Go linters

# Shell scripts
shfmt -w -i 2 -ci **/*.sh         # Format shell scripts

# Dockerfiles
hadolint Dockerfile                # Lint Dockerfiles

# Lua files
stylua .                           # Format Lua files
```

### No Traditional Testing

This repository contains configuration files rather than code, so there are no test commands.

## Git Workflow

### Commit Message Format

**MUST follow Conventional Commits specification:**

```
<type>: <description>

[optional body]

[optional footer(s)]
```

**Types:**

- `fix:` - Bug fixes (PATCH version)
- `feat:` - New features (MINOR version)
- `build:` - Build system changes
- `chore:` - Maintenance tasks
- `ci:` - CI/CD changes
- `docs:` - Documentation
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `perf:` - Performance improvements
- `test:` - Test additions/modifications

**Breaking Changes:**

- Add `BREAKING CHANGE:` in footer, or append `!` after type
- Example: `feat!: change default shell to fish`

Reference: <https://www.conventionalcommits.org/en/v1.0.0/>

### Git Configuration

- **Default branch:** `main`
- **Merge strategy:** No fast-forward (`merge.ff = false`)
- **Pull strategy:** Fast-forward only (`pull.ff = only`)
- **Auto-prune:** Enabled (`fetch.prune = true`)
- **GPG signing:** Disabled
- **Commit template:** `~/.gitmessage`
- **Diff viewer:** `delta` (syntax-highlighted diffs)
- **Editor:** `helix` (hx)

### Git Commit Guidelines (from CLAUDE.md)

- **DO NOT** include Claude as a co-author
- **DO NOT** add "Co-Authored-By: Claude <noreply@anthropic.com>"
- **DO NOT** add "🤖 Generated with Claude Code" or similar markers
- Keep commit messages clean and focused on the changes

### Common Git Aliases

```bash
git st          # status -sb
git cm          # commit
git cmm         # commit -m
git sw          # switch
git br          # branch
git ps          # push
git pf          # push --force-with-lease
git pu          # pull
git graph       # pretty log with graph
```

## Code Style Guidelines

### Shell Scripts (Fish/Bash)

- **Indentation:** 2 spaces (use `shfmt -i 2`)
- **Line continuations:** Indent continuation lines (`shfmt -ci`)
- **Functions:** Use descriptive names (e.g., `gclean`, `dkclean`, `peco-ghq`)
- **Variables:** Use Fish's `set -l` for local variables, `set -x` for exports
- **Error handling:** Check command success with `if test`

### Go Code

- **Formatter:** Use `gofumpt` (stricter than `gofmt`)
- **Imports:** Organize with `goimports`
- **Linter:** Run `golangci-lint` before committing
- **Test structure (from CLAUDE.md):**
  - All tests must be categorized under "succeeds" or "fails" subtests
  - "succeeds": Tests where no error is expected
  - "fails": Tests where an error is expected
  - Use table-driven tests for maintainability (unless it compromises simplicity)

### Configuration Files

- **YAML/TOML:** 2-space indentation
- **JSON:** 2-space indentation
- **Shell scripts:** Follow `shfmt` formatting standards

### Naming Conventions

- **Files:** Use lowercase with hyphens (e.g., `bootstrap.sh`, `darwin.sh`)
- **Functions:** Use lowercase with underscores (e.g., `gclean`, `dkprune`)
- **Variables:** Use lowercase with underscores for shell scripts

## File Structure

```
.
├── .config/                 # Application configurations
│   ├── fish/               # Fish shell config
│   │   ├── config.fish     # Main Fish configuration
│   │   └── completions/    # Custom completions
│   └── ghostty/            # Terminal emulator config
├── home/                    # Files to sync to ~/
│   ├── .gitconfig          # Git configuration
│   ├── .gitignore_global   # Global gitignore
│   └── .gitmessage         # Commit message template
├── bootstrap.sh             # Sync dotfiles to home
├── brew.sh                  # Install Homebrew packages
├── Brewfile                 # Homebrew package list
├── darwin.sh                # macOS system preferences
├── mise.sh                  # Install language runtimes
└── README.md               # Setup instructions
```

## Important Notes for Agents

### What to Ignore

- `.DS_Store`, `.AppleDouble`, `.LSOverride` (macOS artifacts)
- `.idea/` (JetBrains IDEs)
- `.vscode/` (VS Code settings)
- `.envrc` (direnv configuration)
- `.claude`, `CLAUDE.md` (Claude AI files)

### Development Tools Installed

- **Languages:** Go, Node.js (via pnpm), Python (via pipx), Rust, Lua, Deno
- **Version manager:** `mise` (successor to asdf)
- **Containers:** Docker, Docker Compose, Colima, OrbStack
- **Infrastructure:** Terraform, AWS CLI, AWS SAM CLI, Protocol Buffers
- **Editors:** Helix (primary), Vim, VS Code, Zed
- **Repository management:** `ghq` (root: `~/repo/`)

### Fish Shell Functions

- `gclean` - Delete git branches marked as "gone"
- `dkclean` - Remove all Docker containers
- `dkclean-all` - Stop and remove all containers
- `dkprune` - Prune Docker resources
- `peco-ghq` - Fuzzy find repositories (Ctrl+G)
- `peco-history-selection` - Search command history (Ctrl+H)

### Aliases

- `g` → `git`
- `d` → `docker`
- `dc` → `docker compose`
- `av` → `aws-vault`
- `ave` → `aws-vault exec`
- `avl` → `aws-vault login`

## Common Tasks

### Adding New Homebrew Packages

1. Edit `Brewfile`
2. Run `brew bundle install --file=Brewfile`
3. Commit with: `chore: add <package-name> to Brewfile`

### Updating Fish Configuration

1. Edit `.config/fish/config.fish`
2. Test in new shell: `fish`
3. Commit with: `feat: add <feature> to fish config`

### Adding Git Aliases

1. Edit `home/.gitconfig` under `[alias]` section
2. Sync with: `sh bootstrap.sh`
3. Commit with: `feat: add git alias for <command>`

### Modifying Setup Scripts

1. Edit `bootstrap.sh`, `darwin.sh`, or `mise.sh`
2. Test the script in a safe environment
3. Document changes in commit message
4. Commit with appropriate type (usually `feat:` or `fix:`)
