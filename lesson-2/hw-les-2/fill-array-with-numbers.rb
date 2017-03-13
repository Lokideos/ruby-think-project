=begin
Lokideos, Thinknetica RoR courses, lesson-2, task-2
Program "Fill array with numbers"
This program will fill an array with numbers >= 100 & <= 10 with increment equal to 5.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize
  puts "Greetings! This program will create an array and fill it with numbers greater or equal"
  puts "then 10 and less or equal then 100 with increment equal to 5."

  numbers = []
  number = 10
  #Filling an array with numbers
  until number > 100
    numbers << number
    number += 5
  end

  print "As the result we recieved following number sequence: "
  print numbers

  #Check for exit program condition
  puts
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
