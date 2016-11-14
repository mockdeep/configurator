# frozen_string_literal: true
module Configurator
  module ClassMethods
    def config(key, default: nil)
      default_config[key] = default
      define_method(key) do
        config[key]
      end

      define_method("#{key}=") do |value|
        config[key] = value
      end
    end

    def default_config
      @default_config ||= {}
    end
  end
end
