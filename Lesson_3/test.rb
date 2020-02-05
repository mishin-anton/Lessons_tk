# TEST
load 'station.rb'
load 'train.rb'
load 'route.rb'


station_lublino = Station.new("Люблино")
station_kuncevo = Station.new("Кунцево")
station_bryansk = Station.new("Брянск")
station_partizansk = Station.new("Партизанск")

route_europe_asia = Route.new("Европа-Азия", station_bryansk, station_partizansk)
route_europe_asia.add_interval_station(station_kuncevo)
route_europe_asia.add_interval_station(station_lublino)

cargo_trk = Train.new("55689688", "грузовой", 20)
cargo_transmash = Train.new("55889900", "грузовой", 35)
rgd_msk_bryansk = Train.new("88904477", "пассажирский", 17)
rgd_msk_partizansk = Train.new("44976378", "пассажирский", 23)

puts "\nИНФОРМАЦИЯ ПО СТАНЦИЯМ"
station_lublino.add_train(cargo_trk)
station_lublino.add_train(cargo_transmash)
station_lublino.show_train_list
station_lublino.show_train_list_by_type

puts "Отправить поезд 55689688 со станции Люблино"
station_lublino.send_train(cargo_trk)
station_lublino.show_train_list

puts "\nИНФОРМАЦИЯ ПО МАРШРУТАМ"
route_europe_asia.show_route
puts "\nУдалить станцию Люблино из маршрута"
route_europe_asia.delete_interval_station(station_lublino)
route_europe_asia.show_route

puts "\n\nИНФОРМАЦИЯ ПО ПОЕЗДАМ"
puts "55689688 скорость: #{cargo_trk.speed}"
puts "55689688 увеличить скорость на 10 км/ч!"
cargo_trk.speed_up(10)
puts "55689688 текущая скорость: #{cargo_trk.speed}"
puts "55689688 остановить! "
cargo_trk.stop
puts "55689688 текущая скорость: #{cargo_trk.speed}"
puts "55689688 вагонов в поезде: #{cargo_trk.quantity}"
puts "55689688 подцепить вагон в поезд!"
cargo_trk.add_wag
puts "55689688 вагонов в поезде: #{cargo_trk.quantity}"
puts "55689688 удалить вагон из поезда!"
cargo_trk.remove_wag
puts "55689688 вагонов в поезде: #{cargo_trk.quantity}"

cargo_trk.add_route(route_europe_asia)
cargo_trk.move_forward
cargo_trk.move_forward
# cargo_trk.move_back

cargo_trk.return_stations
