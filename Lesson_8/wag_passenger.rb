# frozen_string_literal: true

require_relative 'validate'

class PassengerWag < Wag
  include Validate

  attr_reader :total_space
  attr_accessor :free_space, :busy_space

  NUMBER_FORMAT = /^[0-9]{5}/.freeze

  def initialize(number, total_space)
    @number = number
    @type = 'пассажирский'
    @total_space = total_space
    @free_space = @total_space
    @busy_space = 0
    validate!
  end

  protected

  def validate!
    raise 'Wagon number has invalid format' if number !~ NUMBER_FORMAT
  end
end
