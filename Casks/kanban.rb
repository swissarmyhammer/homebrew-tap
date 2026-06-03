cask "kanban" do
  version "0.13.8"
  sha256 "42ce2dcb0d7eec01c68133ebe0387df618bd67d52ff6080fc7ea89e066487b03"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban"
end
