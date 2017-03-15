class Train  
  attr_accessor :car_quantity, :number, :type

  def initialize(number, type, car_quantity)
    self.number = number
    self.type = type
    self.car_quantity = car_quantity
    @speed = 0
  end

  def speed_up
    puts "Acceleration of speed by 10 m/h."
    @speed += 10
  end

  def current_speed
    puts "Current train's speed is #{@speed}."
  end

  def speed_down
    puts "Deceleration of speed by 10 m/h."
    @speed -= 10
  end

  def show_cars
    puts "Currently there are #{@car_quantity} cars connected to the train."
  end

  def change_cars_quantity
    puts "Do you want to add one car or to remove one?"
    puts "Type in 'add' to add 1 car or 'remove' to remove 1 car."
    user_choice = gets.chomp.downcase
    if user_choice == "add"
      @car_quantity +=1
    elsif user_choice == "remove"
      @car_quantity -=1
    end
  end

  def change_route(route_name)
    Route.show_routes
    @route_name = route_name
    @route_position = 0
    puts @route_name
  end

  def move_on_route
    puts "Do you want to move forward or backward?"
    user_choice = gets.chomp
    if user_choice == "forward"
      @route_position += 1 if @route_position < @route_name.route.length
    else
      @route_position -= 1 if @route_position > 0
    end
    puts @route_name.route[@route_position]
  end

  def show_station_neighbors
    if @route_position == 0
      puts @route_name.route[@route_position]
      puts @route_name.route[@route_position+1]
    elsif @route_position < @route_name.route.length
      puts @route_name.route[@route_position-1]
      puts @route_name.route[@route_position]
      puts @route_name.route[@route_position+1]
    else
      puts @route_name.route[@route_position-1]
      puts @route_name.route[@route_position]
    end
        
  end
end

class Route
  @@routes = []
  @@route_name = 0
  attr_accessor :route

  def initialize (first_station, last_station)    
    @route = [first_station, last_station]
    @@route_name +=1
    @route_name = @@route_name
    @@routes << @route_name
  end

  def add_station(station_name)
    @route << @route.last
    @route[-2] = station_name    
  end

  def delete_station (station_name)
    @route.each.with_index do |station, index| 
      station = station_name
      @route.delete_at(index) if @route[index] == station   
    end
  end

  def show_stations
    @route
  end

  def self.show_routes
    puts "Currently there are #{@@routes} routes."
  end
end



first_route = Route.new("Station1", "Station2")
first_route.add_station("Station3")
first_route.add_station("A")
#first_route.delete_station("Station2")
puts first_route.show_stations
#puts first_route.route.length

second_route = Route.new("St1", "St2")
second_route.add_station("St3")
#second_route.delete_station("St2")
puts second_route.show_stations

#puts Route.show_routes



first_train = Train.new(1, "passanger", 10)
puts first_train.show_cars
puts first_train.current_speed
first_train.change_route(first_route)
first_train.move_on_route
#first_train.move_on_route
#first_train.move_on_route 
puts
first_train.show_station_neighbors
puts first_train.change_cars_quantity