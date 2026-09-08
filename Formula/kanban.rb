class Kanban < Formula
  desc "kanban — a git-native task board for humans and AI coding agents; CLI + MCP server over versionable .kanban/ files"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.0/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "ed04030bab6f5524c989cd76caf39aee04c5b04205ba147d2546dcc28d767ae7"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.0/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f8194577700f5bdbd86af59109e1d0a976dd899befb71f2d50ad84d6617b13c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.0/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "73782084bbf9de49537b188a51540d6d9bf1f7fba50fdfa48f48b2a0ac029566"
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
