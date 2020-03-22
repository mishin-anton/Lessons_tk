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
    attr_reader :validations

    def validate(attr, type, options = {})
      @validations ||= []
      @validations << { attr: attr, type: type, options: options }
    end
  end

  module InstanceMethods
    def validate!
      return if hash_empty?(self.class.validations)

      self.class.validations.each do |hash|
        instance = instance_variable_get("@#{hash[:attr]}")
        send(hash[:type], instance, hash[:options])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    def validate_presence(attr, presence)
      raise "Name can't be empty" if attr.empty?
    end

    def validate_format(attr, format)
      raise "Error Number has invalid format" if attr !~ format
    end

    def validate_type(attr, options)
      options.each do |value|
        raise "Attribute has invalid type" unless value.is_a? type
      end
    end

    def hash_empty?(hash)
      hash.nil? || hash.empty?
    end
  end
end
