class PassengerTrain < Train
  include InstanceCounter
  private
  
  def correct_car?(car)
    car.class == PassengerCar
  end  
end