class PptxReview < Formula
  desc "Add comments and edit PowerPoint presentations from the CLI"
  homepage "https://github.com/henrybloomingdale/pptx-review"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.0/pptx-review-darwin-arm64"
      sha256 "c10b02f596d8f8538c8b1306ae02a96b901a1d277df1d95ea32ce9dce389cd22"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.0/pptx-review-darwin-amd64"
      sha256 "87ed92d352af7d36acd09ff13e5ffc426b151a6383a9229d76f89abe6a92d457"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.0/pptx-review-linux-arm64"
      sha256 "48e16d3171610d2bf1a3601c1225e5bf7093ea239261da6b5b8bdb2462020066"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.0/pptx-review-linux-amd64"
      sha256 "be5256494df945e5a0eae634948b1c6e89a194a3f762d019593a8434c95edcb9"
    end
  end

  def install
    binary = Dir["pptx-review-*"].first || "pptx-review"
    bin.install binary => "pptx-review"
  end

  test do
    assert_match "pptx-review 1.0.0", shell_output("#{bin}/pptx-review --version")
  end
end
