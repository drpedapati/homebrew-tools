class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.3.0/pubmed-darwin-arm64"
      sha256 "3306390898075c84773114a51fa7f99f926470c548461cb23d093a6e15761849"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.3.0/pubmed-darwin-amd64"
      sha256 "d48be84a26f39103d306dea8730fe034e4cb1fcb946665103a98d6ac06b03718"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "pubmed-darwin-arm64" => "pubmed"
    else
      bin.install "pubmed-darwin-amd64" => "pubmed"
    end
  end

  test do
    assert_match "Search PubMed", shell_output("#{bin}/pubmed --help")
  end
end
