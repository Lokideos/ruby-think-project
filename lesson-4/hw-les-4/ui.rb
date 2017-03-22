class UI

  attr_reader :user_input1, :user_input2

  def initialize
    @user_input1 = ""
    @user_input2 = ""
  end

  def input_1_change
    @user_input1 = gets.chomp
  end

  def input_2_change
    @user_input2 = gets.chomp
  end

  def main_ad
    puts "Greetings! Welcome to the program, which will help you to maintain your railway stations!"
    puts "In this program you can manage your trains, your stations and your routes."
    puts "Now you will be tranfered to the Main Menu."
  end

  def run_ad
    puts "Please type in 'trains' for managing your trains, 'routes' for managing your routes, 'stations' to managing your stations or 'cars' to add or delete cars."
  end

  def run_exit_ad
    puts "Please type in 'exit' to exit the program."
  end


  def manage_trains_selected_ad
    puts "You are now in the managing trains program section."
    puts "Here you can add new trains, assign route to train, add cars to train, detach them from train."
    puts "Also here you can move your train on the route."
    puts
    puts "Please type in 'add' to add the train, 'add route' to assign route to the train;"
    puts "type in 'move' to move train on his route or 'cars' to add or detach car from train."
  end

  def manage_trains_add_selected_trains_show_ad
    print "Currently there are several trains: "    
  end

  def manage_trains_add_selected_type_train_question
    puts "Do you want to add passenger or cargo train?"
  end

  def manage_trains_add_selected_number_train_question
    puts "Please type in number for your train to add."
  end

  def manage_trains_add_train_add_success_ad(train)
    puts "You've added #{train.number} train."
  end

  def wrong_input_ad
    puts "You've provided wrong type of input. Please try again."
  end

  def print_names (objects)
    names = []
    objects.each {|object| names << object.name}
    names
  end

  def trains_numbers(trains)
    train_numbers = []
    trains.each {|train| train_numbers << train.number}
    train_numbers
  end

  def print_car_ids (cars)
    car_ids = []
    cars.each {|car| car_ids << car.car_id}
    car_ids
  end

  private

  attr_writer :user_input1, :user_input2

end