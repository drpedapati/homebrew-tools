class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"
  version "1.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-darwin-arm64"
      sha256 "19f574eefcd02d3160982f9aa3d9472d81e92b95f8055150ade89b6d6f1d7da9"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-darwin-amd64"
      sha256 "7ea25c4be73a27e3a39a88abcfe6ad470041f598c0f85df86e62b7d2a0565240"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-linux-arm64"
      sha256 "f1479f2b3db4ab5dea8d975ff08895a6086acdc2ca78923b1bcca43b8bfcd8ce"
    else
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-linux-amd64"
      sha256 "b99f40b283e159fe05ccfa682826aa0b017c9e471f8bb658e8822fcc86616d19"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "docx-review-darwin-arm64" => "docx-review"
    elsif OS.mac?
      bin.install "docx-review-darwin-amd64" => "docx-review"
    elsif Hardware::CPU.arm?
      bin.install "docx-review-linux-arm64" => "docx-review"
    else
      bin.install "docx-review-linux-amd64" => "docx-review"
    end
  end

  test do
    assert_match "docx-review", shell_output("#{bin}/docx-review --help")
  end
end
