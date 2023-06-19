class Skhd < Formula
  desc "Simple hotkey-daemon for macOS."
  homepage "https://github.com/koekeishiya/skhd"
  url "https://github.com/mil-ad/skhd/archive/v0.3.9.zip"
  sha256 "b953899cf01ffb7eca9710fd413a7442cba62da68936c78e582165dd91a70389"
  head "https://github.com/mil-ad/skhd.git"

  def install
    ENV.deparallelize
    system "make", "-j1", "install"
    bin.install "#{buildpath}/bin/skhd"
    (pkgshare/"examples").install "#{buildpath}/examples/skhdrc"
  end

  def caveats; <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

    If you want skhd to be managed by launchd (start automatically upon login):
      skhd --start-service

    When running as a launchd service logs will be found in:
      /tmp/skhd_<user>.[out|err].log
    EOS
  end

  test do
    assert_match "skhd-v#{version}", shell_output("#{bin}/skhd --version")
  end
end
