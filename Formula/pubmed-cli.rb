class PubmedCli < Formula
  desc "Command-line client for search, fetch, citation, and traversal workflows"
  homepage "https://github.com/drpedapati/pubmed-cli"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-darwin-arm64"
      sha256 "f1f16c692a508ad4bf2225fd42bbec9624110e61bb1894ed5154382619f041e0"
    end
    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-darwin-amd64"
      sha256 "c30e7285e4a38f5c4836451a7e4793dad93400682710d95d7f7c15fc39d106fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-linux-amd64"
      sha256 "dc007b61b247cfa4deec88973fa13f79c7347818146ff5042507b1ab45336e4b"
    end
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-linux-arm64"
      sha256 "217b8775f52f0c60f9b40e956dc7553d7acca5d01f47698f8de8c4d9428aa283"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pubmed-darwin-arm64" => "pubmed"
    elsif OS.mac?
      bin.install "pubmed-darwin-amd64" => "pubmed"
    elsif Hardware::CPU.arm?
      bin.install "pubmed-linux-arm64" => "pubmed"
    else
      bin.install "pubmed-linux-amd64" => "pubmed"
    end
  end

  test do
    assert_match "Search PubMed", shell_output("#{bin}/pubmed --help")
  end
end
