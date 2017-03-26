class PassengerTrain < Train
  def correct_car?(car)
    car.class == PassengerCar
  end  
end