class CargoTrain < Train
  attr_reader :wagons

  def initialize (number)
    @number = number
    @type = "грузовой"
    @wagons = []
  end

  def add_wag (wag)
    @wagons << wag
  end
end
