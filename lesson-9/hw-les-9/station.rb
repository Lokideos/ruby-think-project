class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  validate :name

  class << self
    attr_accessor :instances

    def all
      instances
    end

    def add_instance(station)
      instances << station
    end
  end

  Station.instances = []


  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.add_instance(self)
    register_instance
  end

  def train_arrival(train)
    @trains << train
  end

  attr_reader :trains

  def trains_by_type(train_type)
    @trains.select { |train| train.class.to_s == train_type }
  end

  def train_departure(train)
    @trains.delete(train) { 'There is no such train.' }
  end

  def each_train
    trains.each { |train| yield(train) }
  end
end
