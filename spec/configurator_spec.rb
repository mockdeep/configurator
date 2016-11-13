# frozen_string_literal: true
class SampleClass

  extend Configurator
  config :name, 'sample'
  config :address, '127.0.0.1'
  config :array, [1, 2, 3]
  config :hash, foo: 1, bar: 2, baz: 3

end

class SampleChildClass < SampleClass

  config :name, 'child'
  config :array, [4, 5, 6]

end

RSpec.describe Configurator do
  it 'allows assignment of configurations' do
    sample = SampleClass.new
    expect(sample).to be
    expect(sample.config[:name]).to eq 'sample'
    expect(sample.config[:address]).to eq '127.0.0.1'
    expect(sample.config[:array]).to eq [1, 2, 3]
    expect(sample.config[:hash][:foo]).to eq 1
    expect(sample.config[:hash][:bar]).to eq 2
    expect(sample.config[:hash][:baz]).to eq 3

    sample.config[:name] = 'mac'
    expect(sample.config[:name]).to eq 'mac'

    sample.config :boo, 12
    expect(sample.config[:boo]).to eq 12

    sample2 = SampleClass.new
    expect(sample2.config[:boo]).to eq nil
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

  it 'allows for sub-classing' do
    sample = SampleChildClass.new
    expect(sample.config[:name]).to eq 'child'
    expect(sample.config[:address]).to eq '127.0.0.1'
    expect(sample.config[:array]).to eq [4, 5, 6]
    expect(sample.config[:hash][:foo]).to eq 1
    expect(sample.config[:hash][:bar]).to eq 2
    expect(sample.config[:hash][:baz]).to eq 3

    sample.config[:name] = 'mac'
    expect(sample.config[:name]).to eq 'mac'

    sample.config :giz, 12
    expect(sample.config[:giz]).to eq 12

    sample2 = SampleChildClass.new
    expect(sample2.config[:giz]).to eq nil

    sample3 = SampleClass.new
    expect(sample3.config[:giz]).to eq nil

    SampleClass.config :giz, 999
    expect(sample.config[:giz]).to eq 12
    expect(sample2.config[:giz]).to eq 999
  end
end
