# frozen_string_literal: true

require_relative 'validate'

class CargoTrain < Train
  include Validate

  attr_reader :wagons

  NUMBER_FORMAT = /^[a-zA-z0-9]{3}[-|\s]{1}[a-zA-z0-9]{2}/.freeze

  def initialize(number)
    @number = number
    @type = 'грузовой'
    @wagons = []
    validate!
  end

  def add_wag(wag)
    @wagons << wag
  end

  protected

  def validate!
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
  end
end
