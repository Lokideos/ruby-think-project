=begin
Lokideos, Thinknetica RoR courses, lesson-1, task-1
Program "Ideal weight"
Program takes user input which should be his/her height and name and calculate
ideal weight using "<input_hiehgt> - 110" formula.
After that user will recieve answer containing information about his ideal weight
or, if the result < 0, user will recieve the following output: 
"Your weight is already in optimal condition."
=end

flag_program_exit = false

while flag_program_exit == false

	#Initialize
	puts "Greetings! This programm will calculate your ideal weight!"
	print "First please type in your name: "
	user_name = gets.chomp
	print "Now please type in your height: "
	user_height = Integer(gets.chomp)

	#Calculate ideal weight and print out the result
	if (user_height - 110) > 0
		puts "According to our research your ideal weight is equal to #{user_height - 110}"
	else
		puts "Congratulations! Your weight is already optimal!"
	end
	
	#Check for exit program condition
	puts
	puts "If you want to exit the program please type in 'Exit'."
	puts "Otherwise type in whatever you want to."
	exit_check = gets.chomp.capitalize!
	flag_program_exit = true if exit_check == "Exit"
end