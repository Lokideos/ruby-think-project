class Station
  include InstanceCounter    

  attr_reader :name
  @@instances = []

  def initialize (name)
  raise unless valid?(name)
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

  private

  def valid?(station_name)  
  raise "Station already exists" if Station.all.find{|station| station.name == station_name}
  raise "Unacceptable station name" if station_name.length == 0
    true
  end

end