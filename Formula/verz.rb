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

class Verz < Formula
  desc "A semver management tool similar to npm version, implemented in Rust"
  homepage "https://github.com/rotty3000/verz"
  license "Apache-2.0"
  version "0.1.4"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "7f415e2133779726029410021871d92a1e853db24348374f8e79cd0e4cc52c6a"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.4/verz-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "4daf08715a5024c81198bec96c68a779fad69c38f33ffcb18cdad72c459466d2"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.4/verz-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "a439de6891cf5a4c3059e7635c8d39b11e4bda212530378c67ae3ea0018fb482"
    url "https://github.com/rotty3000/verz/archive/refs/tags/v0.1.4.tar.gz"
  end

  def install
    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "verz-linux-amd64" => "verz"
      elsif Hardware::CPU.arm?
        bin.install "verz-linux-arm64" => "verz"
      end
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "v0.1.0", shell_output("#{bin}/verz --version")
  end
end
