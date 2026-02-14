class DocxReview < Formula
  desc "Add tracked changes and comments to Word documents from the CLI"
  homepage "https://github.com/henrybloomingdale/docx-review"
  license "MIT"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.1.0/docx-review-darwin-arm64"
      sha256 "a84bb1888f61e0f7e6947033e391e7fb78c8c21aadf1a0599bf18cb7978db84a"
    else
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.1.0/docx-review-darwin-amd64"
      sha256 "42df83e0f323ea0bc1303d76d7a8d15c0ae668f5b1eb837eca5bd6e3a10e7203"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.1.0/docx-review-linux-arm64"
      sha256 "0875dfd1aa7e8047e162c73136d19d53a8ac2110199fe41f0cd49d105abc56a1"
    else
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.1.0/docx-review-linux-amd64"
      sha256 "4a3d497da7bc0fb8c2a8a92278db695fe8de178716dcc998f796e3596abbef76"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.1.0", shell_output("#{bin}/docx-review --version")
  end
end
