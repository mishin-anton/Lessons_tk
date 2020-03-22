# frozen_string_literal: true

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

def show_all_wagons
  @trains.each do |train|
    train.wagons.each { |wag| puts wag.number }
  end
end

def show_header
  puts '*****************************'
  puts '*Программа "Железная дорога"*'
  puts '*****************************'
end

def init_start_station(base_station)
  @stations.each do |station|
    @start = station if station.name == base_station
  end
end

def init_end_station(end_station)
  @stations.each do |station|
    @finish = station if station.name == end_station
  end
end

def find_current_route(request_route)
  @routes.each do |route|
    @cur_route = route if route.name == request_route
  end
end

def add_interval_station(route_name)
  puts 'Выберите станцию из списка для добавления в маршрут'
  show_stations_list
  name = gets.chomp.to_s

  @routes.each do |route|
    next unless route.name == route_name

    @stations.each do |station|
      route.add_interval_station(station) if station.name == name
    end
  end
end

def del_interval_station(route_name)
  puts 'Выберите промежуточную станцию из списка для удаления из маршрута'
  show_stations_list
  name = gets.chomp.to_s

  @routes.each do |route|
    next unless route.name == route_name

    @stations.each do |station|
      route.delete_interval_station(station) if station.name == name
    end
  end
end

def manage_station(route_name, operation_number)
  add_interval_station(route_name) if operation_number == '1'

  del_interval_station(route_name) if operation_number == '2'
end

show_header

