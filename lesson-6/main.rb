# begin
#   puts 'Before exception'
#   Math.sqrt(-1)
#   puts 'After exception'
# rescue StandardError => e
#   puts "Error!"
#   raise
# rescue NoMemoryError => e
#   puts "No memory!!!"
# end

# puts "After exception"
# --------------------------------
# def method_with_error
#   #......
#   raise Exception, "Oh no!"
# end

# begin 
#   method_with_error
# rescue RuntimeError => e
#   puts e.inspect
# end

# puts "After exception!"
# --------------------------------
# --------------------------------
# def sqrt(value)
#   sqrt = Math.sqrt(value)
#   puts sqrt
# rescue StandardError
#   puts "Wrong value!"
# end

# sqrt(-1)
# --------------------------------

def connect_to_wikipedia
  #......
  raise "Connection error"
end

attempt = 0
begin 
  connect_to_wikipedia  
rescue NoMemoryError
  attempt += 1
  #puts "Check your internet connection!"
  retry if attempt < 3  
ensure
  puts "There was #{attempt} attempts"
end