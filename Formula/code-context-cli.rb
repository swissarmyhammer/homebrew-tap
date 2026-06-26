class CodeContextCli < Formula
  desc "Standalone MCP code-context tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.17.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.17.0/code-context-cli-aarch64-apple-darwin.tar.xz"
    sha256 "4138fa5d5d45b7656a066824142a0c55a009be6548d3f43ed7a1abdeac47388d"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.17.0/code-context-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "98e94f7ae0a74cf718263bf46fa6b64f6f08c3008220465b594276bd3d16765e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.17.0/code-context-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1736c6aab9b196dd7b5364a8e3f887bd0c5f7241b811aae47d6b3e5ef415ea2f"
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
