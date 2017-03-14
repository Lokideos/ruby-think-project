=begin
Lokideos, Thinknetica RoR courses, lesson-2, task-4
Program "Hash with letters' numbers"
This program will fill a hash with vowels and their numbers in alphabet.
This program will check only letters in lower case.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize
  puts "Greetings! This programm will form hash containing vowels letters"
  puts "and their index in the alphabet."
  letters = ('a'..'z').to_a
  vowels = {}  

  #Fill the hash with vowels and their indexes 
  letters.each.with_index(1) do |letter, index|    
    if !(letter =~ /[aeiouy]/).nil?
      key = letter.to_sym
      vowels[key] = index
    end
  end

  puts "According to program calculations we've recieved following hash:"
  vowels.each { |letter, index| puts "#{letter}: #{index}"}

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
