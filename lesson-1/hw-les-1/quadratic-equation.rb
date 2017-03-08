=begin
Lokideos, Thinknetica RoR courses, lesson-1, task-4
Program "Quadratic equation"
Program takes user input which is value of three variables 
usually called 'a', 'b' and 'c'. 
After that program will calculate equation rootes.
According to disciminant's value there are 3 possible solutions for the quadratic equation:
1) If D > 0 there are 2 roouts;
2) If D = 0 there is only 1 root;
3) If D < 0 there is no root for this equation.
As program output user should get discriminant's value and value of equation's roots
=end

flag_program_exit = false

while flag_program_exit == false

	#Initialize
	puts "Greetings! This program will calculate roots and discriminant"
	puts "for quadratic equation, which looks like 'ax^2 + bx + c."
	puts "To proceed please type in coefficients 'a', 'b' and 'c'."
	puts
	print "Please type in value of 'a' coefficient: "
	a = Float(gets.chomp)
	print "Please type in value of 'b' coefficient: "
	b = Float(gets.chomp)
	print "Please type in value of 'c' coefficient: "
	c = Float(gets.chomp)

	#Calculate discriminant and print out the results (discriminant & roots)
	d = b**2 - 4*a*c;
	print "The discriminant is equal to #{d}";
	if d > 0
		puts ", x1 is equal to #{-b + Math.sqrt(d)} and x2 is equal to #{-b - Math.sqrt(d)}";		
	elsif d == 0
		puts ", x is equal to #{-b/2/a}"		
	else
		puts " therefore there are no roots for this equation"
	end		

	#Check for exit program condition	
	puts
	puts "If you want to exit the program please type in 'Exit'."
	puts "Otherwise type in whatever you want to."
	exit_check = gets.chomp.capitalize!
	flag_program_exit = true if exit_check == "Exit"
end