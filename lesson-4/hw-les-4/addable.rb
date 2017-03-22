#Not used in program yet
module Addable
  def add_car(car)
    super
    @cars.delete(car) unless car.class == PassengerCar && self.class == PassengerTrain || car.class == CargoCar && self.class == CargoTrain		
  end
end