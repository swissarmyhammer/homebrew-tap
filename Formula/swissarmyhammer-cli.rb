class SwissarmyhammerCli < Formula
  desc "Command-line interface for SwissArmyHammer prompt management"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"
  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/0.4.0/swissarmyhammer-cli-aarch64-apple-darwin.tar.xz"
  sha256 "d6de745b52dc17eb6d3c2e879e0b264045364e4ac8d706a7588f85fd47d482cf"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "sah"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sah --version")
  end
end
