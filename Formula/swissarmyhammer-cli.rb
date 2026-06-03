class SwissarmyhammerCli < Formula
  desc "Command-line interface for SwissArmyHammer prompt management"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.8"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/swissarmyhammer-cli-aarch64-apple-darwin.tar.xz"
    sha256 "a0255bf6e48bc21dfb24357f85e9bc77a9172459587bd5def1acb88975e26581"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/swissarmyhammer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a730316943d9747270945e7907656d87d0ed70e402c2530f6c8141a5e548b0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.8/swissarmyhammer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c5288c53994874a1ff921e1d258a3a95cfc9da719440e370d25d12e85b71a722"
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
