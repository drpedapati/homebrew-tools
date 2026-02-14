class PhiCleaner < Formula
  desc "De-identify clinical text using BERT-based NER models"
  homepage "https://github.com/henrybloomingdale/phi-cleaner"
  license "MIT"
  version "0.1.0"

  # No source download — installs via uv from git (uses git credentials)
  url "https://github.com/henrybloomingdale/phi-cleaner.git",
      tag: "v0.1.0",
      using: :git

  depends_on "python@3.13"
  depends_on "uv"

  def install
    venv = libexec/"venv"

    # Create venv with Python 3.13
    system "uv", "venv", venv, "--python", Formula["python@3.13"].opt_bin/"python3.13"

    # Install the package and its dependencies into the venv
    system "uv", "pip", "install", "--python", venv/"bin/python", buildpath.to_s

    # Create wrapper script that sets env and delegates
    (bin/"phi-clean").write <<~BASH
      #!/bin/bash
      export KMP_DUPLICATE_LIB_OK=TRUE
      exec "#{venv}/bin/phi-clean" "$@"
    BASH
    chmod 0755, bin/"phi-clean"
  end

  def caveats
    <<~EOS
      First run downloads NER model weights (~400 MB) from HuggingFace.
      Python 3.14 is NOT supported (SIGSEGV with torch on ARM64).

      Usage:
        phi-clean "Patient John Smith was seen on 03/15/2024."
        phi-clean -f report.txt -o cleaned.txt
        phi-clean --detect "Dr. Chen at Mayo Clinic"
        phi-clean --models
    EOS
  end

  test do
    assert_match "phi-clean", shell_output("#{bin}/phi-clean --version")
  end
end
