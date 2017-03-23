class CargoTrain < Train
  def correct_car?(car)       
    car_has_correct_type = car.class == CargoCar
  end
end