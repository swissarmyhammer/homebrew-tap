class Mirdan < Formula
  desc "Mirdan CLI - Command-line interface for the Mirdan package manager"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer/blob/main/README.md"
  version "0.20.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/mirdan-cli-aarch64-apple-darwin.tar.xz"
    sha256 "eb201c1f27938bc8b7b441fc3789f92fce46373f8c53f2738863f406fe53120a"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/mirdan-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d1ee80f25295365e349829548f6c5513be68ce0320c024d0b433fe257de8329d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.20.2/mirdan-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "22f6d4fbd061f5c7d079e29b96ba78a609ea9d03ffa9ed0c01dac3aa6386ea9a"
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
