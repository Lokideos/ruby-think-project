class PassengerTrain < Train  
  def add_car(car)
    super
    @cars.delete(car) unless car.class == PassengerCar && self.class == PassengerTrain
  end
end