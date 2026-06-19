cask "kanban" do
  version "0.15.1"
  sha256 "3c787d5f34c05b473dc28f9da5bdb3e8e8a77e9db8ee5ba18e663eafe2de1a6f"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
