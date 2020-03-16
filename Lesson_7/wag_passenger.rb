require_relative 'validate'

class PassengerWag < Wag
  include Validate

  attr_reader :total_seats
  attr_accessor :free_seats, :busy_seats

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number, total_seats)
    @number = number
    @type = "пассажирский"
    @total_seats = total_seats
    @free_seats = @total_seats
    @busy_seats = 0
    validate!
  end

  def take_seat
    if @busy_seats < @total_seats
      @busy_seats = @busy_seats + 1
      @free_seats = @free_seats - 1
    end
  end

  def get_busy_seats
    @busy_seats
  end

  def get_free_seats
    @free_seats
  end

  protected

  def validate!
    raise "Wagon number has invalid format" if number !~ NUMBER_FORMAT
  end
end
