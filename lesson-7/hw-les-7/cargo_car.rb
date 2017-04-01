class CargoCar < Car

  attr_reader :volume, :current_volume

  def initialize(volume=100.0)    
    self.volume = volume
    self.current_volume = volume
    super
  end

  def occupy_volume
    @current_volume -= 1 unless @current_volume == 0
  end

  def free_up_volume
    @current_volume += 1 unless @current_volume == self.volume
  end

  private

  attr_writer :volume, :current_volume

  def validate!
    super
    raise "Unaccepteble volume" if self.volume.to_f < 1
  end
end