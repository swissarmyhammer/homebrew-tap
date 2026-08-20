class KanbanCli < Formula
  desc "kanban — a git-native task board for humans and AI coding agents; CLI + MCP server over versionable .kanban/ files"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.18.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.0/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "79022dd0d22cffa81f5744cb7ec6994113b84f6f1b506c4c52a3b5bc9ad5a056"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.0/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a431cc5746092ecea03d52c7cef402a438062568c843626cb23e21c2b59f893"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.0/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e6b4bf927f19c8a0ff887b54fc5fcf27e78fb74033fe5d4b2199fc61b474fc57"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kanban"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kanban"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kanban"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
