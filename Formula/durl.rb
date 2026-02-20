class Durl < Formula
  desc "A simple command-line tool for parsing and formatting URLs, a Rust port of gurl"
  homepage "https://github.com/rotty3000/durl"
  license "MIT"
  version "0.1.2"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "63802899537f1e2cc4d491a0c5971d9648c96f701b844589031956ab74a24220"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.2/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "9b16896a33321d606c2bed3154aa3521b9ab28fad4ca82e0f4221256019609cd"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.2/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "6cd3da8a0f9421dbf5606512eed9198c50c886ca695e7d59ce5d31fdc5093b0b"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.2.tar.gz"
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
