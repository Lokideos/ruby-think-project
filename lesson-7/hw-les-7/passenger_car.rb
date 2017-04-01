class PassengerCar < Car

  attr_reader :seats, :current_seats

  def initialize(seats=30)    
    self.seats = seats    
    self.current_seats = seats
    super
  end

  def take_seat  
    @current_seats -= 1 unless @current_seats == 0
  end

  def liberate_place # :D
    @current_seats += 1 unless @surrent_seats == @seats
  end

  private

  attr_writer :seats, :current_seats

  def validate!
    super
    raise "Unaccepteble seats quantity" if self.seats.to_i < 1
  end

end