class Car  
  attr_reader :current_rpm
  
  def initialize
    @current_rpm = 0
  end

  def start_engine    
    start_engine! if engine_stopped?
  end

  def engine_stopped?    
    current_rpm.zero?
  end

  protected  

  attr_writer :current_rpm

  def initial_rpm
    700
  end

  def start_engine!    
    self.current_rpm = initial_rpm
  end
  # stop engine
end

class X
  def start_engine
    puts "HELLO!"
  end
end

class Driver
  def drive(car)
    #enter the car
    #start the engine
    car.start_engine
    #departure
  end
end