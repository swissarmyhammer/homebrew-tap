cask "kanban" do
  version "0.15.0"
  sha256 "111bf901e9c5dbbf236fc0de1905f939bbb93c6a145cdd6bda21ee96f33e82a5"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
