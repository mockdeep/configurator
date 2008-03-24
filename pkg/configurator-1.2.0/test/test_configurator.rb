require File.dirname(__FILE__) + '/test_helper.rb'

class SampleClass
  extend Configurator
  config :name, "sample"
  config :address, "127.0.0.1"
  config :array, [ 1, 2, 3 ]
  config :hash, { :foo => 1, :bar => 2, :baz => 3 }
end

class SampleChildClass < SampleClass
  config :name, "child"
  config :array, [ 4, 5, 6]
end

class TestConfigurator < Test::Unit::TestCase

  def setup
  end
  
  def test_config
    assert sample = SampleClass.new
    assert sample.config[:name] == "sample"
    assert sample.config[:address] == "127.0.0.1"
    assert sample.config[:array] == [ 1, 2, 3 ]
    assert sample.config[:hash][:foo] == 1
    assert sample.config[:hash][:bar] == 2
    assert sample.config[:hash][:baz] == 3
    
    sample.config[:name] = "mac"
    assert sample.config[:name] == "mac"
    
    sample.config :boo, 12
    assert sample.config[:boo] == 12
    
    sample2 = SampleClass.new
    assert sample2.config[:boo] == nil
    
  end
  
  def test_config_child
    sample = SampleChildClass.new
    assert_equal sample.config[:name], "child"
    assert_equal sample.config[:address], "127.0.0.1"
    assert_equal sample.config[:array], [ 4, 5, 6 ]
    assert_equal sample.config[:hash][:foo], 1
    assert_equal sample.config[:hash][:bar], 2
    assert_equal sample.config[:hash][:baz], 3
    
    sample.config[:name] = "mac"
    assert sample.config[:name] == "mac"
    
    sample.config :giz, 12
    assert_equal sample.config[:giz], 12
    
    sample2 = SampleChildClass.new
    assert_equal sample2.config[:giz], nil
    
    sample3 = SampleClass.new
    assert_equal sample3.config[:giz], nil
    
    SampleClass.config :giz, 999
    assert_equal sample.config[:giz], 12
    assert_equal sample2.config[:giz], 999
    
  end
  
end
