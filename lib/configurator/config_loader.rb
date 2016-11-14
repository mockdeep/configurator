# frozen_string_literal: true
require 'active_support/inflector/methods'
require 'active_support/core_ext/hash/keys'
require 'yaml'

module Configurator
  class ConfigLoader

    def call(class_name:, call_site:)
      class_path = ActiveSupport::Inflector.underscore(class_name)
      library_name = class_path.split('/').first
      library_config_path = ".#{library_name}.yml"
      library_config(class_path, call_site)
        .merge(home_config(library_config_path))
        .merge(pwd_config(library_config_path))
    end

  private

    def pwd_config(library_config_name)
      pwd_config_path = File.join(Dir.pwd, library_config_name)
      load_yaml(pwd_config_path)
    end

    def home_config(library_config_name)
      home_config_path = File.join(Dir.home, library_config_name)
      load_yaml(home_config_path)
    end

    def library_config(class_path, call_site)
      file_path = call_site.split('.rb:').first
      project_path = file_path.chomp(File.join('lib', class_path))
      lib_config_path = File.join(project_path, 'config', 'default.yml')
      load_yaml(lib_config_path)
    end

    def load_yaml(path)
      File.exist?(path) ? YAML.load(File.read(path)).deep_symbolize_keys : {}
    end

  end
end
