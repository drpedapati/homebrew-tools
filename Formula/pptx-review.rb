class PptxReview < Formula
  desc "Add comments and edit PowerPoint presentations from the CLI"
  homepage "https://github.com/henrybloomingdale/pptx-review"
  license "MIT"
  version "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.1/pptx-review-darwin-arm64"
      sha256 "efd98ecc87995f7fcd7c196c63f47c5e28579a044269f99f0d61976defe3a8d5"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.1/pptx-review-darwin-amd64"
      sha256 "ba2d2da7dcbc86cf2c727ed6fecc3e5986a1a5d7c5c81296ab301a3403950644"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.1/pptx-review-linux-arm64"
      sha256 "da3679c1f6fdac40a8f39c6992bce1b12dbcf598c146d8cedcc472b7fe4efcb9"
    else
      url "https://github.com/henrybloomingdale/pptx-review/releases/download/v1.0.1/pptx-review-linux-amd64"
      sha256 "274749143a5e88dc127a88d40160eac9c699c7281b476448a3be37368323fc22"
    end
  end

  def install
    binary = Dir["pptx-review-*"].first || "pptx-review"
    bin.install binary => "pptx-review"
  end

  test do
    assert_match "pptx-review 1.0.1", shell_output("#{bin}/pptx-review --version")
  end
end
