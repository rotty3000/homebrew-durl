class Durl < Formula
  desc "A simple command-line tool for parsing and formatting URLs, a Rust port of gurl"
  homepage "https://github.com/rotty3000/durl"
  license "MIT"
  version "0.1.3"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "820d3fcc57b2f7818eca39058a6010b48852982205e2b4a7889d7a3ef211aad1"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.3/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "b05664b7003fa608c5302c6d8e21e00d7f9fcd3314ebf26a1a552c4b92105920"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.3/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "3721fd64829bbb44877eb33ee202a4a6a3397f5bd8b8f631af30331e6ed8af5c"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.3.tar.gz"
  end

  def install
    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "durl-linux-amd64" => "durl"
      elsif Hardware::CPU.arm?
        bin.install "durl-linux-arm64" => "durl"
      end
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "https", shell_output("#{bin}/durl +%s https://google.com")
  end
end
