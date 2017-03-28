class Route
  attr_reader :stations, :station_names, :name
  

  def initialize (first_station, last_station) 
  raise unless valid?(:routes, "d", "d", first_station, last_staiton)   
    @stations = [first_station, last_station] #should be instances of Station class    
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

end