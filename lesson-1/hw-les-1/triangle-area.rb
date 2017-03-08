=begin
Lokideos, Thinknetica RoR courses, lesson-1, task-2
Program "Area of triangle"
This program will calculate area of triangle using "S = 1/(2*a*h)" formula,
where 'a' is equal to length of 1 side of the triangle and
'h' is equal to triangle height, drawn from the opposite angle to this side.
Thus user input should contain length of triangle's side and height
and program output will containg the area of triangle
=end

program_exit = false

while !program_exit

	#Initialize
	puts "Greetings! This program will calculate the area of triangle."
	print "Please type in length of one of the triangle's sides: "
	side = gets.chomp.to_f
	print "Please type in legth of triangle's height, drawn form the opposite angle"
	print "to side you've already typed in: "
	height = gets.chomp.to_f

	#Calculate the area of triangle
	puts "The area of this triangle is equal to #{side*height*0.5}";

	#Check for exit program condition
	puts
	puts "If you want to exit the program please type in 'Exit'."
	puts "Otherwise type in whatever you want to."
	exit_check = gets.chomp.capitalize!
	program_exit = true if exit_check == "Exit"
end