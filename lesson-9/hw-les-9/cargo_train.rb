class CargoTrain < Train
  include InstanceCounter
  include Validation

  validate :number, :format, /^[\d\w]{3}-*[\d\w]{2}$/

  private

  def correct_car?(car)
    car.is_a? CargoCar
  end
end
