class Kanban < Formula
  desc "Standalone CLI for SwissArmyHammer Kanban board"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"
  version "0.12.9"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/kanban-cli-aarch64-apple-darwin.tar.xz"
    sha256 "b0807ea937d47e5edd9332f5886621e60cafdb5b30a89ffa3e5acc714ec86d80"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/kanban-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "70ab106920304e901f8df02ba20795a0518c97d2abaafaad727fdd3fbdc806ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/v0.12.9/kanban-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a3e90dd95ee42bfd210ac209e943941e3fd6eb02b099fec3c54f8611e6c65fd"
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
    bin.install "kanban" if OS.mac? && Hardware::CPU.arm?
    bin.install "kanban" if OS.linux? && Hardware::CPU.arm?
    bin.install "kanban" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
