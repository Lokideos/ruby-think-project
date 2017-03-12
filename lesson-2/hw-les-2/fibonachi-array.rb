=begin
Lokideos, Thinknetica RoR courses, lesson-2, task-3
Program "Fibonachi numbers' array"
This program will fill an array with fibonachi numbers < 100.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize
  puts "Greetings! This program will create an array containing Fibonachi numbers less then 100."
  fibonachi = [1,1]  

  #Filling array with fibonachi numbers and deleting last element
  loop do 
    fibonachi.push(fibonachi[-2] + fibonachi[-1])
    break if fibonachi[-1] > 100
  end 
  fibonachi.delete_at(-1)

  print "As the result we received following sequence: "
  print fibonachi

  #Check for exit program condition
  puts
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