selected = nil
while selected != 0
  puts '---------------------------'
  puts 'МЕНЮ:'
  puts '1 Создать станцию'
  puts '2 Создать поезд'
  puts '3 Создать маршрут и управлять станциями (добавлять/удалять)'
  puts '4 Назначить маршрут поезду'
  puts '5 Добавить вагон к поезду'
  puts '6 Отцепить вагон от поезда'
  puts '7 Переместить поезд по маршруту (вперед и назад)'
  puts '8 Посмотреть список поездов'
  puts '9 Просмотреть список станций и список поездов на станции'
  puts '10 Загрузить или занять место в вагоне'
  puts '0 для выхода'
  selected = gets.chomp.to_s

  break if selected == '0'

  case selected
  when '1'
    puts '* Создать станцию -> '
    print 'Введите название станции: '
    name = gets.chomp.to_s
    @stations << Station.new(name)

  when '2'
    begin
        puts '* Создать поезд -> '
        print 'Введите номер поезда в формате 55A-01: '
        number = gets.chomp.to_s
        print 'Введите тип поезда (1 - грузовой, 2 - пассажирский)'
        type = gets.chomp.to_s
        if type == '1'
          @trains << CargoTrain.new(number)
        elsif type == '2'
          @trains << PassengerTrain.new(number)
        else
          puts 'Неверно выбран тип'
        end
    rescue StandardError => e
      puts e
      retry
    end
    puts "Создан поезд #{number}"

  when '3'
    puts '* Создать маршрут и управлять станциями'
    puts '1 - создать маршрут'
    puts '2 - добавить/удалить станцию'
    choise = gets.chomp.to_s

    if choise == '1'
      puts 'Введите начальную станцию из списка: '
      show_stations_list
      base_station = gets.chomp.to_s
      init_start_station(base_station)

      puts 'Выберите конечную станцию из списка: '
      show_stations_list
      end_station = gets.chomp.to_s
      init_end_station(end_station)

      @routes << Route.new(@start, @finish)

    elsif choise == '2'
      puts 'Введите маршрут из списка для изменения'
      show_routes_list
      route_name = gets.chomp.to_s
      puts "1 - Добавить промежуточную станцию к маршруту #{route_name}"
      puts "2 - Удалить промежуточную станцию из маршрута #{route_name}"
      operation = gets.chomp.to_s

      manage_station(route_name, operation)
    end

  when '4'
    puts '* Назначить маршрут поезду'
    puts 'Выберите номер поезда'
    @trains.each { |train| puts train.number }
    number = gets.chomp.to_s
    puts 'Введите маршрут из списка'
    @routes.each { |route| puts route.name }
    request_route = gets.chomp.to_s

    @trains.each do |train|
      if train.number == number
        find_current_route(request_route)
        train.add_route(@cur_route)
      end
    end

  when '5'
    puts '* Добавить вагон к поезду'
    puts 'Введите номер поезда'
    number = gets.chomp.to_s
    puts 'Введите номер вагона в формате 00001'
    wag_number = gets.chomp.to_s
    puts 'Введите тип (грузовой/пассажирский)'
    type = gets.chomp.to_s

    @trains.each do |train|
      break unless train.number == number

      if type == 'грузовой' && train.type == 'грузовой'
        puts 'Введите объем'
        volume = gets.chomp.to_i
        train.add_wag(CargoWag.new(wag_number, volume))
      elsif type == 'пассажирский' && train.type == 'пассажирский'
        puts 'Введите количество посадочных мест'
        seats = gets.chomp.to_i
        train.add_wag(PassengerWag.new(wag_number, seats))
      end
    end

  when '6'
    puts '* Отцепить вагон от поезда'
    puts 'Введите номер поезда для отцепки вагона'
    number = gets.chomp.to_s
    puts 'Какой номер вагона отцепить?'
    @trains.each do |train|
      next unless train.number == number

      train.show_wagons
      wag_number = gets.chomp.to_s
      train.remove_wag_by_number(wag_number)
    end

  when '7'
    puts '* Переместить поезд по маршруту вперед-назад'
    puts 'Введите номер поезда из списка'
    show_trains_list
    number = gets.chomp.to_s
    puts '1 - Переместить поезд вперед по маршурут'
    puts '2 - Переместить поезд назад по маршурут'
    move = gets.chomp.to_s

    @trains.each do |train|
      next unless train.number == number

      case move
      when '1'
        train.move_forward
      when '2'
        train.move_back
      end
    end

  when '8'
    puts '* Список поездов: '
    @trains.each do |train|
      puts "#{train.number} - #{train.type}"
      train.wagons.each do |wag|
        if wag.type == 'грузовой'
          puts "№ #{wag.number} - тип: #{wag.type}" \
               "- доступный V: #{wag.wag_free_space}" \
               "- занятый V: #{wag.busy_space}"
        elsif wag.type == 'пассажирский'
          puts "№: #{wag.number} - тип: #{wag.type}" \
               "- достуно мест: #{wag.wag_free_space}" \
               "- занято мест: #{wag.wag_busy_space}"
        end
      end
    end

  when '9'
    puts '* Список станций и поездов: '
    puts 'Станции:'
    @stations.each do |station|
      puts "* #{station.name}"
      puts 'поезда на станции: '
      @trains.each do |train|
        next if train.route.nil?
        next unless station.name == train.find_current_station.name

        puts "Поезд № #{train.number}" \
             "- тип #{train.type}" \
             "- вагонов #{train.wagons.length}"
        train.wagons.each do |wag|
          if wag.type == 'грузовой'
            puts "№ #{wag.number}" \
                 "- тип: #{wag.type}" \
                 "- доступный V: #{wag.wag_free_space}" \
                 "- занятый V: #{wag.busy_space}"
          elsif wag.type == 'пассажирский'
            puts "№: #{wag.number}" \
                 "- тип: #{wag.type}" \
                 "- достуно мест: #{wag.wag_free_space}" \
                 "- занято мест: #{wag.wag_busy_space}"
          end
        end
      end
    end

  when '10'
    puts '* Загрузить вагон или занять место:'
    puts 'Выберите номер вагона для загрузки'
    show_all_wagons
    selected_wag = gets.chomp.to_s

    @trains.each do |train|
      train.wagons.each do |wag|
        break unless selected_wag == wag.number

        if wag.type == 'грузовой'
          puts "Введите объем для загрузки
                (Доступный объем: #{wag.wag_free_space})"
          volume = gets.chomp.to_i
          wag.load_space(volume)
        elsif wag.type == 'пассажирский'
          puts 'Занято, если было свободное'
          wag.load_space
        end
      end
    end
  end
end
