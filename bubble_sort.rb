# frozen_string_literal: true

def bubble_sort(arr)
  (0..arr.length - 2).each do |i|
    (0..arr.length - i - 2).each do |j|
      swap(arr, j) if arr[j] > arr[j + 1]
    end
  end

  arr
end

def swap(arr, index)
  tmp = arr[index]

  arr[index] = arr[index + 1]

  arr[index + 1] = tmp
end

# testing
arr = Array.new()
puts "Enter numbers to sort them using bubble sort algorithm: (type 'end' to stop)"
while true
  input = gets.chomp
  break if input == "end"
  
  begin
    arr.push(input.to_i)
  rescue
    puts "Please, Enter a number!!!"
  end
end

puts "Your Array: #{arr}"
puts "Sorted Array: #{bubble_sort(arr)}"
