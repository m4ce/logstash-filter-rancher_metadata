Gem::Specification.new do |s|
  s.name = 'logstash-filter-rancher_metadata'
  s.version = '0.0.10'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter add rancher metadata to messages that contain a Docker container ID"
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Matteo Cerutti"]
  s.email = 'matteo.cerutti@hotmail.co.uk'
  s.homepage = "http://github.com/m4ce/logstash-filter-rancher_metadata"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0.0", "< 3.0.0"
  s.add_runtime_dependency "rancher-metadata", "0.0.5"
  s.add_runtime_dependency "lru_redux"

  s.add_development_dependency 'logstash-devutils'
end
