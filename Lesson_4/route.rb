require_relative 'station.rb'

class Route
  attr_reader :name, :stations

  def initialize (base_station, end_station)
    @name = "#{base_station.name} - #{end_station.name}"
    @stations = [base_station, end_station]
  end

  def add_interval_station(station)
    if !first_station?(station) && !last_station?(station)
      @stations.insert(-2, station)
    end
  end

  def first_station?(station)
    return true if station == @stations.first
  end

  def last_station?(station)
    return true if station == @stations.last
  end

  def delete_interval_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  def show_route
    puts "Маршрут #{@name}: "
    @stations.each { |station| print "->#{station.name} " }
    puts ''
  end
end
