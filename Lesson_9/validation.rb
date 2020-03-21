module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  def validate!
    validate
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  module ClassMethods
    attr_reader :parameters

    def self.validate(attr, validation_type, options = {})
      @parameters ||= {}
      @parameters[attr.to_sym] ||= []
      @parameters[attr.to_sym] << { validation_type => options }
    end
  end

  module InstanceMethods
    def validate!
      return if hash_empty?(self.class.parameters)

      self.class.parameters.each do |attr, array|
        instance = instance_variable_get("@#{attr}")
        array.each do |hash|
          hash.each { |type, options| send(type, instance, options) }
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    def presence(attr, presence)
      raise "Name can't be empty" if attr ||= empty?
    end

    def format(attr, options)
      options.each do |format, format_val|
        raise "Error Number has invalid format" if attr !~ format_val
      end
    end

    def type(attr, options)
      options.each do |value|
        raise "Attribute has invalid type" unless value.is_a? type
      end
    end

    def hash_empty?(hash)
      hash.nil? || hash.empty?
    end
  end
end
