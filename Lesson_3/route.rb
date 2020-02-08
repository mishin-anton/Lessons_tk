load 'station.rb'

# Класс ROUTE
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываются при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

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
  end
end
