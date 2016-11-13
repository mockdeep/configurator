`Configurator` extends configuration behavior to class.

## make class with configurator extension

`Configurator` allows you to declare config parameters with keys to class.

```ruby
require 'configurator'
class Klass
  include Configurator
  config :name, 'Matsumoto'
  config :age, 18
end
```

## access to config parameters

```ruby
kls = Klass.new
kls.config(:name)     #=> 'Matsumoto'
kls.config(:age)      #=> 18
```
