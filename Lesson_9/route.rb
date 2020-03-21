# frozen_string_literal: true

require_relative 'instancecounter'
require_relative 'station.rb'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :name, :stations

  def initialize(base_station, end_station)
    @name = "#{base_station.name} - #{end_station.name}"
    @stations = [base_station, end_station]
    register_instance
    validate!
  end

  def add_interval_station(station)
    return unless !first_station?(station) && !last_station?(station)

    @stations.insert(-2, station)
  end

  def first_station?(station)
    return true if station == @stations.first
  end

  def last_station?(station)
    return true if station == @stations.last
  end

  def delete_interval_station(station)
    return unless station != @stations.first && station != @stations.last

    @stations.delete(station)
  end

  def show_route
    puts "Маршрут #{@name}: "
    @stations.each { |station| print "->#{station.name} " }
    puts ''
  end
end
