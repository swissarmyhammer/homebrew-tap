cask "kanban" do
  version "0.17.0"
  sha256 "ddfb274eaf26c8a3728e4bc7f0402d20dd81ebff4bd86dddf1b7b7a2219d25af"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.17.0/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
