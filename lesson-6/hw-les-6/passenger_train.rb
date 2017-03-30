class PassengerTrain < Train
  include InstanceCounter

  private
  
  def correct_car?(car)
    car.is_a? PassengerCar
  end  
end