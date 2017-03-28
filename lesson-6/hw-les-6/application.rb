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
    when "inst" #Test method for printing value of instance_counter (task form hw-5)
      puts PassengerTrain.instance_counter
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_add_train    
    begin  
      @ui.manage_trains_add_selected_trains_show_msg(trains)    
      train_type = gets.chomp.downcase
      train_number = gets.chomp
    raise unless valid?(:trains, train_type, train_number)
      create_train(train_type, train_number) 
    rescue RuntimeError
        @attempt += 1
      if @attempt < 3
        @ui.wrong_input_msg
        retry        
      end
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
    train_number = gets.chomp    
    route_name = gets.chomp    
    change_route(train_number, route_name)
  end

  def change_route(train_num, route_name)    
    train = trains.find {|train_in_trains| train_in_trains.number == train_num}
    route = routes.find {|route_in_routes| route_in_routes.name == route_name}
    
    if train && route
      train.change_route(route) 
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
      train.add_car(car)
      @ui.manage_trains_cars_add_success_msg(train, car)
      if train.send :correct_car?, car
        @cars_free.delete(car) 
      else
        @ui.manage_trains_cars_add_existance_car_error_msg(train)
      end
    else
      @ui.manage_trains_cars_add_error_msg
    end
  end

  def manage_trains_cars_detach(train)    
    @ui.manage_trains_cars_detach_msg(train)    
    car_to_detach_id = gets.chomp
    car = cars_free.find{|car| car.car_id == car_to_detach_id}
    if car      
      train.detach_car(car)      
      @ui.manage_trains_cars_detach_success_msg(train, car)
      @cars_free << car if train.correct_car?(car)                
    else
      @ui.manage_trains_cars_add_error_msg(train)
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
    last_staiton_name = gets.chomp      
    first_station = stations.find{|station|station.name == first_station_name}
    last_staiton = stations.find{|station| station.name == last_staiton_name}
    route = Route.new(first_station, last_staiton)
    @routes << route            
    @ui.manage_routes_add_route_success_msg(route)
  rescue RuntimeError => e      
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
    else
      @ui.wrong_input_msg
    end
  end

  def manage_stations_add_station        
    @ui.manage_stations_add_station_msg(stations)    
    @ui.manage_stations_add_station_input_msg
    station_name = gets.chomp    
    station = Station.new(station_name)
    @stations << station          
    @ui.manage_stations_add_station_success_msg(station)
  rescue RuntimeError    
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
      puts @ui.wrong_input_msg
    end
  end

  def manage_cars_add_car    
    @ui.manage_cars_add_car_msg(cars)
    begin
      @ui.manage_cars_add_car_input_msg         
      car_type = gets.chomp
    raise unless valid?(:car_add, car_type)
      car = "car exists"
      case car_type
      when "cargo"
        car = CargoCar.new
      when "passenger"
        car = PassengerCar.new      
      end
      @cars << car
      @cars_free << car         
      @ui.manage_cars_add_car_success_msg(car)
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

  def manage_cars_remove_car
    @ui.manage_cars_remove_car_msg(cars)
    begin
      @ui.manage_cars_remove_car_input_msg      
      car_to_del_id = gets.chomp
    raise unless valid?(:car_remove, "d", "d", "d", "d", car_to_del_id)
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

  # def valid?(check_type, train_cargo_type="default", train_number="default", first_station_name="default", 
  #             last_staiton_name="default", station_name="default", car_managed_id = "default") 
  #   valid = false
  #   case check_type
  #   when :trains
  #     begin
  #     raise "Unacceptable train number!" unless /^[\d\w]{3}-*[\d\w]{2}$/.match(train_number)
  #     raise "Unacceptable train type!" unless train_cargo_type == "passenger" || train_cargo_type == "cargo"
  #       valid = true 
  #     rescue RuntimeError => e     
  #       puts e.inspect        
  #     end
  #   when :routes
  #     begin
  #     raise "Unexisting first station" unless stations.find{|station|station.name == first_station_name}
  #     raise "Unexisting second station" unless stations.find{|station| station.name == last_staiton_name}
  #     raise "First station are equal to last station" if first_station_name == last_staiton_name
  #       valid = true 
  #     rescue RuntimeError => e
  #       puts e.inspect
  #     end
  #   when :stations
  #     begin
  #     raise "Station already exists" if stations.find{|station| station.name == station_name}
  #     raise "Unacceptable station name" if station_name.length == 0
  #       valid = true 
  #     rescue RuntimeError => e
  #       puts e.inspect
  #     end
  #   when :car_add
  #     begin
  #     raise "Unexisting car type" unless train_cargo_type == "cargo" || train_cargo_type == "passenger"
  #       valid = true 
  #     rescue RuntimeError => e
  #       puts e.inspect
  #     end
  #   when :car_remove
  #     begin  
  #     raise "Unexisting car" unless cars.find{|car| car.car_id == car_managed_id}
  #       valid = true 
  #     rescue RuntimeError => e
  #       puts e.inspect
  #     end
  #   else
  #     begin
  #     raise "Unexisting data class. How did you end up here btw?"
  #       valid = true 
  #     rescue RuntimeError => e
  #       puts e.inspect
  #     end
  #   end
  #   valid
  # end

end