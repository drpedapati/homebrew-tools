class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.5.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.3/pubmed-darwin-arm64"
      sha256 "bf1002ca53d053a44bffafa8fe7af97a6af0e30ea43339be2fc9e2964945eaf7"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.3/pubmed-darwin-amd64"
      sha256 "f1b1797ca60ed00384dd14f32d0ce3fc1afc774bf7baf780427e93d50d411631"
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
