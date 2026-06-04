cask "kanban" do
  version "0.14.0"
  sha256 "fd9117b8e4d60a465d6c2759fcae4e1a06ca62e84f431eeb1019eef57c75a1e2"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.14.0/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
