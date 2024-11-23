# frozen_string_literal: true

require_relative "sqlean/version"

# https://github.com/nalgeon/sqlean/blob/main/README.md
module SQLean
  # Returns an absolute path to the SQLean bundle, containing all the SQLean extensions.
  def self.sqlite_extension_path
    File.join(__dir__, "sqlean", "dist", "sqlean.so")
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/crypto.md
  module Crypto
    # Returns an absolute path to the SQLean crypto extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "crypto.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/define.md
  module Define
    # Returns an absolute path to the SQLean define extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "define.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/fileio.md
  module FileIO
    # Returns an absolute path to the SQLean fileio extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "fileio.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/fuzzy.md
  module Fuzzy
    # Returns an absolute path to the SQLean fuzzy extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "fuzzy.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/ipaddr.md
  module IPAddr
    # Returns an absolute path to the SQLean ipaddr extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "ipaddr.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/math.md
  module Math
    # Returns an absolute path to the SQLean math extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "math.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/regexp.md
  module Regexp
    # Returns an absolute path to the SQLean regexp extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "regexp.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/stats.md
  module Stats
    # Returns an absolute path to the SQLean stats extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "stats.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/text.md
  module Text
    # Returns an absolute path to the SQLean text extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "text.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/unicode.md
  module Unicode
    # Returns an absolute path to the SQLean unicode extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "unicode.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/uuid.md
  module UUID
    # Returns an absolute path to the SQLean uuid extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "uuid.so")
    end
  end

  # https://github.com/nalgeon/sqlean/blob/main/docs/vsv.md
  module VSV
    # Returns an absolute path to the SQLean vsv extension.
    def self.sqlite_extension_path
      File.join(__dir__, "sqlean", "dist", "vsv.so")
    end
  end
end
