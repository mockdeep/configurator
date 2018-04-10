# frozen_string_literal: true

RSpec.describe Configurator::ConfigLoader do
  let(:expected_bar) { { boo: 'bloop', testy_test: '4 cheeseburgers' } }

  it 'loads config with ERB' do
    require_relative '../fixtures/test_library/lib/test_library/test_class'
    loaded_config = TestLibrary::TestClass.loaded_config
    expect(loaded_config[:bar]).to eq(expected_bar)
  end

  it 'loads default configurations from project root' do
    require_relative '../fixtures/test_library/lib/test_library/test_class'
    expect(TestLibrary::TestClass.loaded_config[:foo]).to eq 'blah'
    loaded_config = TestLibrary::TestClass.loaded_config
    expect(loaded_config[:foo]).to eq('blah')
    expect(loaded_config[:bar]).to eq(expected_bar)
    expect(loaded_config.keys).not_to include(:here)
  end

  it 'loads configurations from the current directory' do
    Dir.chdir(File.join(File.dirname(__FILE__), '..', 'fixtures')) do
      load './test_library/lib/test_library/test_class.rb'
      expect(TestLibrary::TestClass.loaded_config[:foo]).to eq 'another foo'

      loaded_config = TestLibrary::TestClass.loaded_config
      expect(loaded_config[:foo]).to eq('another foo')
      expect(loaded_config[:bar]).to eq(expected_bar)
      expect(loaded_config[:here]).to eq(I: 'am')
    end
  end

  it 'loads configurations from the home directory' do
    home_file_path = File.expand_path('~/.test_library.yml')
    begin
      File.write(home_file_path, "home: home config\nfoo: home foo\nbar: bugs")
      Dir.chdir(File.join(File.dirname(__FILE__), '..', 'fixtures')) do
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
