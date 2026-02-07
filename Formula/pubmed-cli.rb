class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.1/pubmed-darwin-arm64"
      sha256 "5ecbe9d5cc46ec8041d4caae1bd8330af79672208b8d49f0cc0c31d1b9a3ee2f"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.5.1/pubmed-darwin-amd64"
      sha256 "f17ecda34a4be379274d9ee3968822fc929021b427bdb72b071b9dd20016997b"
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
