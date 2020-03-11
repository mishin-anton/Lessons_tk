require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'route'
require_relative 'wag'
require_relative 'wag_cargo'
require_relative 'wag_passenger'

@stations = []
@trains = []
@routes = []

def show_stations_list
  @stations.each { |station| puts station.name }
end

def show_trains_list
  @trains.each { |train| puts train.number }
end

def show_routes_list
  @routes.each { |route| puts route.name }
end

def show_header
  puts "*****************************"
  puts '*Программа "Железная дорога"*'
  puts "*****************************"
end

show_header

loop do
  puts "---------------------------"
  puts "МЕНЮ:"
  puts "1 Создать станцию"
  puts "2 Создать поезд"
  puts "3 Создать маршрут и управлять станциями (добавлять/удалять)"
  puts "4 Назначить маршрут поезду"
  puts "5 Добавить вагон к поезду"
  puts "6 Отцепить вагон от поезда"
  puts "7 Переместить поезд по маршруту (вперед и назад)"
  puts "8 Посмотреть список поездов"
  puts "9 Просмотреть список станций и список поездов на станции"
  puts "0 для выхода"
  selected = gets.chomp.to_s

  break if selected == '0'

  case selected
  when '1'
    puts "* Создать станцию -> "
    print "Введите название станции: "
    name = gets.chomp.to_s
    @stations << Station.new(name)

  when '2'
    begin
      puts "* Создать поезд -> "
      print "Введите номер поезда в формате 55A-01: "
      number = gets.chomp.to_s
      print "Введите тип поезда (1 - грузовой, 2 - пассажирский)"
      type = gets.chomp.to_s
        if type == '1'
          @trains << CargoTrain.new(number)
        elsif type == '2'
          @trains << PassengerTrain.new(number)
        else
          raise "Неверно выбран тип"
        end
    rescue StandardError
      puts "Неверный формат ввода (повторите ввод)"
      retry
    end
    puts "Создан поезд #{number}"

  when '3'
    puts "* Создать маршрут и управлять станциями"
    puts "1 - создать маршрут"
    puts "2 - добавить/удалить станцию"
    choise = gets.chomp.to_s

    if choise == '1'
      puts "Введите начальную станцию из списка: "
      show_stations_list
      base_station = gets.chomp.to_s
      puts "Выберите конечную станцию из списка: "
      show_stations_list
      end_station = gets.chomp.to_s

      @stations.each do |station|
        @start = station if station.name == base_station
        @finish = station if station.name == end_station
      end

      @routes << Route.new(@start, @finish)

    elsif choise == '2'
      puts "Введите маршрут из списка для изменения"
      show_routes_list
      route_name = gets.chomp.to_s
      puts "1 - Добавить промежуточную станцию к маршруту #{route_name}"
      puts "2 - Удалить промежуточную станцию из маршрута #{route_name}"
      operation = gets.chomp.to_s

      if operation == '1'
        puts "Выберите станцию из списка для добавления в маршрут"
        show_stations_list
        name = gets.chomp.to_s

        @routes.each do |route|
          if route.name == route_name
            @stations.each { |station| route.add_interval_station(station) if station.name == name }
            route.show_route
          end
        end
      end
    end

  when '4'
    puts "* Назначить маршрут поезду"
    puts "Выберите номер поезда"
    @trains.each { |train| puts train.number}
    number = gets.chomp.to_s
    puts "Введите маршрут из списка"
    @routes.each { |route| puts route.name}
    route_get = gets.chomp.to_s

    @trains.each do |train|
      if train.number == number
        @routes.each { |route| @cur_route = route if route.name == route_get}
        train.add_route(@cur_route)
      end
    end

  when '5'
    puts "* Добавить вагон к поезду"
    puts "Введите номер поезда"
    number = gets.chomp.to_s
    puts "Введите номер вагона в формате 00001"
    wag_number = gets.chomp.to_s
    puts "Введите тип (грузовой/пассажирский)"
    type = gets.chomp.to_s

    @trains.each do |train|
      if train.number == number
        if type == 'грузовой' && train.type == 'грузовой'
          train.add_wag(CargoWag.new(wag_number))
        elsif type == 'пассажирский' && train.type == 'пассажирский'
          train.add_wag(PassengerWag.new(wag_number))
        end
      end
    end

  when '6'
    puts "* Отцепить вагон от поезда"
    puts "Введите номер поезда для отцепки вагона"
    number = gets.chomp.to_s
    puts "Какой номер вагона отцепить?"
    @trains.each do |train|
      if train.number == number
        train.show_wagons
        wag_number = gets.chomp.to_s
        train.remove_wag_by_number(wag_number)
      end
    end

  when '7'
    puts "* Переместить поезд по маршруту вперед-назад"
    puts "Введите номер поезда из списка"
    show_trains_list
    number = gets.chomp.to_s
    puts "1 - Переместить поезд вперед по маршурут"
    puts "2 - Переместить поезд назад по маршурут"
    move = gets.chomp.to_s

    @trains.each do |train|
      if train.number == number
        train.move_forward if move == '1'
        train.move_back if move == '2'
      end
    end

  when '8'
    puts "Список поездов: "
    @trains.each do |train|
      puts "#{train.number} - #{train.type}"
      train.show_wagons
    end

  when '9'
    puts " Список станций и поездов: "
    puts "---------------------------"
    puts "Станции:"
    @stations.each do |station|
      puts "* #{station.name}"
      puts "поезда на станции: "
      @trains.each do |train|
        unless train.route.nil?
          if station.name == train.get_current_station.name
            puts "#{train.number} - #{train.type}"
            puts "Вагоны: #{train.wagons}"
          end
        end
      end
    end
  end
end
