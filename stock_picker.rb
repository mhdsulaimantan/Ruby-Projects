def stock_picker(prices)
  min_price = prices[0]
  min_index = 0

  profit = 0
  days = [0, 0]

  prices.each_with_index do |price, ind|
    if price < min_price
      min_price = price
      min_index = ind
      next
    end

    if price - min_price > profit
      profit = price - min_price
      days = [min_index, ind]
    end
  end

  days
end

stock_arr = Array.new()
day = 1
puts "Enter the stocks for each day: (type 'end' to stop)"
while true
  puts "day #{day}: "
  input = gets.chomp
  break if input == "end"
  
  begin
    stock_arr.push(input.to_i)
  rescue
    puts "Please, Enter a number!!!"
  end
  day += 1
end

best_profit = stock_picker(stock_arr)
puts "You should buy in the #{best_profit[0]+1} day and sell in the #{best_profit[1]+1} day to get the best profit."
