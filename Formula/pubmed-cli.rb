class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.2/pubmed-darwin-arm64"
      sha256 "f7fe2da6b2f8ebe74f1b0c18e01ab86ab4c1d07173b073279df5bd73c69543d6"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.2/pubmed-darwin-amd64"
      sha256 "f0569bdec92287948dd99e8a4462984cef5c4829bec81e6ce899c2a3dbc2e7fa"
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
