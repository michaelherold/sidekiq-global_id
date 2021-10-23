# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

# Defines a Rake task if the optional dependency is installed
#
# @return [nil]
def with_optional_dependency
  yield if block_given?
rescue LoadError # rubocop:disable Lint/SuppressedException
end

default = %w[test]

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/sidekiq/global_id/**/*_test.rb"]
end

namespace :test do
  task :integration do
    FileList["test/integration/**/*_test.rb"].each do |file|
      suite = File.basename(file).sub("_test.rb", "")
      sh "SUITE=#{suite} ruby #{file}"
    end
  end
end

with_optional_dependency do
  require "inch/rake"
  Inch::Rake::Suggest.new(:inch)

  default << "inch"
end

with_optional_dependency do
  require "rubocop/rake_task"

  RuboCop::RakeTask.new(:rubocop)
  default << "rubocop"
end

with_optional_dependency do
  require "yard-doctest"

  task "yard:doctest" do
    sh "yard doctest"
  end

  default << "yard:doctest"
end

with_optional_dependency do
  require "yard/rake/yardoc_task"
  YARD::Rake::YardocTask.new(:yard)

  default << "yard"
end

with_optional_dependency do
  require "yardstick/rake/measurement"
  options = YAML.load_file(".yardstick.yml")
  Yardstick::Rake::Measurement.new("yardstick:measure", options) do |measurement|
    measurement.output = "coverage/docs.txt"
  end

  require "yardstick/rake/verify"
  options = YAML.load_file(".yardstick.yml")
  Yardstick::Rake::Verify.new("yardstick:verify", options) do |verify|
    verify.threshold = 100
  end

  task yardstick: %i[yardstick:measure yardstick:verify]
end

task default: default
