class PassengerTrain < Train
  def initialize (number)
    @number = number
    @type = "пассажирский"
    @wagons = []
  end

  def add_wag (wag)
    @wagons << wag
  end
end
