class CargoTrain < Train  
  include InstanceCounter
  private
  
  def correct_car?(car)       
    car.class == CargoCar
  end
end