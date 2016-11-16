# frozen_string_literal: true
require_relative 'configurator/config_loader'
require_relative 'configurator/configuration_error'
require_relative 'configurator/class_methods'
require_relative 'configurator/instance_methods'

module Configurator
  def self.included(base)
    base.public_send :prepend, Configurator::InstanceMethods
    base.public_send :extend, Configurator::ClassMethods
    loader_options = { class_name: base.name, call_site: caller[3] }
    base.loaded_config = ConfigLoader.new.(loader_options)
  end
end
