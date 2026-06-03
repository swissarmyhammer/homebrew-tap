cask "kanban" do
  version "0.13.8"
  sha256 "218783466bc22a0fb6348c794c759b295046df04c9088f27ce87fc6a1444b8b2"

  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/Kanban_aarch64.dmg"
  name "Kanban"
  desc "Kanban board for SwissArmyHammer"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"

  app "Kanban.app"

  binary "#{appdir}/Kanban.app/Contents/MacOS/kanban"
  conflicts_with formula: "kanban"
end
