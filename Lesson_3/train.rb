# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество
# вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто
# увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может
# осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую
# станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train

  attr_accessor :quantity
  attr_reader :number, :type, :speed, :current_station

  @@current_station = ""
  @@current_position = nil

  def initialize (number, type, quantity)
    @number = number
    @type = type
    @quantity = quantity
    @speed = 0
    @route = nil
  end

  def speed_up (acceleration)
    @speed += acceleration
  end

  def stop
    @speed = 0
  end

  def add_wag
    @quantity += 1 if @speed == 0
  end

  def remove_wag
    @quantity -= 1 if @speed == 0
  end

  def add_route(route)
    @route = route
    @@current_station = @route.route_list[0].station_name
    @@current_position = 0
  end

  def move_forward
    if @@current_position >= 0 && @@current_position <= @route.route_list.size-2
      @@current_position += 1
      @@current_station = @route.route_list[@@current_position].station_name
    else
      puts "can't move forward"
    end
  end

  def move_back
    if @@current_position > 0
      @@current_position -= 1
      @@current_station = @route.route_list[@@current_position].station_name
      puts @@current_station
    else
      puts "can't move back"
    end
  end

  def return_stations
    current_station = @route.route_list[@@current_position]

    if @@current_position > 0
      previous_station = @route.route_list[@@current_position-1]
    end

    if @@current_position < @route.route_list.size-1
      next_station = @route.route_list[@@current_position+1]
    end

    return current_station, previous_station, next_station
  end
end
