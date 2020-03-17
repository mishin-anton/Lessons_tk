require_relative 'validate'

class CargoWag < Wag
  include Validate

  attr_reader :total_space
  attr_accessor :free_space, :busy_space

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number, total_space)
    @number = number
    @type = "грузовой"
    @total_space = total_space
    @free_space = @total_space
    @busy_space = 0
    validate!
  end

  def load_space (space)
    if (@free_space - space) >= 0
      @busy_space = @busy_space + space
      @free_space = @free_space - space
    end
  end

  protected

  def validate!
    raise "Wagon number has invalid format" if number !~ NUMBER_FORMAT
  end
end
