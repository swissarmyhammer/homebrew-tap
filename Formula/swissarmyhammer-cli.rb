class SwissarmyhammerCli < Formula
  desc "Command-line interface for SwissArmyHammer prompt management"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.0/swissarmyhammer-cli-aarch64-apple-darwin.tar.xz"
    sha256 "670ff943766d053241ee99418e69f35234d5eefcc6f2fd16ca1286548555a0fa"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.0/swissarmyhammer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a2568b32d34f01a3fd2b31685f9f1eabcc256110fd8fd4f1e924b227e449118"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.0/swissarmyhammer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ace5c833af8f38d28c5e5226a68fdf1d159490eafc7f8864b116fe5d6ba800f4"
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
