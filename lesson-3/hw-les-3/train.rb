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
