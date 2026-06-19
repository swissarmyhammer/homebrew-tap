class MirdanCli < Formula
  desc "Mirdan CLI - Command-line interface for the Mirdan package manager"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.15.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/mirdan-cli-aarch64-apple-darwin.tar.xz"
    sha256 "7d98e391407fede52081969b162606e23ca82706a8e0fb3c0ced0aeca42052c4"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/mirdan-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "31d8f951195f64e5067cb69b904b659bcf5171c33bef2b06ce9f53dd7b7c6248"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.1/mirdan-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fffec977496cd854fce8e736e531c1b2ba6c5a414ff985b67488e6434bce9c3f"
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
    bin.install "mirdan" if OS.mac? && Hardware::CPU.arm?
    bin.install "mirdan" if OS.linux? && Hardware::CPU.arm?
    bin.install "mirdan" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
