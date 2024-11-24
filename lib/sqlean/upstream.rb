# frozen_string_literal: true

module SQLean
  module Upstream
    # The version of upstream sqlean extensions used.
    VERSION = "0.27.1"

    # rubygems platform name => upstream release filename fragment
    NATIVE_PLATFORMS = {
      "aarch64-linux-gnu" => "linux-arm64",
      "x86_64-linux-gnu" => "linux-x86",
      "x86_64-linux-musl" => "linux-x86-musl",

      "arm64-darwin" => "macos-arm64",
      "x86_64-darwin" => "macos-x86",

      "x64-mingw" => "win-x64"
    }
  end
end
