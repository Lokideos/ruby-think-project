class Route
  attr_reader :stations, :station_names, :name

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

  def valid?(_first_station = 'default', _last_station = 'default')
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  ERRORS =
    { unexistance_first: 'Unexisting first station',
      unexistance_second: 'Unexisting second station',
      equality: 'First station are equal to last station' }.freeze

  # I believe that I should keep ABC of validate! method in its current state
  # because of method's nature
  def validate!
    unless Station.all.find { |station| station == stations.first }
      raise ERRORS[:unexistance_first]
    end
    unless Station.all.find { |station| station == stations.last }
      raise ERRORS[:unexistance_second]
    end
    raise ERRORS[:equality] if stations.first.name == stations.last.name
  end
end
