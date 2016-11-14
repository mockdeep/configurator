# frozen_string_literal: true
module Configurator
  module ClassMethods
    def config(key, value = nil)
      default_config[key] = value
    end

    def default_config
      @default_config ||= {}
    end
  end
end
