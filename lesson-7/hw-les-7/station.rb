class Station
  include InstanceCounter    

  attr_reader :name
  @@instances = []

  def initialize (name)    
    @name = name
    validate!
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

  def valid?
    validate!
    true
    rescue RuntimeError
      false
  end

  private

  def validate!
    raise "Station already exists" if Station.all.find{|station| station.name == self.name}
    raise "Unacceptable station name" if self.name.length == 0
  end

end