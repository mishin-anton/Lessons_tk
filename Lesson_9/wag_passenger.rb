# frozen_string_literal: true

require_relative 'validation'

class PassengerWag < Wag
  include Validation

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
end
