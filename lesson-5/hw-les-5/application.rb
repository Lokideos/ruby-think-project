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
      @ui.run_msg
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
        @ui.wrong_input_msg
      end

      @ui.run_exit_msg
      exit_program = gets.chomp.downcase
    end

  end

  
  private

  #As far as I understand methods below shouldn't be accessible outside of Application class
  #because user shouldn't be able to directly interact with those variables without interacting with UI first.
  attr_accessor :routes, :stations, :trains, :cars, :cars_free, :ui
  
  #Methods below should be accessible only through UI.
  def manage_trains
    @ui.manage_trains_selected_msg
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
    when "inst"
      puts PassengerTrain.instance_counter
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_add_train
    @ui.manage_trains_add_selected_trains_show_msg; puts @ui.trains_numbers(trains); puts
    @ui.manage_trains_add_selected_type_train_question    
    @ui.input_1_change
    @ui.user_input1.downcase
    @ui.manage_trains_add_selected_number_train_question    
    @ui.input_2_change
    @ui.user_input2.downcase   
    create_train(@ui.user_input1, @ui.user_input2)     
    @ui.manage_trains_add_selected_trains_show_msg; puts @ui.trains_numbers(trains); puts   
    puts
  end 

  def create_train(train_type, train_number)
    unless @trains.find {|train_in_trains| train_in_trains.number == train_number && train_number == ""}
      case train_type
      when "passenger"
        train = PassengerTrain.new(train_number)
        @trains << train            
      when "cargo"
        train = CargoTrain.new(train_number)
        @trains << train            
      else
        train = PassengerTrain.new(train_number)
        @trains << train            
      end  
    else
      puts "Unfortunately train with this number already exists."
    end
      @ui.manage_trains_add_train_add_success_msg(train) unless train.nil?
  end


  def manage_trains_add_route   
    @ui.manage_trains_add_route_msg(trains, routes)    
    puts "Please type in train number:"
    train_number = gets.chomp     
    puts "Please type in route name:"
    route_name = gets.chomp    
    change_route(train_number, route_name)
  end

  def change_route(train_num, route_name)    
    train = trains.find {|train_in_trains| train_in_trains.number == train_num}
    route = routes.find {|route_in_routes| route_in_routes.name == route_name}
    
    if train && route
      train.change_route(route) 
      puts "Train #{train.number} changed his route to #{route.name}."
    else
      puts "Unfortunately there is no such train or route."
    end   
  end

  def manage_trains_move    
    @ui.manage_trains_move_msg(trains)    
    puts "Please type in number of the train you want to move:"
    train_number = gets.chomp
    train_move_on_route(train_number)    
  end

  def train_move_on_route(train_num)    
    train = trains.find{|train_in_trains| train_in_trains.number == train_num && train_in_trains.route}
    if train      
      puts "Type in 'forward' if you want to move your train forward or 'backward' if you want to move your train backward."
      direction = gets.chomp
      train.move_forward if direction == "forward"
      train.move_backward if direction == "backward"
    else
      puts "Unfortunately train with this number does not exists."
    end
  end

  def manage_trains_cars    
    puts "Please select train you want to operate with."
    print "Currently there are several trains: "; puts @ui.trains_numbers(trains); puts           
    puts "Please type in number of the train you want to operate with:"
    train_to_manage_number = gets.chomp
    add_correct_car(train_to_manage_number)    
  end

  def add_correct_car(train_num)
    train = trains.find{|train_in_trains| train_in_trains.number == train_num}
    if train      
      puts "Type in 'add' to add the car to the train or 'detach' to detach it."
      action = gets.chomp

      case action
      when "add"      
        manage_trains_cars_add(train)        
      when "detach"
        manage_trains_cars_detach(train)     
      else
        @ui.wrong_input_msg
      end
    end
  end

  def manage_trains_cars_add(train)    
    puts "Please select car to attach to the train."
    print "Currently there are several cars availible to attaching: "; puts @ui.print_car_ids(cars_free); puts
    puts "Please type in id of car you want to attach."
    car_to_add_id = gets.chomp
    car = cars_free.find{|car| car.car_id == car_to_add_id}
    if car      
      train.add_car(car)
      if train.send :correct_car?, car
        @cars_free.delete(car) 
      else
        puts "Unfortunately car's type and train's type are different."
      end
    else
      puts "There is no car with this id number."
    end
  end

  def manage_trains_cars_detach(train)    
    puts "Please select car you want to detach."
    print "Currently there are several cars attached to the train: "    
    train.cars.each { |car| print "#{car.car_id} "}    
    puts
    puts "Please type in id of car you want to detach."
    car_to_detach_id = gets.chomp
    car = cars_free.find{|car| car.car_id == car_to_detach_id}
    if car      
      train.detach_car(car)
      @cars_free << car if train.correct_car?(car)                
    else
      puts "There is no such car currently attched to train #{train.number}."
    end
  end

  def manage_routes
    @ui.manage_routes_msg   
    routes_input = gets.chomp.downcase

    case routes_input
    when "add"
      manage_routes_add_route
    when "add station"
      manage_routes_add_station
    when "delete station"
      manage_routes_delete_station
    else
      @ui.wrong_input_msg
    end
  end

  def manage_routes_add_route       
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts    
    puts "Please type in name of the first station for the new route."
    first_station_name = gets.chomp    

    puts "Please type in name of the last station for the new route."    
    last_staiton_name = gets.chomp

    first_station = stations.find{|station| station.name == first_station_name}
    last_station = stations.find{|station| station.name == last_staiton_name && last_station_name != first_station_name}

    if first_station && last_station      
      route = Route.new(first_station, last_staiton)
      @routes << route            
      puts "New route #{route.name} has been created."
    else
      puts "Unfortunately route has not been created. There are problems with your station names."
    end

    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
  end

  def manage_routes_add_station
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    puts "Please type in route name you want to add station to."
    route_name = gets.chomp    
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
    puts "Please type in station name you want to add to this route."
    station_name = gets.chomp

    station = stations.find {|station| station.name == station_name}
    route = routes.find {|route| route.name == route_name}

    if route && station
      route.add_station(station)
      puts "Station #{station_name} was successfully added to #{route_name}."
    else
      puts "Unfortunately station #{station_name} was not added to route #{route_name}."
    end
  end

  def manage_routes_delete_station
    print "Currently there are several routes: "; puts print_names(routes); puts
    puts "Please type in route name you want to delete station from."
    route_name = gets.chomp    
    print "Currently there are several station on route #{route_name.name}: "; puts route_name.stations_names; puts 
    puts "Please type in station name you want to delete."
    station_name = gets.chomp    

    station = stations.find {|station| station.name == station_name}
    route = routes.find {|route| route.name == route_name}

    if route && station && route.statoins.length > 2
      route.delete_station(station)
    else
      puts "Unfortunately, you are unable to delete first or last station attached to route or there is no such station or route."
    end    
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

    station = stations.find {|station| station.name == station_name}

    if station 
      print "Currently there are several trains on station #{station_name.name}: "
      station.trains.each {|train| print "#{train.number} "}
      puts
    end    
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
    car_type = gets.chomp

    car = "car exists"
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
    car_to_del_id = gets.chomp

    car = cars.find{|car| car.id == car_to_del_id}
    if car
      @cars.delete(car)
      @cars_free.delete(car)
    end    
  end

end