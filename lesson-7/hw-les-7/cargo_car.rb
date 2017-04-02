class CargoCar < Car

  attr_reader :volume, :free_volume

  def initialize(volume=100.0)    
    self.volume = volume
    self.free_volume = volume    
    super
  end

  def occupy_volume(volume)
    self.free_volume -= volume unless self.free_volume - volume < volume    
  end

  def free_up_volume(volume)
    self.free_volume += volume unless self.free_volume + volume > self.volume    
  end

  def occupied_volume
    self.volume - self.free_volume
  end

  private

  attr_writer :volume, :free_volume

  def validate!
    super
    raise "Unaccepteble volume" if self.volume.to_f < 1
  end
end