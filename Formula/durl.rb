# Copyright 2026 Raymond Auge <rayauge@doublebite.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Durl < Formula
  desc "A simple command-line tool for parsing and formatting URLs, a Rust port of gurl"
  homepage "https://github.com/rotty3000/durl"
  license "MIT"
  version "0.1.6"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "9264f5e070b791f3a7e208e84aebf37507056ba999dfff86a4967c0b51bbf106"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.6/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "714e5c8c998de4d54cabb6e7bfc8a302ee03e00f7e08b44a9c7cee43ebf5b424"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.6/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "6a48862fb8b5ea40fea20df42c4457a6633e5454689759484efbb6ad8d04a72f"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.6.tar.gz"
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
