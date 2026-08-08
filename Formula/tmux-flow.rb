class TmuxFlow < Formula
  desc "Terminal multiplexer with modern workflow defaults (tmux-flow)"
  homepage "https://github.com/drpedapati/tmux-flow"
  url "https://github.com/drpedapati/tmux-flow/archive/refs/tags/v1.9.tar.gz"
  sha256 "fa977481abda8edd742f062ba2f4a7fe3cfefe29b4e2a2ddccf25480acfde61a"
  license "ISC"

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

  # Required by the F12 session chooser.
  depends_on "fzf"
  depends_on "sesh"
  depends_on "zoxide"

  uses_from_macos "bison" => :build

  # Conflicts with stock tmux
  conflicts_with "tmux", because: "both install a `tmux` binary"
  conflicts_with "tmux-custom", because: "tmux-flow replaces tmux-custom"

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/8da7f797245970659b259b85e5409f197b8afddd/completions/tmux"
    sha256 "4e2179053376f4194b342249d75c243c1573c82c185bfbea008be1739048e709"
  end

  # Bundled plugins. Pinned and checksummed so every install gets identical
  # code; previously these were cloned at --depth=1 from whatever HEAD was.
  resource "catppuccin" do
    url "https://github.com/catppuccin/tmux/archive/refs/tags/v2.3.0.tar.gz"
    sha256 "6072ac982aaba71a1ee2a4780a2b5debecfb272857d6ae2ffb9b52649ee07b1a"
  end

  resource "tmux-resurrect" do
    url "https://github.com/tmux-plugins/tmux-resurrect/archive/cff343cf9e81983d3da0c8562b01616f12e8d548.tar.gz"
    sha256 "9f1dda18554291ee7f8a0f499e2af90bbadc2ebceb7a995bb13b76529fe0c5c9"
  end

  resource "tmux-continuum" do
    url "https://github.com/tmux-plugins/tmux-continuum/archive/0698e8f4b17d6454c71bf5212895ec055c578da0.tar.gz"
    sha256 "a1b9a2f0715163472ca713679204a1ca55d3f845cf1c659ae04222db3553424f"
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
    pkgshare.install "scripts/wakatime-heartbeat.sh"
    pkgshare.install "scripts/switch-theme.sh"

    %w[catppuccin tmux-resurrect tmux-continuum].each do |plugin|
      resource(plugin).stage do
        (pkgshare/"plugins"/plugin).install Dir["*"]
      end
    end

    # Bake the install prefix into the bootstrap config so it can be sourced
    # directly. tmux has no way to resolve a config file's own directory.
    pkgshare.install "scripts/tmux-flow.conf"
    inreplace pkgshare/"tmux-flow.conf", "@@PKGSHARE@@", pkgshare

    bash_completion.install resource("completion")
  end

  def caveats
    <<~EOS
      Everything is ready. Start tmux:

          tmux

      Key bindings, mouse support and the status bar are built into the binary
      and need no configuration. Press F1 inside tmux for the full list.

      ── Optional: theme and session save/restore ──────────────────────────

      The Catppuccin theme and session save/restore ship with tmux-flow but are
      opt-in, because enabling them means loading plugins into your config. To
      turn them on, add this line to ~/.tmux.conf:

          source #{pkgshare}/tmux-flow.conf

      That gives you Catppuccin colours, auto-save every 15 minutes, and
      prefix + Ctrl-r to restore a saved session.

      ── Optional: time tracking with Wakapi ───────────────────────────────

      tmux-flow can fire a heartbeat when you switch panes, tracking time per
      git repo, per branch and per tool. It sends to Wakapi, a free
      WakaTime-compatible backend.

        1. Create an account at https://wakapi.dev
        2. Copy your API key from Settings -> Security -> API Key
        3. Create ~/.wakatime.cfg containing:

             [settings]
             api_key = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
             api_url = https://wakapi.dev/api

        4. Start or restart tmux.

      With no ~/.wakatime.cfg this is a silent no-op.
    EOS
  end

  test do
    assert_match "tmux", shell_output("#{bin}/tmux -V")

    # The bootstrap config and every plugin it sources must be present, and the
    # prefix placeholder must have been rewritten.
    assert_path_exists pkgshare/"tmux-flow.conf"
    refute_match "@@PKGSHARE@@", (pkgshare/"tmux-flow.conf").read

    %w[
      plugins/catppuccin/catppuccin.tmux
      plugins/tmux-resurrect/resurrect.tmux
      plugins/tmux-continuum/continuum.tmux
    ].each { |f| assert_path_exists pkgshare/f }

    # The server must start with the bootstrap config and load the plugins.
    socket = "tmux-flow-test"
    system bin/"tmux", "-L", socket, "-f", pkgshare/"tmux-flow.conf", "new-session", "-d"
    begin
      flavour = shell_output("#{bin}/tmux -L #{socket} show -gv @catppuccin_flavor").strip
      assert_equal "mocha", flavour
      keys = shell_output("#{bin}/tmux -L #{socket} list-keys -T prefix")
      assert_match "resurrect", keys
    ensure
      system bin/"tmux", "-L", socket, "kill-server"
    end
  end
end
