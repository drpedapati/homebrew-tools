class PhiCleaner < Formula
  include Language::Python::Virtualenv

  desc "De-identify clinical text using BERT-based NER models"
  homepage "https://github.com/henrybloomingdale/phi-cleaner"
  url "https://github.com/henrybloomingdale/phi-cleaner/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  version "0.1.0"

  depends_on "python@3.13"
  depends_on "uv"

  def install
    # Install into a uv-managed virtual environment for proper dependency isolation.
    # torch + transformers are heavy (~500 MB) — uv handles this cleanly.
    venv = libexec/"venv"
    system "uv", "venv", venv, "--python", Formula["python@3.13"].opt_bin/"python3.13"
    system "uv", "pip", "install", "--python", venv/"bin/python",
           "torch>=2.0", "transformers>=4.30", "sentencepiece>=0.1.99"
    system "uv", "pip", "install", "--python", venv/"bin/python", buildpath.to_s

    # Create wrapper script
    (bin/"phi-clean").write <<~BASH
      #!/bin/bash
      export KMP_DUPLICATE_LIB_OK=TRUE
      exec "#{venv}/bin/phi-clean" "$@"
    BASH
    chmod 0755, bin/"phi-clean"
  end

  def caveats
    <<~EOS
      First run will download the NER model weights (~400 MB) from HuggingFace.

      Python 3.14 is not supported (SIGSEGV with torch on ARM64).

      Usage:
        phi-clean "Patient John Smith was seen on 03/15/2024."
        phi-clean -f report.txt -o cleaned.txt
        phi-clean --models
    EOS
  end

  test do
    assert_match "phi-clean", shell_output("#{bin}/phi-clean --version")
  end
end
