class PptxReview < Formula
  desc "Read, edit, and diff PowerPoint presentations from the CLI"
  homepage "https://github.com/henrybloomingdale/pptx-review"
  license "MIT"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.1.0/pptx-review-darwin-arm64"
      sha256 "c1ddd58861906eb7a78d09d4138f551d6c811e9dd100e29e04fce743f58946d8"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.1.0/pptx-review-darwin-amd64"
      sha256 "03079f10eefda272b5ac60f3fe5fe9aaa90558561cd1b2f067b9647841022588"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.1.0/pptx-review-linux-arm64"
      sha256 "8663e1a67fc66898684f817b1943e8fd37751cd9b4027c9c84190e09cda265dc"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.1.0/pptx-review-linux-amd64"
      sha256 "457d54742e6141eee3570a5e6de7095a64db2d26f2ab1ad3cbcf32a36e0dbda4"
    end
  end

  def install
    binary = Dir["pptx-review-*"].first || "pptx-review"
    bin.install binary => "pptx-review"
  end

  test do
    assert_match "pptx-review 1.1.0", shell_output("#{bin}/pptx-review --version")
  end
end
