# frozen_string_literal: true

require_relative "lib/sqlean/version"

Gem::Specification.new do |spec|
  spec.name = "sqlean"
  spec.version = SQLean::VERSION
  spec.authors = ["Mike Dalessio"]
  spec.email = ["mike.dalessio@gmail.com"]

  spec.summary = "Precompiled SQLean extensions for SQLite, packaged for the Ruby ecosystem."
  spec.description = <<~TEXT
    Precompiled SQLean extensions for SQLite, packaged for the Ruby ecosystem. Compatible with
    SQLite3, Extralite, and any other sqlite-based library that exposes sqlite3_load_extension.
  TEXT

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.homepage = "https://github.com/flavorjones/sqlean-ruby"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/blob/main/CHANGELOG.md"

  spec.metadata["rubygems_mfa_required"] = "true"

  # note that the extension files are injected by the rake task in rakelib/package.rake
  spec.files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "LICENSE-DEPENDENCIES.txt",
    "README.md",
    "lib/sqlean.rb",
    "lib/sqlean/version.rb",
    "lib/sqlean/upstream.rb"
  ]

  spec.require_paths = ["lib"]
end
