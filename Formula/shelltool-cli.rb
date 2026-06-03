class ShelltoolCli < Formula
  desc "Standalone MCP shell tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.8"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/shelltool-cli-aarch64-apple-darwin.tar.xz"
    sha256 "bdcd7035e3de1223478aab475483f884a69f00ac4bfa98c705a7c44a364cfc5e"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/shelltool-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2ce046928c311115bd69d0d17387c0821edc17ae5a85bc47ece8ba58187ddcd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/shelltool-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff7da32eb1dee6d08b860bbdb035745691e2c762644ff0a9142f6f21eec935b6"
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
