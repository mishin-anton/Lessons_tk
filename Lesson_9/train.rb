# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instancecounter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  include Accessors

  NUMBER_FORMAT = /^[a-zA-z0-9]{3}-?[a-zA-z0-9]{2}/.freeze
  MOVE_FORWARD_ERROR = "Can't move forward"
  MOVE_BACK_ERROR = "Can't move back"

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  attr_reader :number, :route, :type
  attr_accessor_with_history :speed
  strong_attr_accessor :number, Integer

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
    @@trains[number] = self
    register_instance
    validate!
  end

  def speed_up(acceleration)
    @speed += acceleration
  end

  def stop
    @speed = 0
  end

  def add_wag(wag)
    @wagons << wag
  end

  def remove_wag(wag)
    @wagons.delete(wag)
  end

  def remove_wag_by_number(number)
    @wagons.each do |wagon|
      @wagons.delete(wagon) if wagon.number == number
    end
  end

  def add_route(route)
    @route = route
    @current_position = 0
  end

  def move_forward
    if @current_position >= 0 && @current_position <= @route.stations.size - 2
      @current_position += 1
    else
      puts MOVE_FORWARD_ERROR
    end
  end

  def move_back
    if @@current_position.positive?
      @current_position -= 1
    else
      puts MOVE_BACK_ERROR
    end
  end

  def find_current_station
    @current_station = @route.stations[@current_position] unless @route.nil?
  end

  def find_previous_station
    return unless @current_position.positive?

    @previous_station = @route.stations[@current_position - 1]
  end

  def find_next_station
    return unless @current_position < @route.stations.size - 1

    @next_station = @route.stations[@current_position + 1]
  end

  def show_wagons
    @wagons.each { |wagon| puts wagon.number }
  end

  def each_wag(_block)
    @wagons.each do |wag|
      yield(wag)
    end
  end
end
