class PassengerWag < Wag

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number)
    @number = number
    @type = "пассажирский"
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
    raise "Wagon number has invalid format" if number !~ NUMBER_FORMAT
  end
end
