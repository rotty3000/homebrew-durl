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
  version "0.1.1"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "5f57c88204c1199653ec496fba7712891e0398a6742708e4a59c81f5c55440b3"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.1/verz-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "e9bac22bf3c79d31d4723ff42040280a587155bb96e4438e1a5f45f6366deb17"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.1/verz-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "cfe4b0f82c7d8bc6616b1fbaf8d1db0937b798e70756ec69929dc5e9eb863162"
    url "https://github.com/rotty3000/verz/archive/refs/tags/v0.1.1.tar.gz"
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
