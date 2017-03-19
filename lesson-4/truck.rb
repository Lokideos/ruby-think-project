
class Truck < Car
  def loading
  end

  def wrong_method
    start_engine!
  end

  protected
  
  def initial_rpm
    500
  end
end