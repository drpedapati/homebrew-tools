class DocxReview < Formula
  desc "Add tracked changes and comments to Word documents from the CLI"
  homepage "https://github.com/henrybloomingdale/docx-review"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.0.0/docx-review-darwin-arm64"
      sha256 "36359b6e0499a387d7fc227abb66e6188fb2206f5655b3caac75e2b0b573b099"
    else
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.0.0/docx-review-darwin-amd64"
      sha256 "9279c6fc56824f45894f93704659381913017a7cc81798a4c7b317732f161ea2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.0.0/docx-review-linux-arm64"
      sha256 "0d971283f31f1d4f340171a9cba7682f52f753a09636a0cb311e2819ebb0bfe8"
    else
      url "https://github.com/henrybloomingdale/docx-review/releases/download/v1.0.0/docx-review-linux-amd64"
      sha256 "3441954660a25eec41f37d7549810b841e4c64714462fe0dc8e6c530db7a09f9"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.0.0", shell_output("#{bin}/docx-review --version")
  end
end
