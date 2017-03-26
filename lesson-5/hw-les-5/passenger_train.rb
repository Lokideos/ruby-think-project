class PassengerTrain < Train  
  def correct_car?(car)
    car_has_correct_type = car.class == PassengerCar
  end
end