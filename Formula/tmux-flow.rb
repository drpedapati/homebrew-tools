class TmuxFlow < Formula
  desc "Terminal multiplexer with modern workflow defaults (tmux-flow)"
  homepage "https://github.com/drpedapati/tmux-flow"
  url "https://github.com/drpedapati/tmux-flow/archive/refs/tags/v1.2.tar.gz"
  sha256 "0285962e17aa87a73a8738d42794ae167d8b49d642c36ed107f21f0595325344"
  license "ISC"
  version "1.2"

  # GitHub archive tarballs don't include generated configure scripts,
  # so autotools are required for both stable and HEAD builds.
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  head do
    url "https://github.com/drpedapati/tmux-flow.git", branch: "main"
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
  conflicts_with "tmux-custom", because: "tmux-flow replaces tmux-custom"

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/8da7f797245970659b259b85e5409f197b8afddd/completions/tmux"
    sha256 "4e2179053376f4194b342249d75c243c1573c82c185bfbea008be1739048e709"
  end

  def install
    system "sh", "autogen.sh"

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
    pkgshare.install "scripts/switch-theme.sh" if File.exist?("scripts/switch-theme.sh")
    bash_completion.install resource("completion")
  end

  def post_install
    home = Pathname(ENV["HOME"])
    tmux_dir = home/".tmux"
    plugins_dir = tmux_dir/"plugins"
    plugins_dir.mkpath

    # Copy helper scripts (skip if already present so user edits are preserved)
    ["wakatime-heartbeat.sh", "switch-theme.sh"].each do |script|
      src = pkgshare/script
      next unless src.exist?
      dst = tmux_dir/script
      unless dst.exist?
        dst.write(src.read)
        dst.chmod(0o755)
      end
    end

    # Clone plugins if not already installed
    {
      "catppuccin"      => "https://github.com/catppuccin/tmux",
      "tmux-resurrect"  => "https://github.com/tmux-plugins/tmux-resurrect",
      "tmux-continuum"  => "https://github.com/tmux-plugins/tmux-continuum",
    }.each do |name, url|
      dst = plugins_dir/name
      next if dst.exist?
      system "git", "clone", "--depth=1", "--quiet", url, dst.to_s
    end
  end

  def caveats
    <<~EOS
      ╭─ tmux-flow ────────────────────────────────────────────────────────╮
      │                                                                       │
      │  Everything is ready. Start tmux:                                     │
      │                                                                       │
      │     tmux                                                              │
      │                                                                       │
      │  F1 inside tmux shows all key bindings.                               │
      │  Sessions auto-save every 15 min  ·  prefix + Ctrl-r to restore.     │
      │                                                                       │
      ╰───────────────────────────────────────────────────────────────────────╯

      ╭─ Optional: Time Tracking with Wakapi ────────────────────────────────╮
      │                                                                       │
      │  tmux-flow fires a heartbeat every time you switch panes,            │
      │  automatically tracking how long you spend in each project,          │
      │  which tools you use (claude, codex, lazygit, zsh), and which        │
      │  git branch you are on — all without touching your editor.            │
      │                                                                       │
      │  It sends data to Wakapi, a free open-source WakaTime-compatible     │
      │  backend. Self-hosted at wakapi.dev. No subscription required.        │
      │                                                                       │
      │  ── Setup (5 minutes) ───────────────────────────────────────────    │
      │                                                                       │
      │  1. Create a free account at https://wakapi.dev                      │
      │                                                                       │
      │  2. Copy your API key from:                                           │
      │       wakapi.dev → Settings → Security → API Key                     │
      │                                                                       │
      │  3. Create ~/.wakatime.cfg with the following contents:              │
      │                                                                       │
      │       [settings]                                                      │
      │       api_key = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx                 │
      │       api_url = https://wakapi.dev/api                                │
      │                                                                       │
      │  4. Start (or restart) tmux — tracking begins automatically.         │
      │                                                                       │
      │  ── What you will see in your dashboard ─────────────────────────    │
      │                                                                       │
      │  · Projects   — time per git repo (auto-detected from directory)     │
      │  · Editors    — claude / codex / lazygit / zsh / nvim per project   │
      │  · Branches   — which git branch you were on                         │
      │  · Categories — same as editors, for filtering                       │
      │  · Machines   — if you use tmux-flow on multiple machines            │
      │                                                                       │
      │  No ~/.wakatime.cfg = silent no-op. Zero overhead. Fully optional.   │
      │                                                                       │
      ╰───────────────────────────────────────────────────────────────────────╯

      To install:
        brew install drpedapati/tools/tmux-flow
    EOS
  end

  test do
    system bin/"tmux", "-V"
  end
end
