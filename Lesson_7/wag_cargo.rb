require_relative 'validate'

class CargoWag < Wag
  include Validate

  attr_reader :total_volume
  attr_accessor :free_volume, :busy_volume

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number, total_volume)
    @number = number
    @type = "грузовой"
    @total_volume = total_volume
    @free_volume = @total_volume
    @busy_volume = 0
    validate!
  end

  def take_volume (volume)
    if (@free_volume - volume) >= 0
      @busy_volume = @busy_volume + volume
      @free_volume = @free_volume - volume
    end
  end

  def get_busy_volume
    @busy_volume
  end

  def get_free_volume
    @free_volume
  end

  protected

  def validate!
    raise "Wagon number has invalid format" if number !~ NUMBER_FORMAT
  end
end
