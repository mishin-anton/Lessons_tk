class Station
  attr_accessor :name
  attr_reader :trains

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
    puts "Поезда на станции #{@name}: "
    @trains.each { |train| puts "#{train.number}" }
  end

  def show_trains_by_type(type)
    @typelist = @trains.map { |train| train.type }
    puts "Количество #{type} вагонов: #{@typelist.count(type)}"
  end
end
