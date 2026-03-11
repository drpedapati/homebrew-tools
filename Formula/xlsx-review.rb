class XlsxReview < Formula
  desc "Read, edit, and diff Excel spreadsheets from the CLI"
  homepage "https://github.com/drpedapati/xlsx-review"
  version "1.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-darwin-arm64"
      sha256 "78fc6725b4aed5ff51c385ff5e19405df89451adf5adb0a28eb57ab563dc2060"
    else
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-darwin-amd64"
      sha256 "c07f2779e3472e884c7ab3f29fe139a53cac96ceaebcb42ae4b0c100093d1264"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-linux-arm64"
      sha256 "7c474b07000f8cbc1cbb03599ff2e44462ba32154e5b68ccbbe28c350bcf8754"
    else
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-linux-amd64"
      sha256 "9ed2f2a5533df75afbf83702857aafb2877df7cc63d4f9505605b5b32fe5c726"
    end
  end

  def install
    binary = Dir["xlsx-review-*"].first || "xlsx-review"
    bin.install binary => "xlsx-review"
  end

  test do
    assert_match "xlsx-review 1.2.1", shell_output("#{bin}/xlsx-review --version")
  end
end
