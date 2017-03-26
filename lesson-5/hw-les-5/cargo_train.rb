class CargoTrain < Train  
  include InstanceCounter
  
  def correct_car?(car)       
    car.class == CargoCar
  end
end