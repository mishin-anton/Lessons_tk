# Класс STATION
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже):
# кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из
# списка поездов, находящихся на станции).

class Station
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains
    puts "Вагоны на станции #{@name}: "
    @trains.each { |train| puts train.number }
  end

  def show_trains_by_type(type)
    @typelist = @trains.map { |train| train.type }
    puts "Количество #{type} вагонов: #{@typelist.count(type)}"
  end
end
