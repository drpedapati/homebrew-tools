class DocxReview < Formula
  desc "Read, edit, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"
  version "1.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-darwin-arm64"
      sha256 "f2f8fcd4cedc22bd5d7f0de2ed677acb5eaded1e5a9ec53f1000feb6b86cab5a"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-darwin-amd64"
      sha256 "856b8ab92054cc4cf74431b44d5ac813de7616991beff377f4a2246914599da3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-linux-arm64"
      sha256 "7bf0e349ed85b645fbeb535c4933c8f926dcbe06b5cb3d38489e5256d6b48b0d"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-linux-amd64"
      sha256 "bbf634a36658f15eacb2179bc5e5215b927e2efef2533631d23a3180f4b2bdef"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.1", shell_output("#{bin}/docx-review --version")
  end
end
