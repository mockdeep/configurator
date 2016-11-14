# frozen_string_literal: true
module Configurator
  module InstanceMethods
    def config(key, value = nil)
      if value
        internal_config[key] = value
      else
        internal_config[key]
      end
    end

  private

    def internal_config
      @config ||= self.class.default_config.dup
    end
  end
end
