class CargoTrain < Train  
  def correct_car?(car)       
    car.class == CargoCar
  end
end