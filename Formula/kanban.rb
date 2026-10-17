class Kanban < Formula
  desc "kanban — a git-native task board for humans and AI coding agents; CLI + MCP server over versionable .kanban/ files"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "128fd4d28a6da95024d63a8e325dc0e3f5303ab759a764b2e00476e967f5d99b"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bef92d952e5f0e5732ab09f1791f81a1b2c47c016020f5175a844296fd669c48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43c1f1f472eea88485d3766f20761b0c7551b13f405c72995d6dc1d651885d98"
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
