# frozen_string_literal: true

require_relative 'validation'

class CargoTrain < Train
  include Validation

  attr_reader :wagons

  NUMBER_FORMAT = /^[a-zA-z0-9]{3}[-|\s]{1}[a-zA-z0-9]{2}/.freeze

  validate :number, :validate_format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    @type = 'грузовой'
    @wagons = []
    validate!
  end

  def add_wag(wag)
    @wagons << wag
  end
end
