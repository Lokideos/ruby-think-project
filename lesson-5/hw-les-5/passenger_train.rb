class PassengerTrain < Train
  include InstanceCounter
  
  def correct_car?(car)
    car.class == PassengerCar
  end  
end