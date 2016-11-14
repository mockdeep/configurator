# frozen_string_literal: true
module Configurator
  module InstanceMethods
    def config(key = nil, value = nil)
      @__self_config ||= {}
      @__config = __check_config
      if key && value
        @__self_config[key] = value
        @__config = __merge_config
        return value
      elsif key
        return @__config[key]
      end
    end

  private

    def __merge_config
      __default_config.merge(@__self_config)
    end

    def __check_config
      @__config ||= {}
      __config = __merge_config
      @__config.each do |k, v|
        @__self_config[k] = v unless __config[k] == v
      end
      @__config = __merge_config
    end

    def __default_config
      if respond_to?(:ancestors)
        {}
      else
        self.class.class_config
      end
    end

    def method_missing(name, *args, &block)
      if @__config.keys.include?(name.to_sym)
        @__config[name.to_sym]
      else
        super
      end
    end
  end
end
