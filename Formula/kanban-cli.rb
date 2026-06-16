class KanbanCli < Formula
  desc "kanban — a git-native task board for humans and AI coding agents; CLI + MCP server over versionable .kanban/ files"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.15.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "ac2f3e4b2f0a8763ff21309d6558fa2d32550130b8c1cec70ece024f982f76c9"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6c562df4f5239e3ef102559b8e8c27aee430cbcd5e810a19fca2e4600d8794c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56f2436c7f0d1654ef03ec40983dbe29cfadab7e05b64c44c342510895a34234"
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
