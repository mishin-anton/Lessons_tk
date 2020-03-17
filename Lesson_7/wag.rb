require_relative 'manufacturer'
require_relative 'validate'

class Wag
  include Manufacturer
  include Validate

  attr_accessor :number, :type, :free_space, :busy_space
  attr_reader :total_space

  NUMBER_FORMAT = /^[0-9]{5}/

  def initialize (number, type, total_space)
    @number = number
    @type = type
    @total_space = total_space
    @free_space = @total_space
    @busy_space = 0
    validate!
  end

  def load_space
    if @busy_space < @total_space
      @busy_space = @busy_space + 1
      @free_space = @free_space - 1
    end
  end

  def get_free_space
    @free_space
  end

  def get_busy_space
    @busy_space
  end

  protected

  def validate!
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end
