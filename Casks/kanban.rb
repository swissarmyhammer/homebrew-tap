cask "kanban" do
  version "0.13.10"
  sha256 "a5dd1ad2a28b32136dc7badc051685dc3070959e73e7eb77ffab7e36ab38dea1"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.10/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban-cli"
end
