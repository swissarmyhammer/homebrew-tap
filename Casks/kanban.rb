cask "kanban" do
  version "0.18.1"
  sha256 "dc90fb22fa41c45e02c13f9d672b640b350b138c3951197f729cda5b2d6d81fd"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
