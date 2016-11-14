# frozen_string_literal: true
module Configurator
  module InstanceMethods

  private

    def internal_config
      @config ||= self.class.default_config.dup
    end

    def config(key, value = nil)
      if value
        internal_config[key] = value
      else
        internal_config[key]
      end
    end
  end
end
