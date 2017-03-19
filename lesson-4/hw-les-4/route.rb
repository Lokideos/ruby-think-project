class Route
  @@routes = [] 
  @@route_name_counter = 0 
  attr_reader :stations, :name
  

  def initialize (first_station, last_station)    
    @stations = [first_station, last_station] if first_station != last_station  #should be instances of Station class
    @@route_name_counter +=1 
    @name = "route#{@@route_name_counter}"
    @@routes << self 
  end

  def add_station(station)    
    @stations.insert(-2, station)
  end

  def delete_station (station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)
  end

  def self.show_routes
    @@routes
  end
end