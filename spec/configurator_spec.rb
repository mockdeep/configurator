# frozen_string_literal: true
class SampleClass

  include Configurator
  config :name, default: 'sample'
  config :address, default: '127.0.0.1'
  config :array, default: [1, 2, 3]
  config :hash, default: { foo: 1, bar: 2, baz: 3 }

end

RSpec.describe Configurator do
  it 'does not allow hash access to config' do
    sample = SampleClass.new
    expect do
      sample.config[:name]
    end.to raise_error(NoMethodError)
  end

  it 'does not allow calling on the class' do
    expect do
      SampleClass.address
    end.to raise_error(NoMethodError)
  end

  it 'allows assignment of configurations' do
    sample = SampleClass.new
    expect(sample).to be
    expect(sample.config(:name)).to eq 'sample'
    expect(sample.config(:address)).to eq '127.0.0.1'
    expect(sample.config(:array)).to eq [1, 2, 3]
    expect(sample.config(:hash)[:foo]).to eq 1
    expect(sample.config(:hash)[:bar]).to eq 2
    expect(sample.config(:hash)[:baz]).to eq 3

    sample.config(:name, 'mac')
    expect(sample.config(:name)).to eq 'mac'

    sample.config :boo, 12
    expect(sample.config(:boo)).to eq 12

    sample2 = SampleClass.new
    expect(sample2.config(:boo)).to eq nil
  end

  it 'returns the given key when passed' do
    sample = SampleClass.new
    expect(sample.config(:name)).to eq 'sample'
    expect(sample.config(:address)).to eq '127.0.0.1'
  end

  xit 'allows direct access of configurations' do
    sample = SampleClass.new
    expect(sample.name).to eq 'sample'
    expect(sample.address).to eq '127.0.0.1'
  end
end
