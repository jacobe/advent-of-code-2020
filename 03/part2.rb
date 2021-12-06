file = File.open("input")

map = file.readlines.map do |line|
  line.chomp.chars.map { |char| char == '#' ? 1 : 0 }
end

Vector = Struct.new(:x, :y)
slopes = [
  Vector.new(1, 1),
  Vector.new(3, 1),
  Vector.new(5, 1),
  Vector.new(7, 1),
  Vector.new(1, 2)
]

product = 1
for slope in slopes do
  tree_count = 0
  position = Vector.new(0, 0)
  loop do
    tree_count += map[position.y][position.x % map[0].length]
    position.x += slope.x
    position.y += slope.y
    if position.y > map.length - 1
      break
    end
  end
  puts "(#{tree_count})"
  product *= tree_count
end

puts product