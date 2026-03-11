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
  version "0.1.7"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "135c81417c1ea86cd9199bffce60fcc333c07466c410a8be073bcef1d6801c0c"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.7/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "1f10cfe2d6a6277ec3b4ebe4993045e703a71500ad6d7bc4fe01fb451aa159dc"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.7/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "21e13fd14cd3f1c5fab57470e06bd184ebf6a3ca2f359990de947ee72e8039f7"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.7.tar.gz"
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
