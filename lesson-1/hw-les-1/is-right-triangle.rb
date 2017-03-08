=begin
Lokideos, Thinknetica RoR courses, lesson-1, task-3
Program "Right triangle"
According to user input, which is length of triangle's 3 sides,
this program will detect whether this triangle is right or not using Pythagorean theorem.
In addition program will also detect whether this triangle is isosceles or not.
=end

flag_program_exit = false

while flag_program_exit == false

	#Initialize
	puts "Greetings! According to provided information this program"
	puts "will tell you whether triangle is right or not."
	puts "In addition if this triangle is right this programm"
	puts "will also calculate whether this triangle is isoscels or not."
	puts

	puts "First please type in length of trinagle's sides."
	print "Please type in length of triangle's first side in centimeters: "
	first_side_length = Float(gets.chomp)
	print "Please type in length of triangle's second side in centimeters: "
	second_side_length = Float(gets.chomp)
	print "Please type in length of triangle's third side in centimeters: "
	third_side_length = Float(gets.chomp)
	flag_right_triangle = false
	flag_isosceles_triangle = false

	#Check for the longest triangle's side and right triangle's condition 
	if (first_side_length > second_side_length) && (first_side_length > third_side_length)
		if first_side_length == Math.sqrt(second_side_length**2 + third_side_length**2)		
			flag_right_triangle = true 			
		end
	elsif second_side_length > third_side_length
		if second_side_length == Math.sqrt(first_side_length**2 + third_side_length**2)
			flag_right_triangle = true 	
		end	
	else
		if third_side_length == Math.sqrt(first_side_length**2 + second_side_length**2)
			flag_right_triangle = true	
		end	
	end
	
	#Check for isosceles triange's condition
	if flag_right_triangle == true
		flag_isosceles_triangle = true if first_side_length == second_side_length		
	elsif first_side_length == third_side_length
		flag_isosceles_triangle = true
	elsif second_side_length == third_side_length
		flag_isosceles_triangle = true
	end
	
	#Print results acording to isosceles and right conditions
	if flag_isosceles_triangle == true
		puts "According to provided information about triangle sides' length,"
		puts "your triangle is right and also isosceles."
	elsif flag_right_triangle == true
		puts "According to provided information about triangle sides' length,"
		puts "your triangle is right."		
	end

	#Check for exit program condition
	puts "If you want to exit the program please type in 'Exit'."
	puts "Otherwise type in whatever you want to."
	exit_check = gets.chomp.capitalize!
	flag_program_exit = true if exit_check == "Exit"
end