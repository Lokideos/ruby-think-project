class Train
  include Manufacturable
  include InstanceCounter

  attr_reader :number, :speed, :cars
  attr_accessor :route

  class << self
    attr_accessor :instances

    def find(train_number)
      instances[train_number.to_sym]
    end

    def add_instance(train)
      instances[train.number.to_sym] = train
    end
  end

  Train.instances = {}

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @cars = []
    Train.add_instance(self)
    @manufacture = 'Toshiba'
    register_instance
  end

  def speed_up(speed = 10)
    @speed += speed
  end

  def speed_down(speed = 10)
    @speed -= speed if @speed > 0
  end

  def speed_stop
    @speed = 0
  end

  def add_car(car)
    @cars << car if speed.zero? && correct_car?(car)
  end

  def detach_car(car)
    @cars.delete(car) if speed.zero?
  end

  # If car calss is unkonwn we can attach it to any type of train
  def correct_car?(_car)
    true
  end

  def change_route(route)
    @route = route
    @route_position = 0
  end

  def last_position?
    @route_position == @route.stations.length - 1
  end

  def first_position?
    @route_position.zero?
  end

  def move_forward
    return false unless next_station
    @route_position += 1
    current_station.train_arrival(self)
    previous_station.train_departure(self)
  end

  def move_backward
    return false unless previous_station
    @route_position -= 1
    current_station.train_arrival(self)
    next_station.train_departure(self)
  end

  def previous_station
    @route.stations[@route_position - 1] unless first_position?
  end

  def current_station
    @route.stations[@route_position]
  end

  def next_station
    @route.stations[@route_position + 1] unless last_position?
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def each_car
    cars.each { |car| yield(car) }
  end

  private

  ERRORS =
    { bad_number: 'Unacceptable train number!',
      bad_type: 'Unacceptable train type!' }.freeze

  def validate!
    raise ERRORS[:bad_number] unless /^[\d\w]{3}-*[\d\w]{2}$/ =~ number
    raise ERRORS[:bad_type] unless is_a?(PassengerTrain) || is_a?(CargoTrain)
  end
end
