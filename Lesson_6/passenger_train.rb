require_relative 'validate'

class PassengerTrain < Train
  include Validate

  def initialize (number)
    @number = number
    @type = "пассажирский"
    @wagons = []
    validate!
  end

  def add_wag (wag)
    @wagons << wag
  end

  protected

  def validate!
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end
