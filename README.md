# SwissArmyHammer Homebrew Tap

Homebrew formulae for SwissArmyHammer tools. Requires macOS on Apple Silicon (ARM64).

## Formulae

| Formula | Description |
|---------|-------------|
| `swissarmyhammer-cli` | Command-line interface for SwissArmyHammer prompt management |
| `avp-cli` | Agent Validator Protocol - Claude Code hook processor CLI |
| `kanban-app` | Tauri desktop app for SwissArmyHammer Kanban board |
| `mirdan` | Mirdan CLI - Command-line interface for the Mirdan package manager |
| `mirdan-app` | Mirdan tray app - Universal package manager for AI coding agents |

## Installation

```bash
brew tap swissarmyhammer/tap
brew install swissarmyhammer-cli
brew install avp-cli
brew install kanban-app
brew install mirdan
brew install mirdan-app
```

Or install directly:

```bash
brew install swissarmyhammer/tap/swissarmyhammer-cli
brew install swissarmyhammer/tap/avp-cli
brew install swissarmyhammer/tap/kanban-app
brew install swissarmyhammer/tap/mirdan
brew install swissarmyhammer/tap/mirdan-app
```

## Brewfile

```ruby
tap "swissarmyhammer/tap"
brew "swissarmyhammer-cli"
brew "avp-cli"
brew "kanban-app"
brew "mirdan"
brew "mirdan-app"
```
