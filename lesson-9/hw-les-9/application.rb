class Application
  # RUN_CHOICES =
  #   { :trains =  }

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
    exit_program = 'start'
    until exit_program == 'exit'
      @ui.run_msg
      main_menu
      @ui.run_exit_msg
      exit_program = gets.chomp.downcase
    end
  end

  private

  # As far as I understand methods below shouldn't be accessible
  # outside of Application class
  # because user shouldn't be able to directly interact with those
  # variables without interacting with UI first.
  attr_accessor :routes, :stations, :trains, :cars, :cars_free, :ui, :attempt

  # Methods below should be accessible only through UI.

  def main_menu
    @ui.input_1_change
    @ui.user_input1.downcase
    unless %w[trains routes stations cars].include? @ui.user_input1
      puts 'There is no such option in the main menu.'
    end
    main_menu_choose_option(@ui.user_input1)
  end

  # Don't know how to make this method shorter
  def main_menu_choose_option(user_input)
    case user_input
    when 'trains'
      manage_trains
    when 'routes'
      manage_routes
    when 'stations'
      manage_stations
    when 'cars'
      manage_cars
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains
    @ui.manage_trains_selected_msg
    @ui.input_1_change
    @ui.user_input1.downcase
    manage_trains_choose_option(@ui.user_input1)
  end

  # Don't know how to make this method shorter
  def manage_trains_choose_option(user_input)
    case user_input
    when 'add'
      manage_trains_add_train
    when 'add route'
      manage_trains_add_route
    when 'move'
      manage_trains_move
    when 'cars'
      manage_trains_cars
    when 'observe'
      manage_trains_choose_train
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_choose_train
    @ui.manage_trains_choose_train_msg(trains)
    train_number = gets.chomp
    train = trains.find { |train_elem| train_elem.number == train_number }
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
      print 'car type is Cargo; '
      print "occupied space: #{car.occupied_volume}; "
      puts "free space: #{car.free_volume}."
    end
  end

  def manage_trains_observe_passenger_train(train)
    puts "To train number #{train.number} currently attached following cars:"
    train.each_car do |car|
      print "Car number: #{car.car_id}; "
      print 'car type is Passenger; '
      print "taken seats: #{car.occupied_seats}; "
      puts "free seats: #{car.free_seats}"
    end
  end

  # Rescue problem again
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
    if @trains.find { |train_in_trains| train_in_trains.number == train_number }
      @ui.create_train_failed_msg
    else
      create_train_creating(train_type, train_number)
    end
  end

  def create_train_creating(train_type, train_number)
    train = case train_type
            when 'passenger'
              PassengerTrain.new(train_number)
            when 'cargo'
              CargoTrain.new(train_number)
            else
              Train.new(train_number)
            end
    @trains << train
    @ui.manage_trains_add_train_add_success_msg(train)
  end

  def manage_trains_add_route
    @ui.manage_trains_add_route_msg(trains, routes)
    train_number = gets.chomp
    route_name = gets.chomp
    change_route(train_number, route_name)
  end

  def change_route(train_num, route_name)
    train = trains.find { |train_elem| train_elem.number == train_num }
    route = routes.find { |route_elem| route_elem.name == route_name }

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
    train = trains.find do |train_elem|
      train_elem.number == train_num && train_elem.route
    end
    if train
      train_move_on_route_movint(train)
    else
      @ui.train_move_on_route_bad_msg
    end
  end

  def train_move_on_route_movint(train)
    @ui.train_move_on_route_direction_msg
    direction = gets.chomp
    train.move_forward if direction == 'forward'
    train.move_backward if direction == 'back'
  end

  def manage_trains_cars
    @ui.manage_trains_cars_msg(trains)
    train_to_manage_number = gets.chomp
    add_correct_car(train_to_manage_number)
  end

  def add_correct_car(train_num)
    train = trains.find { |train_elem| train_elem.number == train_num }
    return false unless train
    @ui.add_correct_car_action_msg
    action = gets.chomp
    add_correct_car_option(action, train)
  end

  def add_correct_car_option(action, train)
    case action
    when 'add'
      manage_trains_cars_add(train)
    when 'detach'
      manage_trains_cars_detach(train)
    when 'occupy'
      manage_trains_cars_choose_car(train)
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_cars_add(train)
    @ui.manage_trains_cars_add_msg(cars_free)
    car_to_add_id = gets.chomp
    manage_trains_cars_add_check(train, car_to_add_id)
  end

  def manage_trains_cars_add_check(train, car_to_add_id)
    chosen_car = cars_free.find { |car| car.car_id == car_to_add_id }
    if chosen_car
      if train.send :correct_car?, chosen_car
        manage_trains_cars_add_adding(train, chosen_car)
      else
        @ui.manage_trains_cars_add_existance_car_error_msg(train)
      end
    else
      @ui.manage_trains_cars_add_error_msg
    end
  end

  def manage_trains_cars_add_adding(train, chosen_car)
    train.add_car(chosen_car)
    @cars_free.delete(chosen_car)
    @ui.manage_trains_cars_add_success_msg(train, chosen_car)
  end

  def manage_trains_cars_detach(train)
    @ui.cars_attached_to_train_msg(train)
    car_to_detach_id = gets.chomp
    chosen_car = train.cars.find { |car| car.car_id == car_to_detach_id }
    if chosen_car
      manage_trains_cars_detach_detaching(train, chosen_car)
    else
      @ui.manage_trains_cars_add_error_msg
    end
  end

  def manage_trains_cars_detach_detaching(train, chosen_car)
    train.detach_car(chosen_car)
    @ui.manage_trains_cars_detach_success_msg(train, chosen_car)
    @cars_free << chosen_car if train.send :correct_car?, chosen_car
  end

  def manage_trains_cars_choose_car(train)
    @ui.manage_trains_cars_choose_car_msg(train)
    car_to_occupy_id = gets.chomp
    chosen_car = train.cars.find { |car| car.car_id == car_to_occupy_id }
    if chosen_car
      manage_trains_cars_occupy(chosen_car)
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_cars_occupy(car)
    if car.is_a? CargoCar
      manage_trains_cars_occupy_cargo(car)
    elsif car.is_a? PassengerCar
      manage_trains_cars_occupy_passenger(car)
    else
      @ui.wrong_input_msg
    end
  end

  def manage_trains_cars_occupy_cargo(car)
    @ui.manage_trains_occupy_set_volume_msg
    volume = gets.chomp.to_f
    car.occupy_volume(volume)
    @ui.manage_trains_occupy_success_cargo_msg(car)
  end

  def manage_trains_cars_occupy_passenger(car)
    car.take_seat
    @ui.manage_trains_occupy_success_passenger_msg(car)
  end

  def manage_routes
    @ui.manage_routes_msg
    routes_input = gets.chomp.downcase
    manage_routes_choose_option(routes_input)
  end

  def manage_routes_choose_option(routes_input)
    case routes_input
    when 'add'
      manage_routes_add_route
    when 'add station'
      manage_routes_add_station
    when 'delete station'
      manage_routes_delete_station
    else
      @ui.wrong_input_msg
    end
  end

  # Again problem with rescue
  def manage_routes_add_route
    @ui.manage_routes_add_route_msg(routes, stations)
    station_one_name = gets.chomp
    station_two_name = gets.chomp
    manage_routes_add_route_adding(station_one_name, station_two_name)
  rescue RuntimeError => e
    puts e.inspect
    @attempt += 1
    if @attempt < 3
      puts @ui.wrong_input_msg
      retry
    end
    @attempt = 0
  end

  def manage_routes_add_route_adding(station_one_name, station_two_name)
    station_one = stations.find { |station| station.name == station_one_name }
    station_two = stations.find { |station| station.name == station_two_name }
    route = Route.new(station_one, station_two)
    @routes << route
    @ui.manage_routes_add_route_success_msg(route)
  end

  # Again problem with rescue part
  def manage_routes_add_station
    @ui.manage_routes_add_station_msg(routes, stations)
    route_name = gets.chomp
    station_name = gets.chomp
    validate_route_for_add_station!
    manage_routes_add_stations_adding(station_name, route_name)
  rescue RuntimeError => e
    puts e.inspect
    @attempt += 1
    if @attempt < 3
      puts @ui.wrong_input_msg
      retry
    end
    @attempt = 0
  end

  def validate_route_for_add_station!
    unless routes.find { |route| route.name == route_name }
      raise 'Unexisting route'
    end
    return true unless stations.find { |station| station.name == station_name }
    raise 'Unexisting station'
  end

  def manage_routes_add_stations_adding(station_name, route_name)
    station_add = stations.find { |station| station.name == station_name }
    route_add = routes.find { |route| route.name == route_name }
    route_add.add_station(station_add)
    @ui.manage_routes_add_station_success_msg(station_add, route_add)
  end

  # I should get rid of rescue part to fix method length
  def manage_routes_delete_station
    @ui.manage_routes_delete_station_msg(routes, stations)
    route_name = gets.chomp
    route = routes.find { |route_elem| route_elem.name == route_name }
    validate_route_for_delete!
    @ui.manage_routes_delete_station_input_station_msg(route)
    station_name = gets.chomp
    validate_route_deletion!
    manage_routes_delete_station_delete(route_name, station_name)
  rescue RuntimeError => e
    puts e.inspect
    @attempt += 1
    if @attempt < 3
      @ui.wrong_input_msg
      retry
    end
    @attempt = 0
  end

  def validate_route_for_delete!
    unless routes.find { |route| route.name == route_name }
      raise 'Unexisting route'
    end
    raise 'Too short route' if route.stations.length < 2
  end

  # ABC metric is OK due to method's nature
  def validate_route_deletion!
    unless route.stations.find { |station| station.name == station_name }
      raise 'Unexisting station'
    end
    if station_name == route.stations.first
      raise 'First station can not be deleted'
    end
    return false unless station_name == route.stations.last
    raise 'Last station can not be deleted'
  end

  def manage_routes_delete_station_delete(_route_name, _stations_name)
    station_del = stations.find { |station| station.name == station_name }
    route.delete_station(station_del)
    @ui.manage_routes_delete_station_success_msg(station_del, route)
  end

  def manage_stations
    @ui.manage_stations_msg
    stations_input = gets.chomp.downcase
    manage_stations_choose_option(stations_input)
  end

  # How to get rid of case statment in this case?
  def manage_stations_choose_option(stations_input)
    case stations_input
    when 'add'
      manage_stations_add_station
    when 'observe'
      manage_stations_observe_station
    when 'list'
      manage_stations_list_stations
    when 'trains'
      manage_stations_choose_station
    else
      @ui.wrong_input_msg
    end
  end

  def manage_stations_choose_station
    @ui.manage_stations_choose_station_msg(stations)
    station_name = gets.chomp
    station_look = stations.find { |station| station.name == station_name }
    if station_look
      manage_stations_observe_trains(station_look)
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

  # don't know how to get rid of rescue method part
  def manage_stations_add_station
    @ui.manage_stations_add_station_msg(stations)
    manage_stations_add_station_adding
  rescue RuntimeError => e
    puts e.inspect
    @attempt += 1
    if @attempt < 3
      puts @ui.wrong_input_msg
      retry
    end
    @attempt = 0
  end

  def manage_stations_add_station_adding
    @ui.manage_stations_add_station_input_msg
    station_name = gets.chomp
    station = Station.new(station_name)
    @stations << station
    @ui.manage_stations_add_station_success_msg(station)
  end

  def manage_stations_observe_station
    @ui.manage_stations_observe_station_msg(stations)
    station_name = gets.chomp
    station_look = stations.find { |station| station.name == station_name }
    @ui.manage_stations_observe_station_observe_msg(station_look) if station
  end

  def manage_stations_list_stations
    print 'Currently there are several stations: '
    puts @ui.print_names(stations)
  end

  def manage_cars
    @ui.manage_cars_msg
    car_input = gets.chomp

    case car_input
    when 'add'
      manage_cars_add_car
    when 'remove'
      manage_cars_remove_car
    else
      @ui.wrong_input_msg
    end
  end

  # don't know how to get rid of rescue method part
  def manage_cars_add_car
    @ui.manage_cars_add_car_msg(cars)
    car_type = gets.chomp
    case car_type
    when 'cargo'
      manage_cars_add_cargo_car
    when 'passenger'
      manage_cars_add_passenger_car
    else
      Car.new('false')
    end
  rescue RuntimeError => e
    puts e.inspect
    @attempt += 1
    if @attempt < 3
      @ui.wrong_input_msg
      retry
    end
    @attempt = 0
  end

  def manage_cars_add_cargo_car
    @ui.manage_cars_add_car_input_volume_msg
    volume = gets.chomp.to_f
    car = CargoCar.new(volume)
    manage_cars_add_car_success(car)
  end

  def manage_cars_add_passenger_car
    @ui.manage_cars_add_car_input_seats_msg
    seats = gets.chomp.to_i
    car = PassengerCar.new(seats)
    manage_cars_add_car_success(car)
  end

  def manage_cars_add_car_success(car)
    @cars << car
    @cars_free << car
    @ui.manage_cars_add_car_success_msg(car)
  end

  def manage_cars_remove_car
    @ui.manage_cars_remove_car_msg(cars)
    manage_cars_remove_car_check
  rescue RuntimeError
    puts e.inspect
    @attempt += 1
    if @attempt < 3
      @ui.wrong_input_msg
      retry
    end
    @attempt = 0
  end

  # I still think that ABC is fine in method below
  def manage_cars_remove_car_check
    @ui.manage_cars_remove_car_input_msg
    car_to_del_id = gets.chomp
    raise 'Unexisting car' unless cars.find { |car| car.id == car_to_del_id }
    car_del = cars.find { |car| car.car_id == car_to_del_id }
    @cars.delete(car_del)
    @cars_free.delete(car_del)
    @ui.manage_cars_remove_car_success_msg
  end
end
