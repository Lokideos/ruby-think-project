class Route
  @@Routes = []


  def initialize (first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @route = [first_station, last_station]
    puts "Please type in route name:"
    @route_name = gets.chomp
    @@Routes << @route_name
  end

  def add_station(station_name)
    @route << @last_station
    @route[-2] = station_name
  end

  def delete_station (station_name)
    @route.each.with_index do |station, index| 
      station = station_name
      @route.delete_at(index) if @route[index] == station   
    end
  end

  def show_stations
    @route
  end
end