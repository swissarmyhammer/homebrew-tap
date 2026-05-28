class Shelltool < Formula
  desc "Standalone MCP shell tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.6"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.6/shelltool-cli-aarch64-apple-darwin.tar.xz"
    sha256 "cec8776bb670c6baef52ac95ecedc402e230354d70fdd0897da7723334786645"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.6/shelltool-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0c63844db3679d9e02ea19d146ec73c9d22712ff4a4017076ce6a0d7553c3849"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.6/shelltool-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "efb2ee498a96db75ddb3e2b4a1f4be675936447bc43ad9a5f0eefea8db85b0e7"
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
    bin.install "shelltool" if OS.mac? && Hardware::CPU.arm?
    bin.install "shelltool" if OS.linux? && Hardware::CPU.arm?
    bin.install "shelltool" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
