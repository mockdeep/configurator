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

    def method_missing(name, *args, &block)
      if internal_config.keys.include?(name.to_sym)
        internal_config[name.to_sym]
      else
        super
      end
    end
  end
end
