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
  month = gets.chomp.to_i - 1
  print "Please type in current day: "
  days = gets.chomp.to_i  
  months = {january: {1=>31}, february: {2=>28}, march: {3=>31}, 
            april: {4=>30}, may: {5=>31}, june: {6=>30},
            july: {7=>31}, august: {8=>31}, september: {9=>30}, 
            october: {10=>31}, november: {11=>30}, december: {12=>31}}

  #Detection of leap year
  months[:february][2] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  
  #Calculating sum of days from the beginning of the year
  months.each do |month_name, property|
    property.each do |month_count, day_count|
      if month_count <= month
        days += day_count
      end
    end
  end

  puts "According to your data there are #{days} days between the beginning of the year"
  puts "and current date."

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
