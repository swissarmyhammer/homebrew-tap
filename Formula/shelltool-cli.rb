class ShelltoolCli < Formula
  desc "Standalone MCP shell tool CLI for AI coding agents"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.3"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.3/shelltool-cli-aarch64-apple-darwin.tar.xz"
    sha256 "dcfd81e2b34bcc1c162e038d0cc3e01ab9406225037cb9c200656f054dfa56fd"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.3/shelltool-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d94f476442029168da3266ba405588f75c3a4e42961ac4b61e86ea75e77d11dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.3/shelltool-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "423f485b5dfe63e243bb16ac09cf569edac6ffdb23837968748fa5a19b60ed1a"
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
