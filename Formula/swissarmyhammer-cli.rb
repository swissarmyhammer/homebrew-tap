class SwissarmyhammerCli < Formula
  desc "Command-line interface for SwissArmyHammer prompt management"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.15.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/swissarmyhammer-cli-aarch64-apple-darwin.tar.xz"
    sha256 "984f7e4d046471b39fb8fbf07adcfe809d357638875b22387eadd48e43ca7f04"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/swissarmyhammer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a1c6d38ed027d7a20c02116baf09a2609f73da583543d880f92e1f1ba177f4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.15.0/swissarmyhammer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "569d8724e848e4f02b72f5bc14a8880f8d7cca54bd089f1dc10c60c84e3957d4"
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
    bin.install "sah" if OS.mac? && Hardware::CPU.arm?
    bin.install "sah" if OS.linux? && Hardware::CPU.arm?
    bin.install "sah" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
