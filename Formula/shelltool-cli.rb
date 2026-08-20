class ShelltoolCli < Formula
  desc "Standalone MCP shell tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.18.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/shelltool-cli-aarch64-apple-darwin.tar.xz"
    sha256 "5176541ae41fa8531ee1509194fc03bd6f17f6015eff6fb980569593f37b5cbc"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/shelltool-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8c3f9132bcc034734ec95a5710a2f3b2b2e888eacb9842003ba69ec0e07d318b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/shelltool-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "195236b903cb48f526dd032aee855c591e45cf6b78bf34585f50da890346367b"
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
      bin.install "shelltool"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shelltool"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shelltool"
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
