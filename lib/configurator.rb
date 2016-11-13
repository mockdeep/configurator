# frozen_string_literal: true
require_relative 'configurator/class_methods'
require_relative 'configurator/extension_methods'

module Configurator
  include Configurator::ExtensionMethods
  def self.included(base)
    base.public_send :extend, Configurator::ClassMethods
    base.public_send :extend, Configurator::ExtensionMethods
    base.public_send :include, Configurator::ExtensionMethods
  end
end
