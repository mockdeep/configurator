# frozen_string_literal: true
module Configurator
  module ExtensionMethods
    def config(key = nil, value = nil)
      @__self_config ||= {}
      @__config = __check_config
      if key && value
        @__self_config[key] = value
        @__config = __merge_config
        return value
      elsif key
        return @__config[key]
      else
        return @__config
      end
    end

  private

    def __merge_config
      __inherited_config.merge(@__self_config)
    end

    def __check_config
      @__config ||= {}
      __config = __merge_config
      @__config.each do |k, v|
        @__self_config[k] = v unless __config[k] == v
      end
      @__config = __merge_config
    end

    def __inherited_config
      if respond_to?(:ancestors)
        @__inherited_config = {}
        ancestors[1..(ancestors.size - 1)].each do |ancestor|
          if ancestor.respond_to?(:config) && ancestor.config.is_a?(Hash)
            @__inherited_config = ancestor.config.merge(@__inherited_config)
          end
        end
      else
        @__inherited_config = self.class.config
      end
      @__inherited_config
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
