# frozen_string_literal: true
require_relative 'support/coverage'
require_relative '../lib/configurator'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
end
