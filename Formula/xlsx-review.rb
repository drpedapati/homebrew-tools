class XlsxReview < Formula
  desc "Read, edit, and diff Excel spreadsheets from the CLI"
  homepage "https://github.com/drpedapati/xlsx-review"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.3.0/xlsx-review-darwin-arm64"
      sha256 "00bbbda8c350cdfda6b7d80701515ac5ae36ef57c8ddfdf958520b07fa0c9668"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.3.0/xlsx-review-linux-arm64"
      sha256 "ef8e8bb75bb8d2cd22722e522d4129c27b5738a88f16fe6ba373eaf17152a8df"
    else
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.3.0/xlsx-review-linux-amd64"
      sha256 "17d2c8ed4db2e082c8e51f8f73b2cbc87de383e179f9d21bf5ee8ee8e2b5404f"
    end
  end

  def install
    binary = Dir["xlsx-review-*"].first || "xlsx-review"
    bin.install binary => "xlsx-review"
  end

  test do
    assert_match "xlsx-review 1.3.0", shell_output("#{bin}/xlsx-review --version")
  end
end
