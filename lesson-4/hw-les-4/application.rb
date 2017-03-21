class Application
  @@routes = []
  @@routes_names = []
  @@stations = []
  @@stations_names = []
  @@trains = []
  @@trains_numbers = []
  @@cars = [] 
  @@cars_ids_all = []
  @@cars_free = []
  @@cars_free_ids = []

  def self.run    
    #UI
    puts "Please type in 'trains' for managing your trains, 'routes' for managing your routes, 'stations' to managing your stations or 'cars' to add or delete cars."
    user_input = gets.chomp.downcase
    case user_input

    when "trains"
      puts "You are now in the managing trains program section."
      puts "Here you can add new trains, assign route to train, add cars to train, detach them from train."
      puts "Also here you can move your train on the route."
      puts
      puts "Please type in 'add' to add the train, 'add route' to assign route to the train;"
      puts "type in 'move' to move train on his route or 'cars' to add or detach car from train."
      trains_input = gets.chomp.downcase
      case trains_input

      when "add"
        print "Currently there are several trains: "; puts trains_numbers; puts
        puts "Do you want to add passenger or cargo train?"
        train_type = gets.chomp.downcase
        puts "Please type in number for your train to add."
        train_num = gets.chomp
        case train_type
        when "passenger"
          train = PassengerTrain.new(train_num)
          @@trains << train
          @@trains_numbers << train.number
        when "cargo"
          train = CargoTrain.new(train_num)
          @@trains << train
          @@trains_numbers << train.number
        else
          train = PassengerTrain.new(train_num)
          @@trains << train
          @@trains_numbers << train.number
        end    
        puts "You've added #{train.number} train."
        print "Currently there are several trains: "; puts trains_numbers; puts   
        puts

      when "add route"
        acceptable_train = false
        acceptable_route = false
        print "Currently there are several trains: "; puts trains_numbers; puts
        puts
        print "Currently there are several routes: "; puts routes_names; puts
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

      when "move"
        acceptable_train = false
        puts "Please select train you want to move."
        print "Currently there are several trains: "; puts trains_numbers; puts
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

      when "cars"   
        acceptable_train = false
        puts "Please select train you want to operate with."
        print "Currently there are several trains: "; puts trains_numbers; puts           
        puts "Please type in number of the train you want to operate with:"
        train_num = gets.chomp
        trains.each do |train|
          if train.number == train_num
            train_num = train
            acceptable_train = true
          end
        end
        if acceptable_train
          puts "Type in 'add' to add the car to the train or 'detach' to detach it."
          action = gets.chomp
          case action
          when "add"              
            acceptable_car = false
            puts "Please select car to attach to the train."
            print "Currently there are several cars availible to attaching: "; puts cars_free_ids; puts
            puts "Please type in id of car you want to attach."
            car_id = gets.chomp.to_i
            cars_free.each do |car|
              if car.car_id == car_id
                car_id = car
                acceptable_car = true
              end
            end
            if acceptable_car
              train_num.add_car(car_id)
              @@cars_free.delete(car_id)
              @@cars_free_ids.delete(car_id.car_id)
            else
              puts "There is no car with this id number."
            end
          when "detach"
            acceptable_car = false
            puts "Please select car you want to detach."
            print "Currently there are several cars attached to the train: "
            train_num.cars.each do |car|
              print "#{car.car_id} "
            end
            puts
            puts "Please type in id of car you want to detach."
            car_id = gets.chomp.to_i
            train_num.cars.each do |car|
              if car.car_id == car_id
                car_id = car
                acceptable_car = true
              end
            end
            if acceptable_car
              train_num.detach_car(car_id)
              @@cars_free << car_id     
              @@cars_free_ids << car_id.car_id          
            else
              puts "There is no such car currently attched to train #{train_num.number}."
            end
          else
            puts "You've provided wrong type of input. Please try again."
          end
        end
    else 
      puts "You've provided wrong type of input. Please try again."
    end

    when "routes"
      puts "You are now in the managing routes program section."
      puts "Here you can add new routes and add station to this route or delete them."
      puts
      puts "Please type in 'add' to add new route, 'add station' to add station to this route,"
      puts "or 'delete station' to delete station from this route."
      routes_input = gets.chomp.downcase
      case routes_input

      when "add"
        good_route = false
        good_station1 = false
        good_station2 = false
        print "Currently there are several routes: "; puts routes_names; puts
        print "Currently there are several stations: "; puts stations_names; puts    
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
          @@routes << route
          @@routes_names << route.name
          puts "New route #{route.name} has been created."
        else
          puts "Unfortunately route has not been created."
        end
        print "Currently there are several routes: "; puts routes_names; puts
      when "add station"
        print "Currently there are several routes: "; puts routes_names; puts
        puts "Please type in route name you want to add station to."
        route_name = gets.chomp
        routes.each {|route| route_name = route if route.name == route_name}
        print "Currently there are several stations: "; puts station_names; puts
        puts "Please type in station name you want to add to this route."
        station_name = gets.chomp
        stations.each {|station| station_name = station if station.name == station_name}
        route_name.add_station(station_name)
        puts "Station #{station_name.name} was successfully added to #{route_name.name}."
      when "delete station"
        print "Currently there are several routes: "; puts routes_names; puts
        puts "Please type in route name you want to delete station from."
        route_name = gets.chomp
        routes.each {|route| route_name = route if route.name == route_name}
        print "Currently there are several station on route #{route_name.name}: "; puts route_name.station_names; puts 
        puts "Please type in station name you want to delete."
        station_name = gets.chomp
        route_name.stations.each {|station| station_name = station if station.name == station_name}
        puts "Unfortunately, you are unable to delete first or last station attached to route." if route_name.stations.length < 3
        route_name.delete_station(station_name)
        print "Currently there are several station on route #{route_name.name}: "; puts route_name.station_names; puts
    else
      puts "You've provided wrong type of input. Please try again."
    end


    when "stations"
      puts "Your are now in the managing stations program section."
      puts "Here you can add new stations or observe trains which are currently arrived on this station."
      puts "Please type in 'add' to add new station 'observe' to observe trains on station or 'list' to view list of existing stations."
      stations_input = gets.chomp.downcase
      case stations_input
      when "add"
        print "Currently there are several stations: "; puts stations_names; puts    
        puts "Please type in name for your new station"
        station_name = gets.chomp
        station = Station.new(station_name)
        @@stations << station
        @@stations_names << station.name
        print "Currently there are several stations: "; puts stations_names; puts    
      when "observe"
        print "Currently there are several stations: "; puts stations_names; puts
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

      when "list"
        print "Currently there are several stations: "; puts stations_names; puts
    else
      puts "You've provided wrong type of input. Please try again."
    end

  when "cars"
    puts "Here you can manage your cars by addding new cars or deleting cars."
    puts "Please type in 'add' to add cars or 'remove' to remove cars:"
    car_input = gets.chomp
    case car_input
    when "add"
      print "Currently there are several cars: "; puts cars_ids_all; puts
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
      @@cars << car
      @@cars_free << car
      @@cars_ids_all << car.car_id
      @@cars_free_ids << car.car_id
      puts "#{car.class.to_s.capitalize} car #{car.object_id} was succesfully added."
    when "remove"
      print "Currently there are several cars: "; puts cars_ids_all; puts
      puts "Please type in car id of car you want to delete:"
      car_input = gets.chomp.to_i
      @@cars.each do |car| 
        if car.car_id == car_input
          @@cars.delete(car) 
          @@cars_free.delete(car)
          @@cars_ids_all.delete(car.id)
          @@cars_free_ids.delete(car.id)
        end
      end
    else
      puts "You've provided wrong type of input. Please try again."
    end

    else
    puts "You've provided wrong type of input. Please try again."
    end

  end


  #As far as I understand classes below shouldn't be accessible outside of Application class
  #because user shouldn't be able to directly interact with class variables without interacting with UI first.
  private

  def self.routes
    @@routes
  end

  def self.routes_names
    @@routes_names
  end

  def self.stations
    @@stations
  end

  def self.stations_names
    @@stations_names
  end

  def self.trains
    @@trains
  end

  def self.trains_numbers
    @@trains_numbers
  end

  def self.cars
    @@cars
  end

  def self.cars_ids_all
    @@cars_ids_all
  end

  def self.cars_ids       
    @@cars_ids
  end

  def self.cars_free
    @@cars_free
  end

  def self.cars_free_ids
    @@cars_free_ids
  end

end