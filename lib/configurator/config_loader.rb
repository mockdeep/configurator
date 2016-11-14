# frozen_string_literal: true
require 'active_support/inflector/methods'
require 'active_support/core_ext/hash/keys'
require 'yaml'

module Configurator
  class ConfigLoader

    def call(class_name:, call_site:)
      library_config(class_name, call_site)
    end

  private

    def library_config(class_name, call_site)
      class_path = ActiveSupport::Inflector.underscore(class_name)
      file_path = call_site.split('.rb:').first
      project_path = file_path.chomp(File.join('lib', class_path))
      config_path = File.join(project_path, 'config', 'default.yml')
      if File.exist?(config_path)
        YAML.load(File.read(config_path)).deep_symbolize_keys
      else
        {}
      end
    end

  end
end
