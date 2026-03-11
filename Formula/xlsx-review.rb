class XlsxReview < Formula
  desc "Read, edit, and diff Excel spreadsheets from the CLI"
  homepage "https://github.com/drpedapati/xlsx-review"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.0/xlsx-review-darwin-arm64"
      sha256 "dd5a7f7a6741f1b1558d092e25c1b3768556216d2004683d905a887ec7e80e20"
    else
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.0/xlsx-review-darwin-amd64"
      sha256 "74e1baeac05061e25fcbe9ccfe7c9152f316776375a3dd32413ffa5843abedfb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.0/xlsx-review-linux-arm64"
      sha256 "84d1509104f963216d4cf0b0668af0465254289e05800becdab23950c0075e52"
    else
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.0/xlsx-review-linux-amd64"
      sha256 "0d20d062ab9a2228013ed921f68575724446953567bc336593b90d90e39460d2"
    end
  end

  def install
    binary = Dir["xlsx-review-*"].first || "xlsx-review"
    bin.install binary => "xlsx-review"
  end

  test do
    assert_match "xlsx-review 1.2.0", shell_output("#{bin}/xlsx-review --version")
  end
end
