file = File.open("input")
numbers = file.readlines.map(&:to_i)

def is_valid(number, preamble)
  puts "Checking #{preamble}"
  for a in 0...PREAMBLE_SIZE
    for b in a+1...PREAMBLE_SIZE
      puts "#{number}: #{preamble[a]} + #{preamble[b]} = #{preamble[a] + preamble[b]}"
      if preamble[a] + preamble[b] == number
        return true
      end
    end
  end
  return false
end

PREAMBLE_SIZE=25
for i in PREAMBLE_SIZE...(numbers.size)
  if !is_valid(numbers[i], numbers.slice((i-PREAMBLE_SIZE)...i))
    puts "Found invalid number: #{numbers[i]}"
    break
  end
end
