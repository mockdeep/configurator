Configurator extends configuration behavior to class.

==make class with configurator extension
Configurator allows you to delcare config paramaters with keys to class. It works as hash.
  require 'rubygems'
  require 'configurator'
  class Klass
    extend Congigurator
    config :name, 'Matsumoto'
    config :age, 18
  end

==refer to config paramaters
Paramaters are referable from both Class and Instance.

from class
  Klass.config[:name]   #=> 'Matsumoto'
  Klass.config[:age]    #=> 18
from instance
  kls = Klass.new
  kls.config[:name]     #=> 'Matsumoto'
  kls.config[:age]      #=> 18

==inherite and rewrite
Paramaters are also inheritable and rewritable.
  class SubKlass < Klass
    config :name, 'Matz'
    config :sex, 'm'
  end
  sub = SubKlass.new
  sub.config[:name]    # => 'Matz'
  sub.config[:age]     # => 18
  sub.config[:sex]     # => 'm'
  kls.config[:name]    # => 'Matsumoto'

==instance specific config paramaters
It works as like as instance specific method.
  Klass.config :name, 'Matz'
  kls = Klass.new
  kls.config :name, 'Yukihiro'
  kls.config[:name]     # => 'Yukihiro'
  kls2 = Klass.new
  kls2.config[:name]    # => 'Matz'