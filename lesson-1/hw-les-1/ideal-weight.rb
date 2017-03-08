=begin
Lokideos, Thinknetica RoR courses, lesson-1, task-1
Program "Ideal weight"
Program takes user input which should be his/her height and name and calculate
ideal weight using "<input_hiehgt> - 110" formula.
After that user will recieve answer containing information about his ideal weight
or, if the result < 0, user will recieve the following output: 
"Your weight is already in optimal condition."
=end

program_exit = false

while !program_exit


	#Initialize
	puts "Greetings! This programm will calculate your ideal weight!"
	print "First please type in your name: "
	user_name = gets.chomp
	print "Now please type in your height: "
	user_height = gets.chomp.to_i
	ideal_weight = user_height - 110

	#Calculate ideal weight and print out the result
	if ideal_weight > 0
		puts "According to our research your ideal weight is equal to #{ideal_weight}"
	else
		puts "Congratulations! Your weight is already optimal!"
	end
	
	#Check for exit program condition
	puts
	puts "If you want to exit the program please type in 'Exit'."
	puts "Otherwise type in whatever you want to."
	exit_check = gets.chomp.capitalize!
	program_exit = true	if exit_check == "Exit"
end