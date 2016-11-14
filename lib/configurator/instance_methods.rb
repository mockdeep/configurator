# frozen_string_literal: true
module Configurator
  module InstanceMethods
    def config(key, value = nil)
      @config ||= self.class.default_config.dup
      if value
        @config[key] = value
      else
        @config[key]
      end
    end

  private

    def method_missing(name, *args, &block)
      if __config.keys.include?(name.to_sym)
        __config[name.to_sym]
      else
        super
      end
    end
  end
end
