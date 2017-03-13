=begin
Lokideos, Thinknetica RoR courses, lesson-2, task-1
Program "Days in months"
This program will print all months which contain exactly 30 days.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize
  puts "Greetins! This program will print months which contain exactly 30 days."
  output = ""

  #February always contains less then 30 days 
  #so we will set its value equal to 28 for this task
  months = {january: 31, february: 28, march: 31, 
            april: 30, may: 31, june: 30,
            july: 31, august: 31, september: 30, 
            october: 31, november: 30, december: 31}

  #Print needed months
  output = []
  months.each {|month, days| output << month if days == 30}
  puts "There are 30 days in the following months: #{output.join(', ')}."

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end