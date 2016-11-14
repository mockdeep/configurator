# frozen_string_literal: true
module Configurator
  module ClassMethods
    def config(key = nil, value = nil)
      @__config ||= {}
      if key && value
        @__config[key] = value
      elsif key
        return @__config[key]
      end
    end

    def class_config
      @__config
    end
  end
end
