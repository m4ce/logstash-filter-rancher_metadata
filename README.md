# Logstash Plugin

This is a plugin for [Logstash](https://github.com/elasticsearch/logstash).

This filter add rancher metadata to messages that contain a Docker container ID.

At current, the filter enriches the messages with the following tags
- Container name (name)
- Container IP (primary_ip)
- Container service name (service_name)
- Container stack name (stack_name)

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Usage

Configuration used : `logstash agent -e "filter { rancher_metadata {} }"`

```
## Filter parameters

| name                  | default value                 | comment |
| :-------------         | :-------------                 | :------------- |
| `api_url`          | `[]` | Rancher Metadata API URL |
| `field_docker_id` | `'container_id'`                    | The docker container ID message field |
| `cache_size`          | 100                           |  |

## Developing

### 1. Plugin Developement and Testing

#### Code
- To get started, you'll need JRuby with the Bundler gem installed.

- Install dependencies
```sh
bundle install
```

#### Test
There are no tests units.

#### Build gem
```sh
gem build logstash-filter-rancher_metadata.gemspec
```

### 2. Running your unpublished Plugin in Logstash

#### 2.1 Run in a local Logstash clone

- Edit Logstash `Gemfile` and add the local plugin path, for example:
```ruby
gem "logstash-filter-rancher_metadata", :path => "/your/local/logstash-filter-rancher_metadata"
```
- Install plugin
```sh
bin/plugin install --no-verify
```
- Run Logstash with your plugin
```sh
bin/logstash -e 'filter { rancher_metadata {} }'
```
At this point any modifications to the plugin code will be applied to this local Logstash setup. After modifying the plugin, simply rerun Logstash.

#### 2.2 Run in an installed Logstash

You can use the same **2.1** method to run your plugin in an installed Logstash by editing its `Gemfile` and pointing the `:path` to your local plugin development directory or you can build the gem and install it using:

- Build your plugin gem
```sh
gem build logstash-filter-rancher_metadata.gemspec
```
- Install the plugin from the Logstash home
```sh
bin/plugin install /your/local/plugin/logstash-filter-rancher_metadata.gem
```
- Start Logstash and proceed to test the plugin

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members  saying "send patches or die" - you will not see that here.

It is more important to the community that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elasticsearch/logstash/blob/master/CONTRIBUTING.md) file.

## Author
Matteo Cerutti - <matteo.cerutti@hotmail.co.uk>
