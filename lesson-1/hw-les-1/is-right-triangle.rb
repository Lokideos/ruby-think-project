=begin
Lokideos, Thinknetica RoR courses, lesson-1, task-3
Program "Right triangle"
According to user input, which is length of triangle's 3 sides,
this program will detect whether this triangle is right or not using Pythagorean theorem.
In addition program will also detect whether this triangle is isosceles or not.
It was uncleaar whether we should check for equilateral condition or not,
so I didnd't do it.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize
  puts "Greetings! According to provided information this program"
  puts "will tell you whether triangle is right or not."
  puts "In addition if this triangle is right this programm"
  puts "will also calculate whether this triangle is isoscels or not."
  puts

  puts "First please type in length of trinagle's sides."
  print "Please type in length of triangle's first side in centimeters: "
  first_side = gets.chomp.to_f
  print "Please type in length of triangle's second side in centimeters: "
  second_side = gets.chomp.to_f
  print "Please type in length of triangle's third side in centimeters: "
  third_side = gets.chomp.to_f
  right_triangle = false
  isosceles_triangle = false
  equilateral_triangle = false
  
  #Check for the longest triangle's side
  if first_side > second_side && first_side > third_side
    hypotenuse = first_side
    cathetus1 = second_side
    cathetus2 = third_side
  elsif second_side > third_side
    hypotenuse = second_side
    cathetus1 = first_side
    cathetus2 = third_side
  else
    hypotenuse = third_side
    cathetus1 = first_side
    cathetus2 = second_side
  end
  
  #Check for right triangle's condition
  right_triangle = hypotenuse == Math.sqrt(cathetus1**2 + cathetus2**2)
  
  #Check for isosceles triange's condition    
  isosceles_triangle = cathetus1 == cathetus2 if right_triangle  
  
  #Check for equilateral triangle's condition
  equilateral_triangle = first_side == second_side && first_side == third_side
  
  #Print results acording to isosceles and right conditions
  if isosceles_triangle
    puts "According to provided information about triangle sides' length,"
    puts "your triangle is right and also isosceles."
  elsif right_triangle
    puts "According to provided information about triangle sides' length,"
    puts "your triangle is right."    
  elsif equilateral_triangle
    puts "According to provided information about triangle sides' length,"
    puts "your triangle is equilateral."
  else
    puts "According to provided information your triangle is"
    puts "definetly not right."
  end

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
