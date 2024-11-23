#
#  Rake tasks to manage native gem packages with precompiled extensions from https://github.com/nalgeon/sqlean
#
#  TL;DR: run "rake package"
#
#  The native platform gems (defined by SQLean::Upstream::NATIVE_PLATFORMS) will each contain
#  a set of precompiled sqlite extension files:
#
#     lib/
#     └─ sqlean/
#        └─ #{Gem::Platform architecture name}/
#           ├─ crypto.#{DLEXT}
#           ├─ uuid.#{DLEXT}
#           └─ ...
#
#  As a concrete example, an x86_64-linux system will see these files on disk after installation:
#
#     lib/
#     └─ sqlean/
#        └─ x86_64-linux/
#           ├─ crypto.so
#           ├─ uuid.so
#           └─ ...
#
#  So the full set of gem files created will be:
#
#  - pkg/sqlean-1.0.0-aarch64-linux.gem
#  - pkg/sqlean-1.0.0-arm64-darwin.gem
#  - pkg/sqlean-1.0.0-x64-mingw.gem
#  - pkg/sqlean-1.0.0-x86_64-darwin.gem
#  - pkg/sqlean-1.0.0-x86_64-linux.gem
#
#  Note that we do not ship a vanilla "ruby" gem.
#
#
#  New rake tasks created:
#
#  - rake package            # Build all the gem files
#  - rake repackage          # Force a rebuild of all the gem files
#  - rake gem:aarch64-linux  # Build the aarch64-linux gem
#  - rake gem:x86_64-linux   # Build the x86_64-linux gem
#  - rake gem:arm64-darwin   # Build the arm64-darwin gem
#  - rake gem:x86_64-darwin  # Build the x86_64-darwin gem
#  - rake gem:x64-mingw      # Build the x64-mingw gem
#  - rake download           # Download all sqlean extension files
#
require_relative "../lib/sqlean/upstream"

require "open-uri"
require "rake/clean"
require "rubygems/package_task"
require "zip"

#
#  downloading and unzipping
#
def sqlean_download_url(filename)
  "https://github.com/nalgeon/sqlean/releases/download/#{SQLean::Upstream::VERSION}/sqlean-#{filename}.zip"
end

archive = "archive"
directory archive
CLOBBER.add archive

dist = "lib/sqlean/dist"
directory dist
CLOBBER.add dist

# nodoc
task "unzip"

desc "Download and unzip all the precompiled sqlean extensions"
task "download" => "unzip"

SQLean::Upstream::NATIVE_PLATFORMS.each do |platform, filename|
  release_url = sqlean_download_url(filename)
  zip_path = File.join(archive, "sqlean-#{filename}.zip")

  install_path = File.join(dist, platform)
  directory install_path

  file zip_path => archive do
    warn "Downloading #{zip_path} from #{release_url} ..."
    OpenURI.open_uri(release_url) do |remote|
      File.binwrite(zip_path, remote.read)
    end
  end

  task "unzip:#{platform}" => [zip_path, install_path] do
    Zip::File.open(zip_path) do |zip|
      warn "Unzipping #{zip_path} ..."
      zip.each do |file|
        new_path = File.join(install_path, file.name)
        puts "extracting: #{file.name.inspect} → #{new_path.inspect} ..."

        FileUtils.rm(new_path) if File.exist?(new_path)

        file.restore_permissions = true
        file.extract(new_path)
      end
    end
  end

  desc "download and unzip extensions for #{platform}"
  task "download:#{platform}" => "unzip:#{platform}"

  task "download" => "download:#{platform}"
  task "unzip" => "unzip:#{platform}"
end

#
#  packaging
#
SQLEAN_GEMSPEC = Bundler.load_gemspec("sqlean.gemspec")

desc "Build all the gem files"
task "package" => "download"

desc "Rebuild all the gem files"
task "repackage" => ["clobber", "package"]

SQLean::Upstream::NATIVE_PLATFORMS.each do |platform, filename|
  desc "Build the #{platform} gem"
  task "gem:#{platform}" => "download:#{platform}" do
    gemspec = SQLEAN_GEMSPEC.dup
    gemspec.platform = platform
    gemspec.files += Dir.glob(File.join(dist, platform, "*"))

    gem_task = Gem::PackageTask.new(gemspec).define
    gem_task.invoke
  end

  task "package" => "gem:#{platform}"
end

CLOBBER.add("pkg")
