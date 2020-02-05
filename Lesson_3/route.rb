load 'station.rb'

# Класс ROUTE
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываются при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :route_name, :route_list

  def initialize (route_name, base_station, end_station)
    @route_name = route_name
    @route_list = [base_station, end_station]
  end

  def add_interval_station(station)
    @route_list.insert(-2, station)
  end

  def delete_interval_station(station)
    @route_list.delete(station)
  end

  def show_route
    puts "Маршрут #{@route_name}: "
    @route_list.each { |station| print "->#{station.station_name} " }
  end
end
