# frozen_string_literal: true
module Configurator
  module InstanceMethods
    def initialize
      @config = self.class.default_config.dup
      super
    end

  private

    attr_reader :config
  end
end
