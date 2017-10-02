require "awesome_print"
require 'pry'
require 'pry-coolline'
require 'pry-nav'
module Multivers
  def self.define(name, &block)
    University.define(name, &block)
  end
  class University
    def self.instance
      @instance ||= new
    end
    def self.define(name, &block)
      global_name = name.to_s.capitalize
      instance.instance_eval(&block)
      Object.const_set(global_name, instance) unless Object.const_defined?(global_name)
    end
    def initialize
      @rules = {}
      @deafults = {}
      @dimensions = {}
    end
    def schema(schema, &block)
      @deafults[schema] = eval_cfg(schema, &block)
    end
    def rule(context, &block)
      @current_condition = context
      instance_eval(&block)
    end
    def namespace(schema, &block)
      cfg = eval_cfg(schema, &block)
      @rules[schema] ||= []
      @rules[schema] << {condition: @current_condition, cfg: cfg }
    end

    def dimension(name, values)
      @dimensions[name]=values
    end

    def method_missing(method, *args, &block)
      schemas = @deafults.keys
      method = method.to_sym
      return KeyValuePairs.new(@deafults[method]) if schemas.include?(method)
      super
    end

    private

    def find_match_values(schema, context)
      context ||= Setting.context
      schema_data = @deafults[schema]
      return schema_data if context.blank?

      @rules.each do |name, condition_cfg|
        condition = condition_cfg[:condition]
        cfg = condition_cfg[:cfg]
        if condition.eql?(context)
          return schema_data.merge(cfg)
        end
      end
      schema_data
      # what is current context?
      # where is it setup?
      # search from @rules and @defaults
    end

    def eval_cfg(name, &block)
      data_type =  KeyValuePairs.new
      data_type.instance_eval(&block)
      data_type.h
    end
  end
  class KeyValuePairs
    attr_reader :h
    def initialize(h=nil)
      @h = (h || {})
    end
    def cfg(var, value)
      @h[var] = value
    end
    def url(var, value) # Need validation
      @h[var] = value
    end
    def method_missing(method, *args, &block)
      # Read only now
      keys = @h.keys
      method = method.to_sym
      return @h[method] if keys.include?(method)
      nil
    end
  end
end

Multivers.define :cfg do
  # In University instance
  schema :zscaler do
    cfg :v1, 30
  end
  rule(tenant: :wowork, country: :uk) do
    namespace :zscaler do
      cfg :v1, 70
      cfg :v2, 70
    end
  end
  rule(tenant: :wowork) do
    namespace :zscaler do
      cfg :v1, 60
      cfg :v2, 60
    end
  end
end

Multivers.define :cfg do
  schema :extension do
    cfg :v1, 30
  end
  rule(tenant: :wowork) do
    namespace :extension do
      cfg :v1, 60
      cfg :v2, 60
    end
  end
  rule(tenant: :wowork, country: :uk) do
    namespace :extension do
      cfg :v1, 70
      cfg :v2, 70
    end
  end

  dimension :tenant,
            fallbacks: {stream: :cfg}
end

Multivers.define :cfg do
  schema :extension do
    cfg :v1, 30
  end
  rule({tenant: :wowork, operator: :not}, {country: [:uk, :us],  operator: :not}) do
    namespace :extension do
      cfg :v1, 60
      cfg :v2, 60
    end
  end
end
binding.pry
