# frozen_string_literal: true

require_relative "sqlean/version"
require_relative "sqlean/upstream"

# https://github.com/nalgeon/sqlean/blob/main/README.md
module SQLean
  class UnsupportedPlatform < StandardError; end

  GEM_NAME = "sqlean"

  # Returns an absolute path to the SQLean bundle, containing all the SQLean extensions.
  def self.sqlite_extension_path
    SQLean.file_path("sqlean")
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/crypto.md
  module Crypto
    # Returns an absolute path to the SQLean crypto extension.
    def self.sqlite_extension_path
      SQLean.file_path("crypto")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/define.md
  module Define
    # Returns an absolute path to the SQLean define extension.
    def self.sqlite_extension_path
      SQLean.file_path("define")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/fileio.md
  module FileIO
    # Returns an absolute path to the SQLean fileio extension.
    def self.sqlite_extension_path
      SQLean.file_path("fileio")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/fuzzy.md
  module Fuzzy
    # Returns an absolute path to the SQLean fuzzy extension.
    def self.sqlite_extension_path
      SQLean.file_path("fuzzy")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/ipaddr.md
  module IPAddr
    # Returns an absolute path to the SQLean ipaddr extension.
    def self.sqlite_extension_path
      SQLean.file_path("ipaddr")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/math.md
  module Math
    # Returns an absolute path to the SQLean math extension.
    def self.sqlite_extension_path
      SQLean.file_path("math")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/regexp.md
  module Regexp
    # Returns an absolute path to the SQLean regexp extension.
    def self.sqlite_extension_path
      SQLean.file_path("regexp")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/stats.md
  module Stats
    # Returns an absolute path to the SQLean stats extension.
    def self.sqlite_extension_path
      SQLean.file_path("stats")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/text.md
  module Text
    # Returns an absolute path to the SQLean text extension.
    def self.sqlite_extension_path
      SQLean.file_path("text")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/time.md
  module Time
    # Returns an absolute path to the SQLean text extension.
    def self.sqlite_extension_path
      SQLean.file_path("time")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/unicode.md
  module Unicode
    # Returns an absolute path to the SQLean unicode extension.
    def self.sqlite_extension_path
      SQLean.file_path("unicode")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/uuid.md
  module UUID
    # Returns an absolute path to the SQLean uuid extension.
    def self.sqlite_extension_path
      SQLean.file_path("uuid")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/vsv.md
  module VSV
    # Returns an absolute path to the SQLean vsv extension.
    def self.sqlite_extension_path
      SQLean.file_path("vsv")
    end
  end

  #
  #  "private" methods
  #
  def self.file_path(name) # :nodoc:
    File.join(SQLean.file_dir, name)
  end

  def self.file_dir # :nodoc:
    @file_arch ||= begin
      check_arch

      Dir.glob(File.join(__dir__, "sqlean", "dist", "*")).find do |f|
        Gem::Platform.match_gem?(Gem::Platform.new(File.basename(f)), GEM_NAME)
      end
    end
  end

  def self.check_arch # :nodoc:
    if SQLean::Upstream::NATIVE_PLATFORMS.keys.none? { |p| Gem::Platform.match_gem?(Gem::Platform.new(p), GEM_NAME) }
      raise UnsupportedPlatform, "#{GEM_NAME} does not support the #{platform} platform."
    end
  end

  # here mostly for testing purposes (to stub)
  def self.platform # :nodoc:
    RUBY_PLATFORM
  end
end
