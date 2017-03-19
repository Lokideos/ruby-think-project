class Vehicle
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon"
  end

  def to_s
    puts "Overrided object print out!"
  end
end

class Mycar < Vehicle

  CONST_TYPE = "CAR"

  
end

class MyTruck < Vehicle
  CONST_TYPE = "TRUCK"
end

Mycar.gas_mileage(10,500)

car = Mycar.new
puts car