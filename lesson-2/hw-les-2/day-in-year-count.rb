=begin
Lokideos, Thinknetica RoR courses, lesson-2, task-5
Program "Day's number from beginning of the year"
This program will calculate number of the current day in the year
according to the user's input which is current date, current month
and current year in integer data type.
Leap year factor should be taken into account.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize  
  puts "Greetins! This program will calculate the day number from beginning of the year."
  print "Please type in current year: "
  year = gets.chomp.to_i
  print "Please type in current month: "
  month = gets.chomp.to_i
  print "Please type in current day: "
  days = gets.chomp.to_i  
  
  months = [31,28,31,30,31,30,31,31,30,31,30,31]

  #Detection of leap year
  months[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  
  #Calculating sum of days from the beginning of the year
  for month_count in 0...month-1
    days += months[month_count]
  end  

  puts "According to your data there are #{days} days between the beginning of the year"
  puts "and current date."

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
