class DocxReview < Formula
  desc "Read, edit, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-darwin-arm64"
      sha256 "031a60566ba79264b76850a31a862bc0d3a932e7b77f3b629f66060a9b3e73e3"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-darwin-amd64"
      sha256 "b4b806c09e0226eb8fac87786467371c37f5e472d669f2b7fbf1f44fe2198f65"
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
