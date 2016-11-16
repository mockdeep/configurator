`Configurator` allows you to easily create configuration classes. Simply
`include Configurator` and specify the options you want to be available via
`config`.

## Defining a configuration class

```ruby
require 'configurator'

module MyGem
  class Configuration
    include Configurator

    config :name
    config :age
  end
end
```

## Accessing your configuration

```ruby
config = MyGem::Configuration.new
config.name = 'Matsumoto'
config.age = 18
config.name # => 'Matsumoto'
```

## Setting configuration options

`Configurator` loads configuration options from three locations automatically.
In order of precedence, lowest to highest:

1. It first tries to infer a default configuration path based on where it is
  included from.  From your library root directory, you can add a
  `config/default.yml`:

  ```
  my_gem
  ├── config
  │   └── default.yml
  └── lib
      └── my_gem
          └── configuration.rb
  ```

2. It then looks in the home directory of the user for a dot config file named
  the same as the library, e.g.: `~/.my_gem.yml`. Any options in this file will
  supercede what is defined in the library `config/defaults.yml`.

3. Finally, `Configurator` looks in the current execution directory for a dot
  config file with the name of the library: `./.my_gem.yml`. The options here
  take precedence over both the `config/default.yml` and home directory
  `.my_gem.yml`.

If any options loaded from these config files are not specified in your config
class, an error will be thrown listing the invalid keys.
