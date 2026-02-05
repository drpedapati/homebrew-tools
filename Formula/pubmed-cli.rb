class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.2.0/pubmed-darwin-arm64"
      sha256 "4ef6f4f325db6bfa4c847f62ed65f3d1768ff7409399c666a0e15f87b11db7c9"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.2.0/pubmed-darwin-amd64"
      sha256 "ee00111744b764396582e05161da82c970f8ccab31ccf62259534b43cf2bbff0"
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
