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

program_exit = false

while !program_exit

	#Initialize
	puts "Greetings! This program will calculate roots and discriminant"
	puts "for quadratic equation, which looks like 'ax^2 + bx + c."
	puts "To proceed please type in coefficients 'a', 'b' and 'c'."
	puts
	print "Please type in value of 'a' coefficient: "
	a = gets.chomp.to_f
	print "Please type in value of 'b' coefficient: "
	b = gets.chomp.to_f
	print "Please type in value of 'c' coefficient: "
	c = gets.chomp.to_f

	#Calculate discriminant and print out the results (discriminant & roots)
	d = b**2 - 4*a*c;

	print "The discriminant is equal to #{d}";
	if d > 0
		d_sqrt = Math.sqrt(d)
		puts ", x1 is equal to #{-b + d_sqrt} and x2 is equal to #{-b - d_sqrt}";		
	elsif d == 0
		puts ", x is equal to #{-b/2/a} and its the only one root."		
	else
		puts " therefore there are no roots for this equation."
		puts "But frankly speaking it's not quite true."
	end		

	#Check for exit program condition	
	puts
	puts "If you want to exit the program please type in 'Exit'."
	puts "Otherwise type in whatever you want to."
	exit_check = gets.chomp.capitalize!
	program_exit = true if exit_check == "Exit"
end