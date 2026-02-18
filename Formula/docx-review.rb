class DocxReview < Formula
  desc "Read, edit, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-darwin-arm64"
      sha256 "6af82faa29f04a0a4f8b4e2f3350fa47f00767d51774fd72fbf5080e888e40c3"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-darwin-amd64"
      sha256 "4a26e20fbfc30582c112bf1381303323807b47f085a497b29a76e07665b52741"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-linux-arm64"
      sha256 "f18af391b2911bdcbe18ecd5a9dbf970d23ff4efd8d9bb0c1fdab8fcdbc96463"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-linux-amd64"
      sha256 "1bfb0330eb132b8e0c32eb0ff79a356dcaa2a5285d4bf2b09771dafd589bfbc0"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.0", shell_output("#{bin}/docx-review --version")
  end
end
