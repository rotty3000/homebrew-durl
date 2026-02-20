class Durl < Formula
  desc "A simple command-line tool for parsing and formatting URLs, a Rust port of gurl"
  homepage "https://github.com/rotty3000/durl"
  license "MIT"
  version "0.1.4"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "b0a395bad556cc668b401dbebb5d53a449721bfdf67d0335347955d471e850a5"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.4/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "efbbf7db10f8cfcf15a8cd3592cf69e0901cb87a66744845fc8c36763dc2a0ce"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.4/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "96e4b51402130e33323f3317d51323018d6cf1fc15085b47431feb4b97575660"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.4.tar.gz"
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
