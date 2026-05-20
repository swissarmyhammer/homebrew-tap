class Mirdan < Formula
  desc "Mirdan CLI - Command-line interface for the Mirdan package manager"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.4"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.4/mirdan-cli-aarch64-apple-darwin.tar.xz"
    sha256 "8bc8f04044fef671a0fe13b9214a5fc345994c4c6e0fe0eb7385e7bb403b8278"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.4/mirdan-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2db66976432ade4c8b6adaae659886d89a4cc4884b956c0ae84a918f5c67e444"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.4/mirdan-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6c43fc15074af2d3d17d5ce20b55171c68d340efc4fc09002b85f207d470e74"
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
