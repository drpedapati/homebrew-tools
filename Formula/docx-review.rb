class DocxReview < Formula
  desc "Read, edit, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"
  version "1.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-darwin-arm64"
      sha256 "612669fde6034106ededdc3ca8085b95193720fc9a2c6837dfa8f23782764ab8"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-darwin-amd64"
      sha256 "a7d990a88483101053e7b774b741b481b73d41afa174de51f5fcbd198b93bed8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-linux-arm64"
      sha256 "ed02f7e670b66d2d2396fa8da2409a3a3e2266197cd199f5a3c4f0bf9ffc5cda"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.1/docx-review-linux-amd64"
      sha256 "b712f9da44ac0631826d580103078a3bb26900f357c49e190c3d6f549090c55f"
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
