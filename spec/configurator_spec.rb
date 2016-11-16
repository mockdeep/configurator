# frozen_string_literal: true
RSpec.describe Configurator do
  class SampleClass

    include Configurator

    config :name
    config :address

  end

  let(:sample) { SampleClass.new }

  it 'does not allow calling properties on the class' do
    expect do
      SampleClass.address
    end.to raise_error(NoMethodError)
  end

  it 'does not allow calling config on instance' do
    expect do
      sample.config(:address)
    end.to raise_error(NoMethodError)
  end

  it 'does not allow referencing arbitrary properties' do
    expect do
      sample.boo
    end.to raise_error(NoMethodError)
  end

  it 'does not allow assigning arbitrary properties' do
    expect do
      sample.boo = 12
    end.to raise_error(NoMethodError)
  end

  it 'allows assignment of configurations' do
    sample.name = 'mac'
    expect(sample.name).to eq 'mac'
  end

  it 'does not infect other instances with changes' do
    SampleClass.loaded_config = { name: 'sample' }
    sample.name = 'mac'
    expect(sample.name).to eq 'mac'

    sample2 = SampleClass.new
    expect(sample2.name).to eq 'sample'
  end

  it 'allows direct access of configurations' do
    SampleClass.loaded_config = { address: '127.0.0.1', name: 'sample' }

    expect(sample.name).to eq 'sample'
    expect(sample.address).to eq '127.0.0.1'
  end

  it 'loads default configurations from project root' do
    require_relative 'fixtures/test_library/lib/test_library/test_class'
    expect(TestLibrary::TestClass.loaded_config[:foo]).to eq 'blah'
    loaded_config = TestLibrary::TestClass.loaded_config
    expect(loaded_config[:foo]).to eq('blah')
    expect(loaded_config[:bar]).to eq(boo: 'bloop')
    expect(loaded_config.keys).not_to include(:here)
  end

  it 'loads configurations from the current directory' do
    Dir.chdir(File.join(File.dirname(__FILE__), 'fixtures')) do
      load './test_library/lib/test_library/test_class.rb'
      expect(TestLibrary::TestClass.loaded_config[:foo]).to eq 'another foo'

      loaded_config = TestLibrary::TestClass.loaded_config
      expect(loaded_config[:foo]).to eq('another foo')
      expect(loaded_config[:bar]).to eq(boo: 'bloop')
      expect(loaded_config[:here]).to eq(I: 'am')
    end
  end

  it 'loads configurations from the home directory' do
    home_file_path = File.expand_path('~/.test_library.yml')
    begin
      File.write(home_file_path, "home: home config\nfoo: home foo\nbar: bugs")
      Dir.chdir(File.join(File.dirname(__FILE__), 'fixtures')) do
        load './test_library/lib/test_library/test_class.rb'
        expect(TestLibrary::TestClass.loaded_config[:foo]).to eq 'another foo'

        loaded_config = TestLibrary::TestClass.loaded_config
        expect(loaded_config[:foo]).to eq('another foo')
        expect(loaded_config[:bar]).to eq('bugs')
        expect(loaded_config[:here]).to eq(I: 'am')
        expect(loaded_config[:home]).to eq('home config')
      end
    ensure
      File.delete(home_file_path)
    end
  end
end
