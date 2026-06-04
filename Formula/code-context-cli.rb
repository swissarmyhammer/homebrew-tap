class CodeContextCli < Formula
  desc "Standalone MCP code-context tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.10"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.10/code-context-cli-aarch64-apple-darwin.tar.xz"
    sha256 "3179cab4b1e953d43a7e9d8f60f7b89799f839cc2ee4af9fd14c4006950ccc80"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.10/code-context-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a2c8bcaab3fdacc50b5dc1e564c4842257837a3256e3fa08eabf5643cd9144dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.10/code-context-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7ce5cd3691d58d545799538d658576dbf42cf7f194743fe671d3daa65bbfb67"
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
    bin.install "code-context" if OS.mac? && Hardware::CPU.arm?
    bin.install "code-context" if OS.linux? && Hardware::CPU.arm?
    bin.install "code-context" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
