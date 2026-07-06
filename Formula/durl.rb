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
  version "0.1.8"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "3d3bd92fc3a23306b8942daed29c00d7180e223b13f170fe9a899f453426114c"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.8/durl-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "5c66153aae2a3575254d225371f89b32649e6e270d6ffc78aadc3981a87b1f4e"
      url "https://github.com/rotty3000/durl/releases/download/v0.1.8/durl-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "eb2f3693915a08776fd0a513b56164f0c0299333858eb74b28cb3bff642115f7"
    url "https://github.com/rotty3000/durl/archive/refs/tags/v0.1.8.tar.gz"
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
