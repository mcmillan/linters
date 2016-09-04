require "yaml"

module Linters
  class Config
    def initialize(content:, default_config_path:)
      @content = content
      @default_config_path = default_config_path
    end

    def to_yaml
      to_hash.to_yaml
    end

    def to_json
      to_hash.to_json
    end

    private

    attr_reader :content, :default_config_path

    def custom_config
      YAML.safe_load(content, [Regexp]) || {}
    end

    def to_hash
      default_config.merge(custom_config)
    end

    def default_config
      YAML.safe_load(default_content, [Regexp])
    end

    def default_content
      File.read(default_config_path)
    end
  end
end
