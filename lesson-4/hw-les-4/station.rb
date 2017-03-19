class Station
  attr_reader :name  

  def initialize (name)
    @name = name
    @trains = []
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
end