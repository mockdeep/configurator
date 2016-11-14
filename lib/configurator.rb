# frozen_string_literal: true
require_relative 'configurator/class_methods'
require_relative 'configurator/instance_methods'

module Configurator
  include Configurator::InstanceMethods
  def self.included(base)
    base.public_send :extend, Configurator::ClassMethods
  end
end
