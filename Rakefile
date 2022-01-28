
source_files = Rake::FileList.new("**/*.rhtml") do |file_list|
  file_list.exclude("~*")
  file_list.exclude do |f|
    `git ls-files #{f}`.empty?
  end
end

task default: :html
task html: source_files.ext(".html")

rule ".html" => [".rhtml", "helpers.rb"] do |t|
  sh "erb #{t.source} &> #{t.name}"
end


begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "**{,/*/**}/*_spec.rb"
  end

  task default: %w[spec html]
rescue LoadError
  # no rspec available
end
