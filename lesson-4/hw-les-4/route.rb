class Route
  @@routes = [] #For testing purposes
  @@route_name_counter = 0 #For testing purposes
  attr_reader :stations, :name
  

  def initialize (first_station, last_station)    
    @stations = [first_station, last_station] if first_station != last_station  #should be instances of Station class
    @@route_name_counter +=1 #For testing purposes
    @name = "route #{@@route_name_counter}"
    @@routes << @name #For testing purposes
  end

  def add_station(station)    
    @stations.insert(-2, station)
  end

  def delete_station (station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)
  end

  #For testing purposes
  def self.show_routes
    @@routes
  end
end