class CodeContextCli < Formula
  desc "Standalone MCP code-context tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.16.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.16.0/code-context-cli-aarch64-apple-darwin.tar.xz"
    sha256 "1e880c2c0369507c3e9d22723e4785e28dcc2e04675eae93f17d63b9703cf2ed"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.16.0/code-context-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b25a20a5a7a348c49b953d99871252c94ab1ed42526663ff6e0b6cce4716c95d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.16.0/code-context-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "17cab4231f7ddbb7e9ca0586ce42f60992ba43e226133210d8611f17003efb00"
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
