$:.unshift File.dirname(__FILE__)

require 'configurator/extension_methods'

module Configurator
  include Configurator::ExtensionMethods
  def self.extended( mod )
    mod.module_eval { include Configurator::ExtensionMethods }
  end
end
