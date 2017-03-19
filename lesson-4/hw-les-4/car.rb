class Car
  @@id_counter = 1

  def initialize
    @id = @@id_counter
    @@id_counter += 1
  end
end