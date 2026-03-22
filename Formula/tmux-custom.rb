class TmuxCustom < Formula
  desc "Terminal multiplexer (drpedapati fork with custom patches)"
  homepage "https://github.com/drpedapati/tmux"
  url "https://github.com/tmux/tmux/releases/download/3.6a/tmux-3.6a.tar.gz"
  sha256 "b6d8d9c76585db8ef5fa00d4931902fa4b8cbe8166f528f44fc403961a3f3759"
  license "ISC"
  version "3.6a"

  head do
    url "https://github.com/drpedapati/tmux.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libevent"
  depends_on "ncurses"
  depends_on "utf8proc"
  depends_on "wakatime-cli"
  depends_on "sesh"
  depends_on "fzf"
  depends_on "zoxide"

  uses_from_macos "bison" => :build

  # Conflicts with stock tmux
  conflicts_with "tmux", because: "both install a `tmux` binary"

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/8da7f797245970659b259b85e5409f197b8afddd/completions/tmux"
    sha256 "4e2179053376f4194b342249d75c243c1573c82c185bfbea008be1739048e709"
  end

  def install
    system "sh", "autogen.sh" if build.head?

    args = %W[
      --enable-sixel
      --sysconfdir=#{etc}
      --enable-utf8proc
    ]

    args << "--with-TERM=screen-256color" if OS.mac? && MacOS.version < :sonoma

    system "./configure", *args, *std_configure_args
    system "make", "install"

    pkgshare.install "example_tmux.conf"
    pkgshare.install "scripts/wakatime-heartbeat.sh" if File.exist?("scripts/wakatime-heartbeat.sh")
    bash_completion.install resource("completion")
  end

  def caveats
    <<~EOS
      ╭─ tmux-custom (drpedapati fork) ──────────────────────────────╮
      │                                                               │
      │  1. Install the Catppuccin theme plugin (one-time):           │
      │                                                               │
      │     git clone https://github.com/catppuccin/tmux \\           │
      │       ~/.tmux/plugins/catppuccin                              │
      │                                                               │
      │  2. (Optional) Enable time tracking via wakapi.dev:            │
      │     Sign up at https://wakapi.dev, then create               │
      │     ~/.wakatime.cfg:                                          │
      │                                                               │
      │     [settings]                                                │
      │     api_key = YOUR_KEY                                        │
      │     api_url = https://wakapi.dev/api                          │
      │                                                               │
      │  3. Start tmux:  tmux                                         │
      │     (attaches to existing 'main' session or creates one)      │
      │                                                               │
      │  F1 inside tmux shows the full key binding reference.         │
      │                                                               │
      │  Docs: https://github.com/drpedapati/tmux                     │
      ╰───────────────────────────────────────────────────────────────╯
    EOS
  end

  test do
    system bin/"tmux", "-V"
  end
end
