# frozen_string_literal: true

require_relative 'validation'

class PassengerTrain < Train
  include Validation

  def initialize(number)
    @number = number
    @type = 'пассажирский'
    @wagons = []
    validate!
  end

  def add_wag(wag)
    @wagons << wag
  end
end
