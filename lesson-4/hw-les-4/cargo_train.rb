class CargoTrain < Train
  def add_car(car)
    super
    @cars.delete(car) unless car.class == CargoCar && self.class == CargoTrain   
  end
end