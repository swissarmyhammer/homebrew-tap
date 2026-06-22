cask "kanban" do
  version "0.16.0"
  sha256 "1715a44013754d8497058122e6523802f1fa8fe355c2e06ac969b1564b43b540"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.16.0/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
