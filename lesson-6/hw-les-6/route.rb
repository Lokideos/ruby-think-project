class Route  
  attr_reader :stations, :station_names, :name  

  def initialize (first_station, last_station)   
    @stations = [first_station, last_station]
    validate!
    @name = "route#{object_id}"   
  end

  def add_station(station)    
    @stations.insert(-2, station)    
  end

  def delete_station (station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)    
  end

  def stations_names
    station_names = []
    @stations.each {|station| station_names << station.name}
    station_names  
  end

  def valid? (first_station="default", last_station="default")
    valid = true  
    valid = false unless Station.all.find{|station| station == self.stations.first}
    valid = false unless Station.all.find{|station| station == self.stations.last}
    valid = false if self.stations.first.name == self.stations.last.name
    valid
  end

  private

  def validate!  
  raise "Unexisting first station" unless Station.all.find{|station| station == self.stations.first}
  raise "Unexisting second station" unless Station.all.find{|station| station == self.stations.last}
  raise "First station are equal to last station" if self.stations.first.name == self.stations.last.name
  end

end