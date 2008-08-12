# Clag is the awesome edible glue that Australian kids know and love
#
# Inspired from http://replacefixtures.rubyforge.org/
#
# Usage: stick clag.rb in a load path path somewhere (like lib/)
#
# Next, in spec_helper, or somewhere like that, reopen, or make a new class
# descended from Clag, and add tableized method names for your model attributes
#
# Say:
#
# class MyClag < Clag
#
#   #n if method sig has no options, then any extra ones are merged with the result
#   def user
#     { a hash is returned }
#   end
#
#   # if method sig has options, then it's assumed you will merge them here
#   def area(options = {})
#     { default hash }.merge(options)
#   end
# end
#
# Then do MyClag.create_user, or MyClag.new_user, or MyClag.user_attributes
#
# You can make of Clag methods like
#
#   random:     returns a random string
#
#   unique_for: guarantee a unique result when using a random value
#
#     unique_for(:user_email) { "#{random}@email.com" }
#
#
# Advantages of Clag :-
#
# * it's one tiny ruby file
# * you can group data together by scenarios by making a new clag class
# * all of the features of fixture replacement type thingies
#
class Clag
  module Dispatcher
    def respond_to?(method)
      super(method) ||
        /^(create|new)_(\w+)(!?)$/.match(method.to_s) ||
        /^(\w+)_attributes$/.match(method.to_s) ||
        (eval("::#{clag_class.name}::#{method.to_s.classify}") rescue nil)
    end
    
    def method_missing(method, *args, &block)
      if match = /^(create|new)_(\w+)(!?)$/.match(method.to_s)
        dispatch_to_ar(match[2], match[1] + match[3], args[0])
      elsif match = /^(\w+)_attributes$/.match(method.to_s)
        dispatch_to_self(match[1], args[0])
      elsif args.length == 0 && klass = (eval("::#{clag_class.name}::#{method.to_s.classify}") rescue nil)
        klass
      else
        super(method, *args, &block)
      end
    end
    
    def dispatch_to_ar(model, method, options)
      klass = namespaced_class(model)
      attrs_method = clag_class.new.method(model)
      klass.send method, call_with_merge_depending_on_arity(attrs_method, options)
    end
    
    def dispatch_to_self(method, options)
      attrs_method = clag_class.new.method(method)
      call_with_merge_depending_on_arity(attrs_method, options)
    end
    
    def call_with_merge_depending_on_arity(method, options)
      if method.arity == 0
        method.call.merge(options || {})
      else
        method.call(options || {})
      end
    end
    
    def clag_class
      self.is_a?(Class) ? self : self.class
    end
  end
  
  include Dispatcher
  
  class << self
    include Dispatcher
    
    def unique?(key, value)
      @@unique ||= {}
      @@unique[key] ||= {}
      @@unique[key][value] ? false : @@unique[key][value] = true
    end
    
    def namespaced_class(class_name)
      ('/' + (clag_class.namespace.collect(&:to_s) << class_name).join('/')).classify.constantize
    end
    
    def inherited(subclass)
      subclass.namespace << subclass.name.demodulize.underscore.to_sym
    end
    
    def namespace
      instance_variable_get('@namespace') || instance_variable_set('@namespace', (superclass.namespace.dup rescue []))
    end
    
    def namespace=(namespace_array)
      instance_variable_set('@namespace', namespace_array.dup)
    end
  end
  
  def random(length=10)
    chars = ("a".."z").to_a
    (1..length).to_a.inject("") {|m, _| m << chars[rand(chars.size-1)]}
  end
  
  def unique_for(key, &block)
    100.times do
      candidate = block.call
      return candidate if self.class.unique?(key, candidate)
    end
    raise "Pass a block that changes to unique_for"
  end
end