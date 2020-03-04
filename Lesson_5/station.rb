require_relative 'instancecounter'

class Station
  include InstanceCounter

  def self.all
    @all ||= []
  end

  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    register_instance
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
