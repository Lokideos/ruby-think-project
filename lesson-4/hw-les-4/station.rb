class Station
  attr_reader :name 
  @@stations = [] 

  def initialize (name)
    @name = name
    @trains = []
    @@stations << self
  end

  def train_arrival(train)
    @trains << train    
  end

  def show_trains
    @trains
  end

  def trains_by_type (train_type)    
    @trains.select {|train| train.type == train_type}    
  end

  def train_departure(train)
    @trains.delete (train) {"There is no such train."}
  end

  def self.show_stations
    @@stations
  end

end