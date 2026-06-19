class KanbanCli < Formula
  desc "kanban — a git-native task board for humans and AI coding agents; CLI + MCP server over versionable .kanban/ files"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.15.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "a2373adf4e09089baf9de8d384229d8277d5535b4cf45ebaee7ac6ff4803dbee"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2e02dcbc6f9a24adff684f65139507befb264a18834a05f2e4fb2316a8d7917e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "29406bc24a43b007454c62f189b22cbe1d8c16a1eb0a2936fae6e31a2d252d49"
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
