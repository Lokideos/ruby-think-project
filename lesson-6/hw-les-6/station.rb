class Station
  include InstanceCounter  
  include Validable

  attr_reader :name
  @@instances = []

  def initialize (name)
  raise unless valid?(:stations, "d", "d", "d", "d", name)
    @name = name
    @trains = []   
    @@instances << self
    register_instance
  end

  def train_arrival(train)
    @trains << train    
  end

  def trains
    @trains
  end

  def trains_by_type (train_type)    
    @trains.select {|train| train.class.to_s == train_type}    
  end

  def train_departure(train)
    @trains.delete (train) {"There is no such train."}
  end

  def self.all
    @@instances
  end

end