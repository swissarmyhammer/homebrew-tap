class Avp < Formula
  desc "Agent Validator Protocol - Claude Code hook processor CLI"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.6"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.6/avp-cli-aarch64-apple-darwin.tar.xz"
    sha256 "899857f3c33cf1aba50143fb5a48c2140310e971118c49275a204aff67552dde"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.6/avp-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "caaa271784761985735e606de190bf374d436d1789087e4087bf54bb1bddd292"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.6/avp-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d16eb6f5a243b569fbd4360983abc52074a84cc3b13164fa4e9b688163ac55a1"
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
