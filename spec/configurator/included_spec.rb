# frozen_string_literal: true
RSpec.describe Configurator do
  class TestConfig

    attr_reader :test_thing
    include Configurator

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
  end
end
