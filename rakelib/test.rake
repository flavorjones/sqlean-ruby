# frozen_string_literal: true

require "minitest/test_task"

Minitest::TestTask.create

task "test" => "download:local"
task "default" => "test"
