class Application

  def initialize    
    self.routes = []    
    self.stations = []    
    self.trains = []    
    self.cars = []     
    self.cars_free = []  
    self.ui = UI.new  
  end  
  


  def run    
    exit_program = "start"
    until exit_program == "exit"
      #UI
      @ui.run_ad
      @ui.input_1_change
      @ui.user_input1.downcase

      case @ui.user_input1
      when "trains"
        manage_trains    
      when "routes"
        manage_routes
      when "stations"
        manage_stations
      when "cars"
        manage_cars        
      else
        @ui.wrong_input_ad
      end

      @ui.run_exit_ad
      exit_program = gets.chomp.downcase
    end

  end

  
  private

  #As far as I understand methods below shouldn't be accessible outside of Application class
  #because user shouldn't be able to directly interact with those variables without interacting with UI first.
  attr_accessor :routes, :stations, :trains, :cars, :cars_free, :ui, :train_to_manage

  
  #Methods below should be accessible only through UI.
  def manage_trains
    @ui.manage_trains_selected_ad
    @ui.input_1_change
    @ui.user_input1.downcase

    case @ui.user_input1
    when "add"     
      manage_trains_add_train
    when "add route"
      manage_trains_add_route
    when "move"
      manage_trains_move
    when "cars"
      manage_trains_cars
    else
      @ui.wrong_input_ad
    end
  end

  def manage_trains_add_train
    @ui.manage_trains_add_selected_trains_show_ad; puts @ui.trains_numbers(trains); puts
    @ui.manage_trains_add_selected_type_train_question    
    @ui.input_1_change
    @ui.user_input1.downcase
    @ui.manage_trains_add_selected_number_train_question    
    @ui.input_2_change
    @ui.user_input2.downcase

    case @ui.user_input1
    when "passenger"
      train = PassengerTrain.new(@ui.user_input2)
      @trains << train            
    when "cargo"
      train = CargoTrain.new(@ui.user_input2)
      @trains << train            
    else
      train = PassengerTrain.new(@ui.user_input2)
      @trains << train            
    end    
    @ui.manage_trains_add_train_add_success_ad(train)    
    @ui.manage_trains_add_selected_trains_show_ad; puts @ui.trains_numbers(trains); puts   
    puts
  end 

  def manage_trains_add_route
    acceptable_train = false
    acceptable_route = false
    print "Currently there are several trains: "; puts @ui.trains_numbers(trains); puts
    puts
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    puts
    puts "Please type in train number and route name you want to assign to this train."
    puts "Please type in train number:"
    train_num = gets.chomp
    trains.each do |train|
      if train.number == train_num
        train_num = train
        acceptable_train = true
      end
    end    
    puts "Please type in route name:"
    route_name = gets.chomp
    routes.each do |route| 
      if route.name == route_name
        route_name = route 
        acceptable_route = true
      end
    end
    if acceptable_route && acceptable_train
      train_num.change_route(route_name) 
      puts "Train #{train_num.number} changed his route to #{route_name.name}."
    else
      puts "Unfortunately there is no such train or route."
    end
  end

  def manage_trains_move    
    acceptable_train = false
    puts "Please select train you want to move."
    print "Currently there are several trains: "; puts @ui.trains_numbers(trains); puts
    puts   
    puts "Please type in number of the train you want to move:"
    train_num = gets.chomp
    trains.each do |train|
      if train.number == train_num && train.route
        train_num = train
        acceptable_train = true
      end
    end
    if acceptable_train
      puts "Type in 'forward' if you want to move your train forward or 'backward' if you want to move your train backward."
      direction = gets.chomp
      train_num.move_forward if direction == "forward"
      train_num.move_backward if direction == "backward"
    end
  end

  def manage_trains_cars
    acceptable_train = false
    puts "Please select train you want to operate with."
    print "Currently there are several trains: "; puts @ui.trains_numbers(trains); puts           
    puts "Please type in number of the train you want to operate with:"
    self.train_to_manage = gets.chomp
    trains.each do |train|
      if train.number == train_to_manage
        self.train_to_manage = train
        acceptable_train = true
      end
    end
    if acceptable_train
      puts "Type in 'add' to add the car to the train or 'detach' to detach it."
      action = gets.chomp

      case action
      when "add"      
        manage_trains_cars_add        
      when "detach"
        manage_trains_cars_detach        
      else
        @ui.wrong_input_ad
      end
    end
  end

  def manage_trains_cars_add
    acceptable_car = false
    puts "Please select car to attach to the train."
    print "Currently there are several cars availible to attaching: "; puts @ui.print_car_ids(cars_free); puts
    puts "Please type in id of car you want to attach."
    car_id = gets.chomp
    cars_free.each do |car|
      if car.car_id == car_id
        car_id = car
        acceptable_car = true
      end
    end
    if acceptable_car
      train_to_manage.add_car(car_id)
      @cars_free.delete(car_id)                
    else
      puts "There is no car with this id number."
    end
  end

  def manage_trains_cars_detach
    acceptable_car = false
    puts "Please select car you want to detach."
    print "Currently there are several cars attached to the train: "    
    train_to_manage.cars.each { |car| print "#{car.car_id} "}    
    puts
    puts "Please type in id of car you want to detach."
    car_id = gets.chomp
    train_to_manage.cars.each do |car|
      if car.car_id == car_id
        car_id = car
        acceptable_car = true
      end
    end
    if acceptable_car
      train_to_manage.detach_car(car_id)
      @cars_free << car_id                              
    else
      puts "There is no such car currently attched to train #{train_to_manage.number}."
    end
  end

  def manage_routes
    puts "You are now in the managing routes program section."
    puts "Here you can add new routes and add station to this route or delete them."
    puts
    puts "Please type in 'add' to add new route, 'add station' to add station to this route,"
    puts "or 'delete station' to delete station from this route."
    routes_input = gets.chomp.downcase

    case routes_input
    when "add"
      manage_routes_add_route
    when "add station"
      manage_routes_add_station
    when "delete station"
      manage_routes_delete_station
    else
      @ui.wrong_input_ad
    end
  end

  def manage_routes_add_route    
    good_route = false
    good_station1 = false
    good_station2 = false
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts    
    puts "Please type in name of the first station for the new route."
    first_station = gets.chomp
    stations.each do |station|
      if station.name == first_station
        first_station = station 
        good_station1 = true
      end
    end
    puts "Please type in name of the last station for the new route."    
    last_staiton = gets.chomp
    stations.each do |station| 
      if station.name == last_staiton
        last_staiton = station 
        good_station2 = true
      end
    end
    good_route = true unless first_station == last_staiton || good_station1 == false || good_station2 == false
    if good_route == true
      route = Route.new(first_station, last_staiton)
      @routes << route            
      puts "New route #{route.name} has been created."
    else
      puts "Unfortunately route has not been created."
    end
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
  end

  def manage_routes_add_station
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    puts "Please type in route name you want to add station to."
    route_name = gets.chomp
    routes.each {|route| route_name = route if route.name == route_name}
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
    puts "Please type in station name you want to add to this route."
    station_name = gets.chomp
    stations.each {|station| station_name = station if station.name == station_name}
    route_name.add_station(station_name)
    puts "Station #{station_name.name} was successfully added to #{route_name.name}."
  end

  def manage_routes_delete_station
    print "Currently there are several routes: "; puts print_names(routes); puts
    puts "Please type in route name you want to delete station from."
    route_name = gets.chomp
    routes.each {|route| route_name = route if route.name == route_name}
    print "Currently there are several station on route #{route_name.name}: "; puts route_name.stations_names; puts 
    puts "Please type in station name you want to delete."
    station_name = gets.chomp
    route_name.stations.each {|station| station_name = station if station.name == station_name}
    puts "Unfortunately, you are unable to delete first or last station attached to route." if route_name.stations.length < 3
    route_name.delete_station(station_name)
    print "Currently there are several station on route #{route_name.name}: "; puts route_name.stations_names; puts
  end

  def manage_stations
    puts "Your are now in the managing stations program section."
    puts "Here you can add new stations or observe trains which are currently arrived on this station."
    puts "Please type in 'add' to add new station 'observe' to observe trains on station or 'list' to view list of existing stations."
    stations_input = gets.chomp.downcase

    case stations_input
    when "add"
      manage_stations_add_station          
    when "observe"
      manage_stations_observe_station
    when "list"
      manage_stations_list_stations      
    else
      puts "You've provided wrong type of input. Please try again."
    end
  end

  def manage_stations_add_station
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts    
    puts "Please type in name for your new station"
    station_name = gets.chomp
    station = Station.new(station_name)
    @stations << station          
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
  end

  def manage_stations_observe_station    
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
    puts "Please type in station you want to observe."
    station_name = gets.chomp
    stations.each do |station| 
      if station.name == station_name
        station_name = station
        print "Currently there are several trains on station #{station_name.name}: "
        station.trains.each {|train| print "#{train.number} "}
      end  
    end
    puts
  end

  def manage_stations_list_stations
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
  end

  def manage_cars
    puts "Here you can manage your cars by addding new cars or deleting cars."
    puts "Please type in 'add' to add cars or 'remove' to remove cars:"
    car_input = gets.chomp

    case car_input
    when "add"
      manage_cars_add_car      
    when "remove"
      manage_cars_remove_car      
    else
      puts "You've provided wrong type of input. Please try again."
    end
  end

  def manage_cars_add_car
    print "Currently there are several cars: "; puts @ui.print_car_ids(cars); puts
    puts "Do you want to add passenger or cargo car?"
    puts "Type in 'cargo' to add cargo car or 'passenger' to add passenger car:"
    car = ""      
    car_type = gets.chomp
    case car_type
    when "cargo"
      car = CargoCar.new
    when "passenger"
      car = PassengerCar.new
    else 
      car = PassengerCar.new
    end
    @cars << car
    @cars_free << car         
    puts "#{car.class.to_s.capitalize} car #{car.object_id} was succesfully added."
  end

  def manage_cars_remove_car
    print "Currently there are several cars: "; puts @ui.print_car_ids(cars); puts
    puts "Please type in car id of car you want to delete:"
    car_input = gets.chomp
    @cars.each do |car| 
      if car.car_id == car_input
        @cars.delete(car) 
        @cars_free.delete(car)             
      end
    end
  end  
end