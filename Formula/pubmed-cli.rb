class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.1.0/pubmed-darwin-arm64"
      sha256 "bd07a304866464719438b99404e6d434201776e5be2c554fbb9da7c7b94c4de1"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.1.0/pubmed-darwin-amd64"
      sha256 "c95cdb0db74ef5c5b13b086e75d21532e00ad2bb563ba07b8c2c60d49a1a9e2a"
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
