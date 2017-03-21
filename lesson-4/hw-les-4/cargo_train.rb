class CargoTrain < Train
  def add_car(car)
    if car.class == CargoCar && speed == 0
      adding_car = true
      @cars.each {|car_on_train| adding_car = false if car_on_train.car_id == car.car_id}
      if adding_car
        @cars << car 
        car.attached = true
      end
    end
  end  
end