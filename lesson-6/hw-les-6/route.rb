class Route  
  attr_reader :stations, :station_names, :name  

  def initialize (first_station, last_station) 
  raise unless valid?(first_station, last_station)   
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

  private

  def valid? (first_station="default", last_station="default")
  raise "Nil object instead of station." if first_station == nil || last_station == nil
  raise "Unexisting first station" unless Station.all.find{|station|station.name == first_station.name}
  raise "Unexisting second station" unless Station.all.find{|station| station.name == last_station.name}
  raise "First station are equal to last station" if first_station.name == last_station.name
    true
  end

end