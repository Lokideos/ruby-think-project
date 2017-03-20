class Car
  @@id_counter = 1
  attr_accessor :attached
  attr_reader :type, :car_id
  @@cars = []

  def initialize
    @car_id = @@id_counter
    @type = :default_car
    self.attached = false
    @@id_counter += 1
    @@cars << self
  end

  def self.cars
    @@cars
  end

  def self.car_ids
    @@cars.each {|car| print " #{car.car_id}" if car.attached == false}
    puts
    puts
  end

end