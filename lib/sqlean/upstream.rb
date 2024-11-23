# frozen_string_literal: true

module SQLean
  module Upstream
    VERSION = "0.27.1"

    # rubygems platform name => upstream release filename fragment
    NATIVE_PLATFORMS = {
      "aarch64-linux" => "linux-arm64",
      "x86_64-linux" => "linux-x86",

      "arm64-darwin" => "macos-arm64",
      "x86_64-darwin" => "macos-x86",

      "x64-mingw" => "win-x64"
    }
  end
end
