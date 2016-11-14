# frozen_string_literal: true
class SampleClass

  include Configurator
  config :name, default: 'sample'
  config :address, default: '127.0.0.1'
  config :array, default: [1, 2, 3]
  config :hash, default: { foo: 1, bar: 2, baz: 3 }

end

RSpec.describe Configurator do
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

  it 'does not allow assigning arbitrary properties' do
    expect do
      sample.boo = 12
    end.to raise_error(NoMethodError)
  end

  it 'allows assignment of configurations' do
    expect(sample.name).to eq 'sample'
    expect(sample.address).to eq '127.0.0.1'
    expect(sample.array).to eq [1, 2, 3]
    expect(sample.hash[:foo]).to eq 1
    expect(sample.hash[:bar]).to eq 2
    expect(sample.hash[:baz]).to eq 3

    sample.name = 'mac'
    expect(sample.name).to eq 'mac'
  end

  it 'does not infect other instances with changes' do
    sample.name = 'mac'
    expect(sample.name).to eq 'mac'

    sample2 = SampleClass.new
    expect(sample2.name).to eq 'sample'
  end

  it 'allows direct access of configurations' do
    expect(sample.name).to eq 'sample'
    expect(sample.address).to eq '127.0.0.1'
  end
end
