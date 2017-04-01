class Station
  include InstanceCounter    

  attr_reader :name, :trains
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

  #Basically block can do anything with given attributes so I've decided to name this block 'trains handler' because
  #we don't know what it'll do with trains - we only certain about input attributes, all of which in this case are trains.
  def trains_on_station_handler(&trains_handler)
    self.trains.each {|train| trains_handler.call(train)}    
  end

  private

  def validate!
    raise "Station already exists" if Station.all.find{|station| station.name == self.name}
    raise "Unacceptable station name" if self.name.length == 0
  end

end