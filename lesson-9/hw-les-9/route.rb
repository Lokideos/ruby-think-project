class Route
  include Validation

  attr_reader :stations, :station_names, :name

  validate :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    @name = "route#{object_id}"
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return false if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def stations_names
    station_names = []
    @stations.each { |station| station_names << station.name }
    station_names
  end
end
