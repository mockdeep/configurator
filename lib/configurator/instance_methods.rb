# frozen_string_literal: true
require 'active_support/core_ext/object/deep_dup'

module Configurator
  module InstanceMethods
    def initialize
      validate_config
      loaded_config.deep_dup.each { |key, value| public_send("#{key}=", value) }
      super
    end

  private

    def loaded_config
      self.class.loaded_config
    end

    def configurable_options
      self.class.configurable_options
    end

    def validate_config
      extra_options = loaded_config.keys - configurable_options
      return if extra_options.empty?

      message = "invalid configuration options #{extra_options}"
      raise Configurator::ConfigurationError, message
    end
  end
end
