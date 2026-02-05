class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.1.1/pubmed-darwin-arm64"
      sha256 "063c02fd82e32f462472c70cd0080feb22336fc91c4c7e3866f420efd1e265ae"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.1.1/pubmed-darwin-amd64"
      sha256 "dab6ce666d88d26b081ba24bb10337aeb865873714203d720c0402ed7ffdb94d"
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
