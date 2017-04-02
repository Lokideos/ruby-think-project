class Application

  def initialize    
    self.routes = []    
    self.stations = []    
    self.trains = []    
    self.cars = []     
    self.cars_free = []  
    self.attempt = 0
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
        unless %w(trains routes stations cars).include? @ui.user_input1
          raise "There is no such option in the main menu."
        end        
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
  attr_accessor :routes, :stations, :trains, :cars, :cars_free, :ui, :attempt
  
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
    when "observe"      
      manage_trains_choose_train
    when "inst" #Test method for printing value of instance_counter (task form hw-5)
      puts PassengerTrain.instance_counter
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_choose_train    
    @ui.manage_trains_choose_train_msg(trains)
    train_number = gets.chomp
    train = trains.find{|train_in_trains| train_in_trains.number == train_number}
    if train
      manage_trains_observe_cargo_train(train) if train.is_a? CargoTrain
      manage_trains_observe_passenger_train(train) if train.is_a? PassengerTrain
    else 
      @ui.wrong_input_msg
    end
  end

  def manage_trains_observe_cargo_train(train)
    puts "To train number #{train.number} currently attached following cars:"
    train.each_car do |car| 
      print "Car number: #{car.car_id}; "
      print "car type is Cargo; "
      print "occupied space: #{car.volume - car.free_volume}; "
      puts "free space: #{car.free_volume}."
    end
  end

  def manage_trains_observe_passenger_train(train)
    puts "To train number #{train.number} currently attached following cars:"
    train.each_car do |car|
      print "Car number: #{car.car_id}; "
      print "car type is Passenger; " 
      print "taken seats: #{car.seats - car.free_seats}; "
      puts "free seats: #{car.free_seats}"
    end
  end

  def manage_trains_add_train        
    @ui.manage_trains_add_selected_trains_show_msg(trains)    
    train_type = gets.chomp.downcase
    train_number = gets.chomp    
    create_train(train_type, train_number)    
    rescue RuntimeError => e
        puts e.inspect
        @attempt += 1
      if @attempt < 3
        @ui.wrong_input_msg
        retry        
      end    
    @attempt = 0   
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
        train = Train.new(train_number)
        @trains << train            
      end  
    else
      @ui.create_train_failed_msg
    end
    @ui.manage_trains_add_train_add_success_msg(train) unless train.nil?    
  end


  def manage_trains_add_route   
    @ui.manage_trains_add_route_msg(trains, routes)   
    train_number = gets.chomp    
    route_name = gets.chomp    
    change_route(train_number, route_name)
  end

  def change_route(train_num, route_name)    
    train = trains.find {|train_in_trains| train_in_trains.number == train_num}
    route = routes.find {|route_in_routes| route_in_routes.name == route_name}
    
    if train && route
      train.change_route(route) 
      route.stations[0].train_arrival(train)
      @ui.change_route_good_route_msg(train, route)
    else
      @ui.change_route_bad_route_msg
    end   
  end

  def manage_trains_move    
    @ui.manage_trains_move_msg(trains)    
    train_number = gets.chomp
    train_move_on_route(train_number)    
  end

  def train_move_on_route(train_num)    
    train = trains.find{|train_in_trains| train_in_trains.number == train_num && train_in_trains.route}
    if train      
      @ui.train_move_on_route_direction_msg
      direction = gets.chomp
      train.move_forward if direction == "forward"
      train.move_backward if direction == "backward"
    else
      @ui.train_move_on_route_bad_msg
    end
  end

  def manage_trains_cars    
    @ui.manage_trains_cars_msg(trains)
    train_to_manage_number = gets.chomp
    add_correct_car(train_to_manage_number)    
  end

  def add_correct_car(train_num)
    train = trains.find{|train_in_trains| train_in_trains.number == train_num}
    if train      
      @ui.add_correct_car_action_msg
      action = gets.chomp

      case action
      when "add"      
        manage_trains_cars_add(train)        
      when "detach"
        manage_trains_cars_detach(train) 
      when "occupy"        
        manage_trains_cars_choose_car(train)    
      else
        @ui.wrong_input_msg
      end
    end
  end

  def manage_trains_cars_add(train)    
    @ui.manage_trains_cars_add_msg(cars_free)    
    car_to_add_id = gets.chomp
    car = cars_free.find{|car| car.car_id == car_to_add_id}
    if car            
      if train.send :correct_car?, car
        train.add_car(car)
        @cars_free.delete(car) 
        @ui.manage_trains_cars_add_success_msg(train, car)
      else
        @ui.manage_trains_cars_add_existance_car_error_msg(train)
      end
    else
      @ui.manage_trains_cars_add_error_msg
    end
  end

  def manage_trains_cars_detach(train)    
    @ui.cars_attached_to_train_msg(train)    
    car_to_detach_id = gets.chomp
    car = train.cars.find{|car| car.car_id == car_to_detach_id}
    if car      
      train.detach_car(car)      
      @ui.manage_trains_cars_detach_success_msg(train, car)
      @cars_free << car if train.send :correct_car?, car 
    else
      @ui.manage_trains_cars_add_error_msg
    end
  end

  def manage_trains_cars_choose_car(train)
    @ui.manage_trains_cars_choose_car_msg(train)
    car_to_occupy_id = gets.chomp
    car = train.cars.find{|car| car.car_id == car_to_occupy_id}
    if car
      manage_trains_cars_occupy(car)    
    else 
      @ui.wrong_input_msg
    end
  end

  def manage_trains_cars_occupy(car)
    if car.is_a? CargoCar
      @ui.manage_trains_occupy_set_volume_msg
      volume = gets.chomp.to_f
      car.occupy_volume(volume)  
      @ui.manage_trains_occupy_success_cargo_msg(car)
    elsif car.is_a? PassengerCar
      car.take_seat
      @ui.manage_trains_occupy_success_passenger_msg(car)
    else
      @ui.wrong_input_msg
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
    @ui.manage_routes_add_route_msg(routes, stations)       
    @ui.manage_routes_add_route_input_msg      
    first_station_name = gets.chomp              
    last_station_name = gets.chomp      
    first_station = stations.find{|station|station.name == first_station_name}
    last_station = stations.find{|station| station.name == last_station_name}
    route = Route.new(first_station, last_station)
    @routes << route            
    @ui.manage_routes_add_route_success_msg(route)
    rescue RuntimeError => e 
      puts e.inspect     
      @attempt += 1
      if @attempt < 3
        puts @ui.wrong_input_msg
        retry
      end        
    @attempt = 0
  end

  def manage_routes_add_station
    @ui.manage_routes_add_station_msg(routes, stations)            
    begin
      @ui.manage_routes_add_station_input_msg      
      route_name = gets.chomp      
      station_name = gets.chomp
    raise "Unexisting route" unless routes.find{|route| route.name == route_name}
    raise "Unexisting station" unless stations.find{|station| station.name == station_name}
      station = stations.find {|station| station.name == station_name}
      route = routes.find {|route| route.name == route_name}    
      route.add_station(station)
      @ui.manage_routes_add_station_success_msg(station, route)
    rescue RuntimeError => e
      puts e.inspect
      @attempt += 1
      if @attempt < 4
        puts @ui.wrong_input_msg
        retry
      end
    end
    @attempt = 0
  end

  def manage_routes_delete_station
    @ui.manage_routes_delete_station_msg(routes, stations)        
    begin
      @ui.manage_routes_delete_station_input_route_msg      
      route_name = gets.chomp        
    raise "Unexisting route" unless routes.find{|route| route.name == route_name}
      route = routes.find {|route| route.name == route_name}
    raise "Too short route" if route.stations.length < 2
      @ui.manage_routes_delete_station_input_station_msg(route)      
      station_name = gets.chomp    
    raise "Unexisting station" unless route.stations.find{|station| station.name == station_name}
    raise "First station can not be deleted" if station_name == route.stations.first
    raise "Last station can not be deleted" if station_name == route.stations.last
      station = stations.find {|station| station.name == station_name}      
      route.delete_station(station)
      @ui.manage_routes_delete_station_success_msg(station, route)
    rescue RuntimeError => e
      puts e.inspect
      @attempt += 1
      if @attempt < 4
        @ui.wrong_input_msg
        retry
      end    
    end    
    @attempt = 0
  end

  def manage_stations
    @ui.manage_stations_msg    
    stations_input = gets.chomp.downcase

    case stations_input
    when "add"
      manage_stations_add_station          
    when "observe"
      manage_stations_observe_station
    when "list"
      manage_stations_list_stations      
    when "trains"
      manage_stations_choose_station
      #choose station -> see atttached trains in Number->Type->CarsQuantity format
    else
      @ui.wrong_input_msg
    end
  end

  def manage_stations_choose_station
    @ui.manage_stations_choose_station_msg(stations)
    station_name = gets.chomp
    station = stations.find {|station| station.name == station_name}
    if station
      manage_stations_observe_trains(station)
    else
      @ui.wrong_input_msg
    end
  end

  def manage_stations_observe_trains(station)
    puts "On station named #{station.name} currently arrived several trains:"
    station.each_train do |train|
      print "Train number: #{train.number}; "
      print "train type is #{train.class}; " 
      puts "attached to train cars: #{train.cars.size}."      
    end
  end

  def manage_stations_add_station        
    @ui.manage_stations_add_station_msg(stations)    
    @ui.manage_stations_add_station_input_msg
    station_name = gets.chomp    
    station = Station.new(station_name)
    @stations << station          
    @ui.manage_stations_add_station_success_msg(station)
    rescue RuntimeError => e
      puts e.inspect
      @attempt += 1
      if @attempt < 3
        puts @ui.wrong_input_msg
        retry
      end  
    @attempt = 0      
  end

  def manage_stations_observe_station    
    @ui.manage_stations_observe_station_msg(stations)
    station_name = gets.chomp
    station = stations.find {|station| station.name == station_name}
    if station 
      @ui.manage_stations_observe_station_observe_msg(station)
    end    
  end

  def manage_stations_list_stations
    print "Currently there are several stations: "; puts @ui.print_names(stations); puts
  end

  def manage_cars
    @ui.manage_cars_msg
    car_input = gets.chomp

    case car_input
    when "add"
      manage_cars_add_car      
    when "remove"
      manage_cars_remove_car     
    else
      @ui.wrong_input_msg
    end
  end

  

  def manage_cars_add_car    
    @ui.manage_cars_add_car_msg(cars)
    @ui.manage_cars_add_car_input_msg         
    car_type = gets.chomp
    car = "car exists"
    case car_type
    when "cargo"
      @ui.manage_cars_add_car_input_volume_msg
      volume = gets.chomp.to_f
      car = CargoCar.new(volume)
    when "passenger"
      @ui.manage_cars_add_car_input_seats_msg
      seats = gets.chomp.to_i
      car = PassengerCar.new(seats)
    else
      car = Car.new("false")
    end
    @cars << car
    @cars_free << car         
    @ui.manage_cars_add_car_success_msg(car)
    rescue RuntimeError => e
      puts e.inspect
      @attempt += 1
      if @attempt < 3        
        @ui.wrong_input_msg
        retry
      end    
    @attempt = 0
  end

  def manage_cars_remove_car
    @ui.manage_cars_remove_car_msg(cars)
    begin
      @ui.manage_cars_remove_car_input_msg      
      car_to_del_id = gets.chomp
    raise "Unexisting car" unless cars.find{|car| car.car_id == car_to_del_id}
      car = cars.find{|car| car.car_id == car_to_del_id}    
      @cars.delete(car)
      @cars_free.delete(car)
      @ui.manage_cars_remove_car_success_msg
    rescue RuntimeError
      puts e.inspect
      @attempt += 1
      if attempt < 3
        @ui.wrong_input_msg
        retry
      end
    end
    @attempt = 0
  end

end