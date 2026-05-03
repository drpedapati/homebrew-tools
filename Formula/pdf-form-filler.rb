class PdfFormFiller < Formula
  desc "Inspect, schema-export, fill, and flatten true AcroForm PDFs"
  homepage "https://github.com/drpedapati/csharp-pdf-filler"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/csharp-pdf-filler/releases/download/v0.2.1/pdf-form-filler-v0.2.1-osx-arm64.tar.gz"
      sha256 "01113d4a24fea1c8e7e8468e36935ebc3cc493f8a4c0f8f7a0bb5c820fcc40be"
    else
      url "https://github.com/drpedapati/csharp-pdf-filler/releases/download/v0.2.1/pdf-form-filler-v0.2.1-osx-x64.tar.gz"
      sha256 "ea3326741c547ecc5738e10db3e1018890da70fa89331c39c5d6ac9e2b4ea355"
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
