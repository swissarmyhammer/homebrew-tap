class Mirdan < Formula
  desc "Mirdan CLI - Command-line interface for the Mirdan package manager"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.3"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.3/mirdan-cli-aarch64-apple-darwin.tar.xz"
    sha256 "07746ee9575607a026e83610f8b3402c7e00f4bd60effd4bebfac0ad85fe1975"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.3/mirdan-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a08b8e571cbab67efa067f14e536327c5be96b95dfb4dac7e081abc4f978212"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.3/mirdan-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9aef5f8f904f2e57c66022f1837f4d39ef47f633ea44bcfd2d76b1ebae6c498"
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
      bin.install "mirdan"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mirdan"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mirdan"
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
