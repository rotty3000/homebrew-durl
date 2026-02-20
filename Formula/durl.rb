class Durl < Formula
  desc "A simple command-line tool for parsing and formatting URLs, a Rust port of gurl"
  homepage "https://github.com/rotty3000/durl"
  license "MIT"
  version "0.1.0"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.0/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.0/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.0.tar.gz"
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
