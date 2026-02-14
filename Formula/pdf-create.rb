class PdfCreate < Formula
  desc "Generate PDF documents from JSON manifests using QuestPDF"
  homepage "https://github.com/henrybloomingdale/pdf-create"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pdf-create/releases/download/v1.0.0/pdf-create-darwin-arm64"
      sha256 "d9cb7d89c88e597321fffa72e2755789625b283862fd05733aa3496a749548e3"
    else
      url "https://github.com/henrybloomingdale/pdf-create/releases/download/v1.0.0/pdf-create-darwin-amd64"
      sha256 "fcfe7278ad49e9bcf2140d506d720c287c765492ea9a3d3ee0ed6196788c5677"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pdf-create/releases/download/v1.0.0/pdf-create-linux-arm64"
      sha256 "b18bceecb4d84b17abc7a164802602c4df316d294f76a8d2be8a2e7711d465c1"
    else
      url "https://github.com/henrybloomingdale/pdf-create/releases/download/v1.0.0/pdf-create-linux-amd64"
      sha256 "d4c68c842e8757e2e9eac37bf7b217fcb413e6a0b3d40ae3ea5b71101b27c866"
    end
  end

  def install
    binary = Dir["pdf-create-*"].first || "pdf-create"
    bin.install binary => "pdf-create"
  end

  test do
    assert_match "pdf-create 1.0.0", shell_output("#{bin}/pdf-create --version")
  end
end
