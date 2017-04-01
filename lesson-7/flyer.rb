class Flyer
  attr_reader :name, :email, :miles_flown

  def initialize(name, email, miles_flown)
    @name = name
    @email= email
    @miles_flown = miles_flown
  end

  def to_s
    "#{name} (#{email}): #{miles_flown}"
  end
end

# flyers = []
# flyer1 = Flyer.new("Bob", "bob@gmail.com", 1000)
# flyers << flyer1
# flyer2 = Flyer.new("Ricky", "ricky@gmail.com", 2000)
# flyers << flyer2
# flyer3 = Flyer.new("Denis", "denis@gmail.com", 3000)
# flyers << flyer3
# flyer4 = Flyer.new("Nikole", "nikole@gmail.com", 4000)
# flyers << flyer4
# flyer5 = Flyer.new("Roman", "roman@gmail.com", 5000)
# flyers << flyer5

flyers = []

1.upto(5) do |num|
  flyers << Flyer.new("Flyer #{num}", "flyer#{num}@example.com", num*1000)
end
puts flyers