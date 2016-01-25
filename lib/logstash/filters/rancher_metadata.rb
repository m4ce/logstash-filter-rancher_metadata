# encoding: utf-8

require "logstash/filters/base"
require "logstash/namespace"
require 'lru_redux'
require 'rancher-metadata/api'

class LogStash::Filters::RancherMetadata < LogStash::Filters::Base
  config_name "rancher_metadata"

  config :api_url,
    :validate => :array,
    :default => [],
    :required => false,
    :deprecated => false

  config :field_docker_id,
    :validate => :string,
    :default => 'path',
    :required => false,
    :deprecated => false

  config :tags,
    :validate => :array,
    :default => ["name", "primary_ip", "service_name", "stack_name"],
    :required => false,
    :deprecated => false

  config :cache_size,
    :validate => :number,
    :default => 100,
    :required => false,
    :deprecated => false

  def get_metadata(container_id)
    @metadata_api.get_containers.each do |container|
      return if container['uuid'] == container_id
    end

    nil
  end

  public
  def register
    # Add instance variables
    @metadata_api = RancherMetadata::API.new({:api_url => @api_url})

    @cache = LruRedux::ThreadSafeCache.new(@cache_size)
  end # def register

  public
  def filter(event)
    if event[@field_docker_id]
      container_id = event[@field_docker_id]
      metadata = @cache.getset(container_id){self.get_metadata(container_id)}
    end

    if metadata
      event['rancher'] = {}

      @tags.each do |tag|
        event['rancher'][tag] = metadata[tag]
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::RancherMetadata
