class PassengerCar < Car
  attr_reader :seats, :free_seats

  def initialize(seats = 30)
    self.seats = seats
    self.free_seats = seats
    super
  end

  def take_seat
    self.free_seats -= 1 unless free_seats.zero?
  end

  def liberate_place # :D
    self.free_seats += 1 unless self.free_seats == seats
  end

  def occupied_seats
    seats - self.free_seats
  end

  private

  attr_writer :seats, :free_seats

  def validate!
    super
    raise 'Unaccepteble seats quantity' if seats.to_i < 1
  end
end
