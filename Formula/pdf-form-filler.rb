class PdfFormFiller < Formula
  desc "Inspect, schema-export, fill, and flatten true AcroForm PDFs"
  homepage "https://github.com/drpedapati/csharp-pdf-filler"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/csharp-pdf-filler/releases/download/v0.1.0/pdf-form-filler-v0.1.0-osx-arm64.tar.gz"
      sha256 "2a91219864f0d3c657d345f37f2c87d17e99bc4b84946afbcfb9147dbcf7d4c4"
    else
      url "https://github.com/drpedapati/csharp-pdf-filler/releases/download/v0.1.0/pdf-form-filler-v0.1.0-osx-x64.tar.gz"
      sha256 "c75ac35a9fa9d4c8e4daf63243e7b2d82224f5fd1a913559cec2bd42f29118bc"
    end
  end

  def install
    binary = Dir["**/pdf-form-filler"].find { |path| File.file?(path) }
    raise "pdf-form-filler binary not found in archive" unless binary

    bin.install binary => "pdf-form-filler"
  end

  test do
    assert_match "pdf-form-filler", shell_output("#{bin}/pdf-form-filler --help")
  end
end
