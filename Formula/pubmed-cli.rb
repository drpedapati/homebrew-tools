class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/henrybloomingdale/pubmed-cli"
  license "MIT"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.4.0/pubmed-darwin-arm64"
      sha256 "ed8cfbaa9708b95be2166e64dd3021053c6404538e29d7613de356aa69010e0b"
    else
      url "https://github.com/henrybloomingdale/pubmed-cli/releases/download/v0.4.0/pubmed-darwin-amd64"
      sha256 "96b35a3d9d456fc8673aa5dd098da691c29d1f3ef6f40f16bb45af23a00e0626"
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
