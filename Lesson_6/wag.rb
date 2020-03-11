require_relative 'manufacturer'

class Wag
  include Manufacturer

  attr_accessor :number, :type

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number, type)
    @number = number
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end
