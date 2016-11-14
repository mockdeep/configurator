# frozen_string_literal: true
module Configurator
  module ClassMethods
    def config(key, default: nil)
      default_config[key] = default
    end

    def default_config
      @default_config ||= {}
    end
  end
end
