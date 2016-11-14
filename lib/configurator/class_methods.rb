# frozen_string_literal: true
module Configurator
  module ClassMethods
    attr_reader :default_config

    def config(key, default: nil)
      default_config[key] = default

      define_method(key) { config[key] }
      define_method("#{key}=") { |value| config[key] = value }
    end

    def default_config=(default_config)
      @default_config = default_config

      default_config.each { |key, value| config(key, default: value) }
    end
  end
end
