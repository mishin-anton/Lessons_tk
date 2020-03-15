require_relative 'validate'

class CargoWag < Wag
  include Validate

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number)
    @number = number
    @type = "грузовой"
    validate!
  end

  protected

  def validate!
    raise "Wagon number has invalid format" if number !~ NUMBER_FORMAT
  end
end
