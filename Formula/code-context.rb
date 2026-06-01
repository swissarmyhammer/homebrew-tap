class CodeContext < Formula
  desc "Standalone MCP code-context tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.7"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.7/code-context-cli-aarch64-apple-darwin.tar.xz"
    sha256 "9f517047e0fe21cf35b4b821488ab4ba6dbaa87ea6f5ccb9c6f40371ea981399"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.7/code-context-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6036b4e09cdeeed4af5778ff6580380d8ca38fe59ca26c23a1c13d55a5921578"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.7/code-context-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "36d0af41c20d6819471ce2938f3b82dc8dbfc19a6524283af39964cf2b735fb9"
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
