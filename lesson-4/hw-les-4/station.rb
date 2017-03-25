class Station

  include Manufacturable  
  attr_reader :name 
  @@stations_class = []

  def initialize (name)
    @name = name
    @trains = []   
    @@stations_class << self
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
    @@stations_class
  end

end