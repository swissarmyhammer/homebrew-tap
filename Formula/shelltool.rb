class Shelltool < Formula
  desc "Standalone MCP shell tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.12.9"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/shelltool-cli-aarch64-apple-darwin.tar.xz"
    sha256 "21c7ad436d183fdc7efd5aad8cd3e4366bb8d365e8266756e39c4034fa117cff"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/shelltool-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c086e462d171e6e95ed80f21cd0288fe3a1e923647626c3cf7ce86c4df1b80e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/shelltool-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f82ef8fa145584e8fd8dbf7c41781eca2908786760edbcbe85d0cbb64c9da2eb"
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
