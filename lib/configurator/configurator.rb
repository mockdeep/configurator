#
# Configurator extends configuration behavior to class.
# 
# ==make class with configurator extension
# Configurator allows you to delcare config paramaters with keys to class. It works as hash.
#   require 'rubygems'
#   require 'configurator'
#   class Klass
#     extend Congigurator
#     config :name, 'Matsumoto'
#     config :age, 18
#   end
# 
# ==refer to config paramaters
# Paramaters are referable from both Class and Instance.
# 
# from class
#   Klass.config[:name]   #=> 'Matsumoto'
#   Klass.config[:age]    #=> 18
# from instance
#   kls = Klass.new
#   kls.config[:name]     #=> 'Matsumoto'
#   kls.config[:age]      #=> 18
# 
# ==inherite and rewrite
# Paramaters are also inheritable and rewritable.
#   class SubKlass < Klass
#     config :name, 'Matz'
#     config :sex, 'm'
#   end
#   sub = SubKlass.new
#   sub.config[:name]    # => 'Matz'
#   sub.config[:age]     # => 18
#   sub.config[:sex]     # => 'm'
#   kls.config[:name]    # => 'Matsumoto'
#
# ==instance specific config paramaters
# It works as like as instance specific method.
#   Klass.config :name, 'Matz'
#   kls = Klass.new
#   kls.config :name, 'Yukihiro'
#   kls.config[:name]     # => 'Yukihiro'
#   kls2 = Klass.new
#   kls2.config[:name]    # => 'Matz'
module Configurator
  
  public
  # set config paramaters within class block code.
  #   class Klass
  #     extend Configurator
  #     config key, value
  #   end
  #
  # Another way to set paramaters.
  #   Klass.config key, value
  #   Klass.config[key] = value
  #   Klass.new.config key, value
  #   Klass.new.config[key] = value
  #
  # Reffer to config paramaters.
  #   Klass.config[key]       # => value
  #   Klass.new.config[key]   # => value
  #
  # This method also works as instance method because instance includes this module automatically.
  #   kls = Klass.new
  #   kls.config[key]         # => value
  # 
  def config( key = nil, value = nil )
    @__self_config ||= {}
    @__config = __check_config
    case
    when ( key and value ) : @__self_config[ key ] = value; @__config = __merge_config; return value
    when key               : return @__config[ key ]
    else                     return @__config
    end
  end
  
  private
  
  def __merge_config
    __inherited_config.merge( @__self_config )
  end
  
  def __check_config
    @__config ||= {}
    __config = __merge_config
    @__config.each do |k, v|
      unless __config[ k ] == v
        @__self_config[ k ] = v
      end
    end
    @__config = __merge_config
  end

  def __inherited_config
    if self.respond_to?( :ancestors )
      @__inherited_config = {}
      ancestors[ 1 .. ( ancestors.size - 1 ) ].each do |ancestor|
        if ancestor.respond_to?( :config ) and Hash === ancestor.config
          @__inherited_config = ancestor.config.merge( @__inherited_config || {} )
        end
      end
    else
      @__inherited_config = self.class.config
    end
    return @__inherited_config
  end

  def method_missing( name, *args, &block )
    if @__config.keys.include?( name.to_sym )
      @__config[ name.to_sym ]
    else
      super
    end
  end
  
  def self.extended( mod )
    mod.module_eval { include Configurator } #::InstanceMethods }
  end
        
end

