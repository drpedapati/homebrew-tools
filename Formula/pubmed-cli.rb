class PubmedCli < Formula
  desc "Command-line client for search, fetch, citation, and traversal workflows"
  homepage "https://github.com/drpedapati/pubmed-cli"
  version "0.5.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-darwin-arm64"
      sha256 "c8ce96d51e842cd0f637b48012f19a7e0203a9cc4e8e6498295e573dd6350af2"
    end
    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-darwin-amd64"
      sha256 "c4eaef94d1ab766d6a8e2b1aea326f5efa09134a3b59f6dc9ce7d3866df26129"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-linux-amd64"
      sha256 "f181dc727fa20a2326e33ceff4d270ce4250dc8c4b28851597f278eaca000263"
    end
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-linux-arm64"
      sha256 "2ab88859fbcc58d3e6d828af5319bbc9afd838e437850c07d6d2b782844ffb60"
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
