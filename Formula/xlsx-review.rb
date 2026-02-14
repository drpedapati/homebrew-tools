class XlsxReview < Formula
  desc "Edit Excel spreadsheets from the CLI with highlighted changes and comments"
  homepage "https://github.com/henrybloomingdale/xlsx-review"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.0.0/xlsx-review-darwin-arm64"
      sha256 "b48c92327fef0080591bc7c98806ff9c27dc1d2a7baaa6356c7c4d972ab6417c"
    else
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.0.0/xlsx-review-darwin-amd64"
      sha256 "8a9aeb371721d1721d3646730ad598ab6270ad01f0c6e2a53ec6891ec70cd896"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.0.0/xlsx-review-linux-arm64"
      sha256 "4e1789f230057ae4e38ff190dd43a9a30d708c304f90196b017c6b67e449d00f"
    else
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.0.0/xlsx-review-linux-amd64"
      sha256 "d91c4780fa4ce8ba67142f4f15a74d4af67ad54cfc14d1578059ffbe2f5727ec"
    end
  end

  def install
    binary = Dir["xlsx-review-*"].first || "xlsx-review"
    bin.install binary => "xlsx-review"
  end

  test do
    assert_match "xlsx-review 1.0.0", shell_output("#{bin}/xlsx-review --version")
  end
end
