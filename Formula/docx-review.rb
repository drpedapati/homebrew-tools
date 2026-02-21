class DocxReview < Formula
  desc "Read, edit, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"
  version "1.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.2/docx-review-darwin-arm64"
      sha256 "9b4eb4959751286171e112b2d32cd6a9b0bdbb062ebfc3123015fd2034b8dab8"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.2/docx-review-darwin-amd64"
      sha256 "0d5b08eb1631a162c8c3caed1f1411ce3ecc3e6c7f673f39829e9480720feb0c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.2/docx-review-linux-arm64"
      sha256 "57d16ee3e427b80d9d0861dc88b133fd342b274b0b08e97a804e110c93c36df0"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.2/docx-review-linux-amd64"
      sha256 "687fd6415efab79b8f0372f6bf6859c3bbb5a7da1106ace63c5d49bbdca9fb5c"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.2", shell_output("#{bin}/docx-review --version")
  end
end
