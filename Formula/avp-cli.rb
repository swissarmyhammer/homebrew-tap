class AvpCli < Formula
  desc "Agent Validator Protocol - Claude Code hook processor CLI"
  homepage "https://github.com/swissarmyhammer/swissarmyhammer"
  url "https://github.com/swissarmyhammer/swissarmyhammer/releases/download/0.4.0/avp-cli-aarch64-apple-darwin.tar.xz"
  sha256 "dc742b988ee946644f70454062768e653453e7d3a88dd1adf4d9de41d5ff54ab"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "avp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/avp --version")
  end
end
