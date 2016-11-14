# frozen_string_literal: true
module Configurator
  module InstanceMethods
    def config(key = nil, value = nil)
      @__config = __check_config
      if key && value
        __self_config[key] = value
        @__config = __merge_config
        return value
      elsif key
        return __config[key]
      end
    end

  private

    def __self_config
      @__self_config ||= {}
    end

    def __merge_config
      self.class.default_config.merge(__self_config)
    end

    def __config
      @__config ||= {}
    end

    def __check_config
      __local_config = __merge_config
      __config.each do |k, v|
        __self_config[k] = v unless __local_config[k] == v
      end
      @__config = __merge_config
    end

    def method_missing(name, *args, &block)
      if __config.keys.include?(name.to_sym)
        __config[name.to_sym]
      else
        super
      end
    end
  end
end
