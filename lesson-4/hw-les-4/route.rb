class Route
  attr_reader :stations, :station_names, :name
  

  def initialize (first_station, last_station)    
    @stations = [first_station, last_station] if first_station != last_station  #should be instances of Station class
    @station_names = [first_station.name, last_station.name]
    @name = "route#{object_id}"   
  end

  def add_station(station)    
    @stations.insert(-2, station)
    @station_names.insert(-2, station.name)
  end

  def delete_station (station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)
    @station_names.delete(station.name) unless [@stations.first, @stations.last].include?(station)
  end

end