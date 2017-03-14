=begin
Lokideos, Thinknetica RoR courses, lesson-2, task-6
Program "Amount of purchases"
This program will take user input which should be type in in the following order:
product name, price for 1 product, quantity of product.
Program should take user input until user'll type in word "stop".
Then program should generate and print hash with product names as keys and
hashes, containing price for 1 product and amount of purchased products, as a value.
Also program should print total amount for each product and for the whole purchase.
=end

exit_check = ""

until exit_check == "exit"

  #Initialize
  puts "Greetings! In this program you will form a shopping cart!"
  puts "You will add product name, and then its price and quantity."
  puts "As a result you will recieve total amount, amount for each product,"
  puts "and hash containing data about purchased products."
  puts
  cart = {}
  total_amount = 0
  name = ""

  #Filling shopping cart  
  loop do
    #Get the values
    puts "Type in product name"
    name = gets.chomp
    break if name == "stop" 
    
    puts "Type in product price"  
    price = gets.chomp.to_f    
    puts "Type in product quantity"
    quantity = gets.chomp.to_f
    
    #Assign values to the cart properties
    cart[name] = {price: price, quantity: quantity, amount: quantity*price}
    total_amount += cart[name][:amount]    
  end

  #Printing the output
  puts
  puts "Hash containing data about your purchase looks like following hash:"
  puts cart
  puts "As per amount for each products please refer to the information below."
  cart.each do |name, product|
    puts "Total price of #{name} is #{product[:amount]}"   
  end
  puts "The total amount for your purchase is #{total_amount}."

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end
