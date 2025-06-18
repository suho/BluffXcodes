class Bluffxcodes < Formula
  desc "CLI tool to bluff Xcode bundle versions"
  homepage "https://github.com/suho/bluffxcodes"
  license "MIT"
  head "https://github.com/suho/bluffxcodes.git"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/bluffxcodes"
  end

  test do
    system "#{bin}/bluffxcodes", "--help"
  end
end
