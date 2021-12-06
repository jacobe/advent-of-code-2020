LENGTH = 10

def get_seat_id(seat)
  id = 0
  seat.chars.each_index do |i|
    id += (seat[i] == 'F' || seat[i] == 'L' ? 0 : 1) * 2.pow(LENGTH - i - 1)
  end
  id
end

file = File.open("input")

seat_ids = file.readlines.map(&:chomp).map { |line| get_seat_id(line) }
puts seat_ids.max