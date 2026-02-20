class Durl < Formula
  desc "A simple command-line tool for parsing and formatting URLs, a Rust port of gurl"
  homepage "https://github.com/rotty3000/durl"
  license "MIT"
  version "0.1.5"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "e85cffe6ad8dce0d47046380f9eaa25cf3cad09ef2463fd80d54d0cd07d7a3b3"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.5/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "65135c7577dd93b853412c73f707c06a429c0037f64cb8114fa6ae3f984b2315"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.5/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "f3ab1bdf584bcf649575375e96013123d8597d81baab6ae03dd891dd0af66e72"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.5.tar.gz"
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
