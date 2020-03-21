# frozen_string_literal: true

require_relative 'instancecounter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

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
    validate!
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains
    puts "Поезда на станции #{@name}: "
    @trains.each { |train| puts train.number.to_s }
  end

  def show_trains_by_type(type)
    @typelist = @trains.map(&:type)
    puts "Количество #{type} вагонов: #{@typelist.count(type)}"
  end

  def each_train(_block)
    @trains.each do |train|
      yield(train)
    end
  end
end
