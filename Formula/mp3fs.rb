class Mp3fs < Formula
  desc "Read-only FUSE file system: transcodes audio formats to MP3"
  homepage "https://khenriks.github.io/mp3fs/"
  url "https://github.com/khenriks/mp3fs/releases/download/v1.0/mp3fs-1.0.tar.gz"
  sha256 "cbb52062d712e8dfd3491d0b105e2e05715d493a0fd14b53a23919694a348069"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any, catalina:    "26d991c2fb34055035c01d12033f28b5a694954ad9b3f650658dfa1ebc9994ea"
    sha256 cellar: :any, mojave:      "a9f6095147b767a892891bdc0a44b61eef40880e38bc50e54c0a30d96de89985"
    sha256 cellar: :any, high_sierra: "b3b2e431e9a782dbde9d758505c372a0d6ed60eff44ebc21c9b979c01b0df189"
  end

  depends_on "pkg-config" => :build
  depends_on "flac"
  depends_on "lame"
  depends_on "libid3tag"
  depends_on "libvorbis"

  on_macos do
    disable! date: "2021-04-08", because: "requires FUSE (see https://github.com/Homebrew/homebrew-core/pull/64491)"
  end

  on_linux do
    depends_on "libfuse"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "mp3fs version: #{version}", shell_output("#{bin}/mp3fs -V")
  end
end
