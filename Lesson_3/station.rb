# Класс STATION
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже):
# кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из
# списка поездов, находящихся на станции).

class Station
    attr_accessor :station_name

  def initialize(station_name)
    @station_name = station_name
    @train_list = []
  end

  def add_train(train)
    @train_list << train
  end

  def send_train(train)
    @train_list.delete (train)

  end

  def show_train_list
    puts "Вагоны на станции #{@station_name}: "
    @train_list.each { |train| puts train.number }
  end

  def show_train_list_by_type
    type_cargo = 0
    type_passenger = 0
    error_type = 0

    @train_list.each do |train|
      if train.type == "грузовой"
        type_cargo += 1
      elsif train.type == "пассажирский"
        type_passenger += 1
      else error_type += 1
    end
  end

    puts "Грузовых вагонов на станции: #{type_cargo}"
    puts "Пассажирских вагонов на станции: #{type_passenger}"
  end
end
