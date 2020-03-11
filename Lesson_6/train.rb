require_relative 'manufacturer'
require_relative 'instancecounter'

class Train
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[a-zA-z0-9]{3}[-|\s]{1}[a-zA-z0-9]{2}/
  MOVE_FORWARD_ERROR = "Can't move forward"
  MOVE_BACK_ERROR = "Can't move back"

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  attr_accessor :wagons, :type, :route
  attr_reader :number, :speed

  def initialize (number, type)
    @number = number
    @type = type
    @speed = 0
    @route
    @current_position
    @wagons = []
    @@trains[number] = self
    register_instance
    validate!
  end

  def speed_up (acceleration)
    @speed += acceleration
  end

  def stop
    @speed = 0
  end

  def add_wag (wag)
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
    if @@current_position > 0
      @current_position -= 1
    else
      puts MOVE_BACK_ERROR
    end
  end

  def get_current_station
    unless @route.nil?
      current_station = @route.stations[@current_position]
    end
  end

  def get_previous_station
    if @current_position > 0
      previous_station = @route.stations[@current_position - 1]
    end
  end

  def get_next_station
    if @current_position < @route.stations.size - 1
      next_station = @route.stations[@current_position + 1]
    end
  end

  def show_wagons
    @wagons.each { |wagon| puts wagon.number}
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end
