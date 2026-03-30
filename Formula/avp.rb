class Avp < Formula
  desc "Agent Validator Protocol - Claude Code hook processor CLI"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.12.9"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/avp-cli-aarch64-apple-darwin.tar.xz"
    sha256 "719dc8222cfa83375fb4ca59f67192261ab9abb65a7927f72e38e063f5c72f0f"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/avp-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f12337e26128e3b4ac341d9bc5a149fcec4e9ccf7f4c597ce3ec3ad7c78f5f50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/avp-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0fa5036d4158d51f08a1231649b9c7ff109917a830d1786e337c947f13364ee3"
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
