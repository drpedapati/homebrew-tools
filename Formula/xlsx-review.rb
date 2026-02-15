class XlsxReview < Formula
  desc "Read, edit, and diff Excel spreadsheets from the CLI"
  homepage "https://github.com/henrybloomingdale/xlsx-review"
  license "MIT"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.1.0/xlsx-review-darwin-arm64"
      sha256 "2252a97349ec18857efc849c13ad2a0a0e1d147946abd2baef2d6fc27bfe27fa"
    else
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.1.0/xlsx-review-darwin-amd64"
      sha256 "0b9cbd775af1b8558d0fdd25fe48a542f1b74359a851115fcb721cb20d68e103"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.1.0/xlsx-review-linux-arm64"
      sha256 "6003e86f5341e2efbd413e693623af26d1cfdb771e78d4b2c8a03bc19f60cc92"
    else
      url "https://github.com/henrybloomingdale/xlsx-review/releases/download/v1.1.0/xlsx-review-linux-amd64"
      sha256 "ef95d2ed866542aa5d2c4dc7f6c576c0c2e3fdb75534204f223168106f9387c0"
    end
  end

  def install
    binary = Dir["xlsx-review-*"].first || "xlsx-review"
    bin.install binary => "xlsx-review"
  end

  test do
    assert_match "xlsx-review 1.1.0", shell_output("#{bin}/xlsx-review --version")
  end
end
