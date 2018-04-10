# frozen_string_literal: true

module Configurator
  module ClassMethods
    attr_accessor :loaded_config

    def config(key)
      configurable_options << key
      class_eval { attr_accessor key }
    end

    def configurable_options
      @configurable_options ||= []
    end
  end
end
