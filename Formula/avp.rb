class Avp < Formula
  desc "Agent Validator Protocol - Claude Code hook processor CLI"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.5"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.5/avp-cli-aarch64-apple-darwin.tar.xz"
    sha256 "7a68a4c8a3ec763a2f1c4439267c726dfdcf47635d827e4d17fddfa23eb8f776"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.5/avp-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8407762b8138b17ee15276630c7ae8ba680ca46a3b871c49f1483f47b8ba5eb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.5/avp-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "edc317d564ed303d2eb6c418b912ce99096ec7fcd10d78967028d90f62277d4a"
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
    bin.install "avp" if OS.mac? && Hardware::CPU.arm?
    bin.install "avp" if OS.linux? && Hardware::CPU.arm?
    bin.install "avp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
