# frozen_string_literal: true

begin
  require "standard/rake"
  task "default" => "standard"
rescue LoadError
  warn "NOTE: Standard is not loaded in this environment."
end
