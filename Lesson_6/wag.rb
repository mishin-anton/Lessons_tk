require_relative 'manufacturer'
require_relative 'validate'

class Wag
  include Manufacturer
  include Validate

  attr_accessor :number, :type

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number, type)
    @number = number
    @type = type
    validate!
  end

  protected

  def validate!
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end
