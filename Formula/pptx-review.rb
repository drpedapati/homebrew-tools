class PptxReview < Formula
  desc "Read, edit, and diff PowerPoint presentations from the CLI"
  homepage "https://github.com/henrybloomingdale/pptx-review"
  license "MIT"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.2.0/pptx-review-darwin-arm64"
      sha256 "de36b64c1fa829827a87a48eb8cb8d0ca94ec878b4ffb8a4bd8bb0d3245719e9"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.2.0/pptx-review-darwin-amd64"
      sha256 "03079f10eefda272b5ac60f3fe5fe9aaa90558561cd1b2f067b9647841022588"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.2.0/pptx-review-linux-arm64"
      sha256 "9d7672e462c3e50ae68f5ff400fc24b01011e1de3a78ed833d9cb5196df48c69"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.2.0/pptx-review-linux-amd64"
      sha256 "457d54742e6141eee3570a5e6de7095a64db2d26f2ab1ad3cbcf32a36e0dbda4"
    end
  end

  def install
    binary = Dir["pptx-review-*"].first || "pptx-review"
    bin.install binary => "pptx-review"
  end

  test do
    assert_match "pptx-review 1.2.0", shell_output("#{bin}/pptx-review --version")
  end
end
