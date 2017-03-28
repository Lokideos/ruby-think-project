module Validable

  def valid?(check_type, train_cargo_type="default", train_number="default", first_station_name="default", 
                last_staiton_name="default", station_name="default", car_managed_id = "default") 
      valid = false
      check_type
      case check_type
      when :trains
        begin
        raise "Unacceptable train number!" unless /^[\d\w]{3}-*[\d\w]{2}$/.match(train_number)
        raise "Unacceptable train type!" unless train_cargo_type == "passenger" || train_cargo_type == "cargo"
          valid = true 
        rescue RuntimeError => e     
          puts e.inspect        
        end
      when :routes
        begin
        # raise "Unexisting first station" unless stations.find{|station|station.name == first_station_name}
        # raise "Unexisting second station" unless stations.find{|station| station.name == last_staiton_name}
        raise "First station are equal to last station" if first_station_name == last_staiton_name
          valid = true 
        rescue RuntimeError => e
          puts e.inspect
        end
      when :stations
        begin
        raise "Station already exists" if self.class.all.find{|station| station.name == station_name}
        raise "Unacceptable station name" if station_name.length == 0
          valid = true 
        rescue RuntimeError => e
          puts e.inspect
        end
      when :car_add
        begin
        raise "Unexisting car type" unless train_cargo_type == "cargo" || train_cargo_type == "passenger"
          valid = true 
        rescue RuntimeError => e
          puts e.inspect
        end
      when :car_remove
        begin  
        raise "Unexisting car" unless cars.find{|car| car.car_id == car_managed_id}
          valid = true 
        rescue RuntimeError => e
          puts e.inspect
        end
      else
        begin
        raise "Unexisting data class. How did you end up here btw?"
          valid = true 
        rescue RuntimeError => e
          puts e.inspect
        end
      end
      valid
    end
end