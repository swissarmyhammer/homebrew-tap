class Mirdan < Formula
  desc "Mirdan CLI - Command-line interface for the Mirdan package manager"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.13.7"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.7/mirdan-cli-aarch64-apple-darwin.tar.xz"
    sha256 "72c35dae8839f0912b9584e1a66478927837cef4b171d1d76d2076d7df6ea024"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.7/mirdan-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74b043416cb1005c7c1a516e6dc1877d7b53a00a84b6693667d8c3dae49f378a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.13.7/mirdan-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b067b6255d0b0395a2e2d6dbe5fe893b091c199f4723d5a15e31c852ce4dd383"
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
