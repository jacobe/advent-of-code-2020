file = File.open("input")
groups = file.read.split("\n\n").map do |group|
  group.gsub("\n", "").chars.uniq.count
end
puts groups.sum