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
      attempt = 0
      begin
        @ui.input_1_change
        @ui.user_input1.downcase
      raise "There is no such option in the main menu." unless @ui.user_input1 == "trains" || @ui.user_input1 == "routes" || @ui.user_input1 == "stations" || @ui.user_input1 == "cars"
        case @ui.user_input1
        when "trains"
          manage_trains    
        when "routes"
          manage_routes
        when "stations"
          manage_stations
        when "cars"
          manage_cars                
        end
      rescue RuntimeError => e
        attempt += 1
        puts e.inspect
        if attempt < 4
          @ui.wrong_input_msg
          retry
        end
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
    when "inst" #Test method for printing value of instance_counter (task form hw-5)
      puts PassengerTrain.instance_counter
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_add_train
    attempt = 0
    begin
      @ui.manage_trains_add_selected_trains_show_msg(trains)    
      train_type = gets.chomp.downcase
      train_number = gets.chomp
    raise "Unacceptable train number!" unless /^[\d\w]{3}-*[\d\w]{2}$/.match(train_number)
    raise "Unacceptable train type!" unless train_type == "passenger" || train_type == "cargo"
      create_train(train_type, train_number)   
    rescue RuntimeError => e
      attempt += 1
      puts e.inspect
      if attempt < 4
        @ui.wrong_input_msg        
        retry
      end
      raise "You've provided wrong type of input. Bad luck."
    end          
    puts
  end 

  def create_train(train_type, train_number)    
    unless @trains.find {|train_in_trains| train_in_trains.number == train_number}
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
      @ui.create_train_failed_msg
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
    attempt = 0
    begin  
      puts "Please type in name of the first station for the new route."
      first_station_name = gets.chomp    
    raise "Unexisting first station" unless stations.find{|station|station.name == first_station_name}
      puts "Please type in name of the last station for the new route."    
      last_staiton_name = gets.chomp
    raise "Unexisting second station" unless stations.find{|station| station.name == last_staiton_name}
    raise "First station are equal to last station" if first_station_name == last_staiton_name
      first_station = stations.find{|station|station.name == first_station_name}
      last_staiton = stations.find{|station| station.name == last_staiton_name}
      route = Route.new(first_station, last_staiton)
      @routes << route            
      puts "New route #{route.name} has been sucessfully created."
    rescue RuntimeError => e
      puts e.inspect
      attempt += 1
      if attempt < 4
        puts @ui.wrong_input_msg
        retry
      end
    end        
  end

  def manage_routes_add_station    
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
    attempt = 0
    begin
      puts "Please type in route name you want to add station to."
      route_name = gets.chomp
    raise "Unexisting route" unless routes.find{|route| route.name == route_name}
      puts "Please type in station name you want to add to this route."
      station_name = gets.chomp
    raise "Unexisting station" unless stations.find{|station| station.name == station_name}
      station = stations.find {|station| station.name == station_name}
      route = routes.find {|route| route.name == route_name}    
      route.add_station(station)
      puts "Station #{station.name} was successfully added to #{route.name}."
    rescue RuntimeError => e
      puts e.inspect
      attempt += 1
      if attempt < 4
        puts @ui.wrong_input_msg
        retry
      end
    end
  end

  def manage_routes_delete_station
    print "Currently there are several routes: "; puts @ui.print_names(routes); puts
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
    attempt = 0
    begin
      puts "Please type in route name you want to delete station from."
      route_name = gets.chomp        
    raise "Unexisting route" unless routes.find{|route| route.name == route_name}
      route = routes.find {|route| route.name == route_name}
    raise "Too short route" if route.stations.length < 2
      print "Currently there are several stations on route #{route.name}: "; puts route.stations_names; puts 
      puts "Please type in station name you want to delete."
      station_name = gets.chomp    
    raise "Unexisting station" unless route.stations.find{|station| station.name == station_name}
    raise "First station can not be deleted" if station_name == route.stations.first
    raise "Last station can not be deleted" if station_name == route.stations.last
      station = stations.find {|station| station.name == station_name}      
      route.delete_station(station)
      puts "Station #{station.name} has been succesfully removed from route #{route.name}."
    rescue RuntimeError => e
      puts e.inspect
      attempt += 1
      if attempt < 4
        puts @ui.wrong_input_msg
        retry
      end    
    end    
    
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
    attempt = 0
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts    
    begin
      puts "Please type in name for your new station"
      station_name = gets.chomp
    raise "Station already exists" if stations.find{|station| station.name == station_name}
    raise "Unacceptable station name" if station_name.length == 0
      station = Station.new(station_name)
      @stations << station          
      puts "Station #{station.name} has been succesfully added."
    rescue RuntimeError => e
      puts e.inspect
      attempt += 1
      if attempt < 4
        puts @ui.wrong_input_msg
        retry
      end
    end      
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
    attempt = 0
    begin
      puts "Type in 'cargo' to add cargo car or 'passenger' to add passenger car:"          
      car_type = gets.chomp
    raise "Unexisting car type" unless car_type == "cargo" || car_type == "passenger"
      car = "car exists"
      case car_type
      when "cargo"
        car = CargoCar.new
      when "passenger"
        car = PassengerCar.new      
      end
      @cars << car
      @cars_free << car         
      puts "#{car.class.to_s.capitalize} car #{car.object_id} was succesfully added."
    rescue RuntimeError => e
      puts e.inspect
      attempt += 1
      if attempt < 4         
        @ui.wrong_input_msg
        retry
      end
    end
  end

  def manage_cars_remove_car
    print "Currently there are several cars: "; puts @ui.print_car_ids(cars); puts
    attempt = 0
    begin
      puts "Please type in car id of car you want to delete:"
      car_to_del_id = gets.chomp
    raise "Unexisting car" unless cars.find{|car| car.car_id == car_to_del_id}
      car = cars.find{|car| car.car_id == car_to_del_id}    
      @cars.delete(car)
      @cars_free.delete(car)
      puts "Car was sucessfully deleted."
    rescue RuntimeError => e
      puts e.inspect
      attempt += 1
      if attempt < 4
        @ui.wrong_input_msg
        retry
      end
    end
  end

  def valid?()
    valid_object = true

  end
end