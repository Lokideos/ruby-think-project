class CargoTrain < Train
  include InstanceCounter

  private

  def correct_car?(car)
    car.is_a? CargoCar
  end
end
