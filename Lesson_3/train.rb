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
  attr_reader :number, :type, :speed

  def initialize (number, type, quantity)
    @number = number
    @type = type
    @quantity = quantity
    @speed = 0
    @route
    @current_station # удалить
    @current_position
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
    @quantity -= 1 if @speed == 0 && @quantity > 0
  end

  def add_route(route)
    @route = route
    @current_position = 0
  end

  def move_forward
    if @current_position >= 0 && @current_position <= @route.stations.size-2
      @current_position += 1
    else
      puts "can't move forward"
    end
  end

  def move_back
    if @@current_position > 0
      @@current_position -= 1
    else
      puts "can't move back"
    end
  end

  def get_current_station
    current_station = @route.stations[@current_position]
  end

  def get_previous_station
    if @current_position > 0
      previous_station = @route.stations[@current_position-1]
    end
  end

  def get_next_station
    if @current_position < @route.stations.size-1
      next_station = @route.stations[@current_position+1]
    end
  end
end
