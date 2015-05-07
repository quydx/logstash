namespace "docs" do

  task "generate" do
    Rake::Task['plugin:install-all'].invoke
    Rake::Task['docs:generate-docs'].invoke
    Rake::Task['docs:generate-index'].invoke
  end

  task "generate-docs" do
    require "bootstrap/environment"
    pattern = "#{LogStash::Environment.logstash_gem_home}/gems/logstash-*/lib/logstash/{input,output,filter,codec}s/*.rb"
    list    = Dir.glob(pattern).join(" ")
    cmd     = "bin/logstash docgen -o asciidoc_generated #{list}"
    system(cmd)
  end

  task "generate-index" do
    list = [ 'inputs', 'outputs', 'filters', 'codecs' ]
    list.each do |type|
      cmd = "ruby docs/asciidoc_index.rb asciidoc_generated #{type}"
      system(cmd)
    end
  end

end
