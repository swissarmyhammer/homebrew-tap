class SwissarmyhammerCli < Formula
  desc "Command-line interface for SwissArmyHammer prompt management"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.1/swissarmyhammer-cli-aarch64-apple-darwin.tar.xz"
    sha256 "79610607d37123b95f52174e755467929839d10903181ea2c1f23653b012722f"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.1/swissarmyhammer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "246bd898cdb61352083e9f728ca13a7b53ce30625827c037f0f210d43cfb177d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.1/swissarmyhammer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af7196042c9d4f73a79c3628d7f1b25e0ef48e2d818fe2c7f4adff61c9d33d42"
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
      bin.install "sah"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sah"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sah"
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
