class CodeContextCli < Formula
  desc "Standalone MCP code-context tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/code-context-cli-aarch64-apple-darwin.tar.xz"
    sha256 "c5541f09a6d2e4d6bf090a9dea7c20c965f3bffefaceb1bd95bdeb940ef6de62"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/code-context-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e5ae68319fef1be3eeb5b11bd2af9f3397d181bb77056e0a5aca1767e966ed1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/code-context-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7c7639f1c5237d835f6b4dd3e7c4a34532c8b67b0c3ccccd18c2ad4d3f459ce"
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
      bin.install "code-context"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "code-context"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "code-context"
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
