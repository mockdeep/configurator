`Configurator` extends configuration behavior to class.

## make class with configurator extension

`Configurator` allows you to declare config parameters with keys to class. It
works as hash.

```ruby
require 'configurator'
class Klass
  extend Configurator
  config :name, 'Matsumoto'
  config :age, 18
end
```

## refer to config parameters

Parameters are referable from both Class and Instance.

from class:

```ruby
Klass.config[:name]   #=> 'Matsumoto'
Klass.config[:age]    #=> 18
```

from instance:

```ruby
kls = Klass.new
kls.config[:name]     #=> 'Matsumoto'
kls.config[:age]      #=> 18
```

## inherit and rewrite

Parameters are also inheritable and rewritable.

```ruby
class SubKlass < Klass
  config :name, 'Matz'
  config :sex, 'm'
end
sub = SubKlass.new
sub.config[:name]    # => 'Matz'
sub.config[:age]     # => 18
sub.config[:sex]     # => 'm'
kls.config[:name]    # => 'Matsumoto'
```

## instance specific config paramaters

It works as an instance specific method.

```ruby
Klass.config :name, 'Matz'
kls = Klass.new
kls.config :name, 'Yukihiro'
kls.config[:name]     # => 'Yukihiro'
kls2 = Klass.new
kls2.config[:name]    # => 'Matz'
```
