# frozen_string_literal: true
RSpec.describe Configurator do
  class TestConfig

    attr_reader :test_thing
    include Configurator

    config :some_config

    def initialize
      @test_thing = 'testy'
    end

  end

  describe '#initialize' do
    it 'does not conflict with host class #initialize method' do
      expect(TestConfig.new.test_thing).to eq 'testy'
    end

    it 'raises an error when given an invalid configuration key' do
      TestConfig.loaded_config = { boo: 'gers' }
      message = /invalid configuration/
      expect do
        TestConfig.new
      end.to raise_error(Configurator::ConfigurationError, message)
    end

    it 'does not clobber nested configuration when overridden' do
      TestConfig.loaded_config = { some_config: %w(yo).freeze }.freeze
      one_config = TestConfig.new
      expect do
        one_config.some_config << 'yoma'
      end.not_to change(TestConfig, :loaded_config).from(some_config: %w(yo))
      expect(one_config.some_config).to eq(%w(yo yoma))
    end
  end
end
