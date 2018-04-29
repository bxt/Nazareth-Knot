
source_files = Rake::FileList.new("**/*.rhtml") do |file_list|
  file_list.exclude("~*")
  file_list.exclude do |f|
    `git ls-files #{f}`.empty?
  end
end

task default: :html
task html: source_files.ext(".html")

rule ".html" => ".rhtml" do |t|
  sh "erb #{t.source} &> #{t.name}"
end
