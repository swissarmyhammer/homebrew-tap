# SwissArmyHammer Homebrew Tap

Homebrew formulae for SwissArmyHammer tools. Requires macOS on Apple Silicon (ARM64) or Linux.

## Formulae

| Formula | Description |
|---------|-------------|
| `swissarmyhammer-cli` | Command-line interface for SwissArmyHammer prompt management |
| `avp-cli` | Agent Validator Protocol - Claude Code hook processor CLI |
| `code-context-cli` | Standalone MCP code-context tool CLI for AI coding agents |
| `kanban` | Git-native task board for humans and AI coding agents |
| `mirdan` | Mirdan CLI - Command-line interface for the Mirdan package manager |

## Casks (macOS)

| Cask | Description |
|------|-------------|
| `kanban` | Kanban desktop app |
| `mirdan` | Mirdan tray app |

## Installation

```bash
brew tap swissarmyhammer/tap
brew install swissarmyhammer-cli
brew install avp-cli
brew install code-context-cli
brew install kanban
brew install mirdan
brew install --cask kanban   # desktop app
```

## CI

GitHub Actions runs style checks, an install, and a `--version` smoke test for each formula on macOS and Linux. A nightly run checks that all release URLs still resolve.
