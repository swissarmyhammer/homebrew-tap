# SwissArmyHammer Homebrew Tap

Homebrew formulae for SwissArmyHammer tools. Requires macOS on Apple Silicon (ARM64).

## Formulae

| Formula | Description |
|---------|-------------|
| `swissarmyhammer-cli` | Command-line interface for SwissArmyHammer prompt management |
| `avp-cli` | Agent Validator Protocol - Claude Code hook processor CLI |

## Installation

```bash
brew tap swissarmyhammer/tap
brew install swissarmyhammer-cli
brew install avp-cli
```

Or install directly:

```bash
brew install swissarmyhammer/tap/swissarmyhammer-cli
brew install swissarmyhammer/tap/avp-cli
```

## Brewfile

```ruby
tap "swissarmyhammer/tap"
brew "swissarmyhammer-cli"
brew "avp-cli"
```
