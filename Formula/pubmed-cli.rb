class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.0/pubmed-darwin-arm64"
      sha256 "7906a47d1296a9b1e44a3f47c8fdaf5b25651f4064ef3552664871b066840518"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.0/pubmed-darwin-amd64"
      sha256 "e0511f4225d0196fcc272abb165a304919c195d8a88d5e8fda29b1d13226f4bd"
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
