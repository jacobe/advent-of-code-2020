file = File.open("input")
Rule = Struct.new(:color, :count, :contained_in)
rules = file.readlines.map do |line|
  outer_bag, inner = line.gsub(/ bags?/, "").split(" contain")
  inner_bags = inner.gsub!(/\./, "").split(",").map(&:strip).map { |bag|
    count, color = bag.split(" ", 2)
    if count == "no"
      nil
    else
      Rule.new(color, count.to_i, outer_bag)
    end
  }
  inner_bags.compact
end.flatten

reverse_index = rules.inject({}) { |h, rule| 
  if !h.has_key?(rule.contained_in)
    h[rule.contained_in] = []
  end
  h[rule.contained_in] << rule
  h
}

def find_recurse(index, color)
  return 0 if !index.has_key?(color)
  acc = 0
  for rule in index[color]
    acc += rule.count + rule.count * find_recurse(index, rule.color)
  end
  return acc
end

puts find_recurse(reverse_index, "shiny gold")
