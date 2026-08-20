class SwissarmyhammerCli < Formula
  desc "Command-line interface for SwissArmyHammer prompt management"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.18.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/swissarmyhammer-cli-aarch64-apple-darwin.tar.xz"
    sha256 "f79ce79e850e1c0ea0390b3e75e75cbd523e392a6a9295a2dca3bf06ad667ae0"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/swissarmyhammer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "26a2ae2bd589b65a02459d2e2a7dd675e7b12b5a30fd4b1538c027085a3f8a9b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.18.1/swissarmyhammer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "818055e7516ca25bd4e7e5be3feb25fe400082ec0fec392d1ecfcc80d10de52e"
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
