class Kanban < Formula
  desc "Standalone CLI for SwissArmyHammer Kanban board"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"
  version "0.13.4"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.4/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "9bb1305fbb598d8b8714348ee9088cc040af43e05d18b06ecf99b1482ed978df"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.4/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "16d3fecb8ce8a217da77ca472456baad8440b526c49d626daa3bbc903f658198"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.4/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d960fcc957913cc82adbdf90dc928ec4f08a94d89e64dd3eed0e671c2d9870b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "kanban" if OS.mac? && Hardware::CPU.arm?
    bin.install "kanban" if OS.linux? && Hardware::CPU.arm?
    bin.install "kanban" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
