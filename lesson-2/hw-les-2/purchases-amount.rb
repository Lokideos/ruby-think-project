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
  total_purchase = Hash.new
  total_amount = 0
  product_name = ""

  #Filling shopping cart
  until product_name == "stop" do
    puts "Type in product name."
    product_name = gets.chomp  
    if product_name != "stop"
      total_purchase[product_name] = {:price => 0.0, :quantity => 0.0, 
                                                      :product_amount => 0.0}
      puts "Type in product price"  
      product_price = gets.chomp.to_f
      total_purchase[product_name][:price] = product_price
      puts "Type in product quantity."
      product_quantity = gets.chomp.to_f
      total_purchase[product_name][:quantity] = product_quantity
      total_purchase[product_name][:product_amount] = product_quantity * product_price
      total_amount += total_purchase[product_name][:product_amount]
    end
  end

  #Printing the output
  puts
  puts "Hash containing data about your purchase looks like following hash:"
  puts total_purchase
  puts "As per amount for each products please refer to the information below."
  total_purchase.each do |product, properties|
    puts "Total price of #{product} is #{properties[:product_amount]}"   
  end
  puts "The total amount for your purchase is #{total_amount}."

  #Check for exit program condition
  puts
  puts "If you want to exit the program please type in 'exit'."
  puts "Otherwise type in whatever you want to."
  exit_check = gets.chomp.downcase
end