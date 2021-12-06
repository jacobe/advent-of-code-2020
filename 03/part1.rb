file = File.open("input")

map = file.readlines.map do |line|
  line.chomp.chars.map { |char| char == '#' ? 1 : 0 }
end

Vector = Struct.new(:x, :y)
position = Vector.new(0, 0)
slope = Vector.new(3, 1)

tree_count = 0
for row in 0..map.length-1 do
  tree_count += map[position.y][position.x % map[0].length]
  position.x += slope.x
  position.y += slope.y
end

puts tree_count