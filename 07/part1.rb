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

def find_all(rules, color)
  direct = rules.filter { |rule| rule.color == color }.map(&:contained_in)
  indirect = []
  for outer_color in direct
    for c in find_all(rules, outer_color)
      indirect << c unless indirect.include?(c)
    end
  end
  return (direct + indirect).uniq
end

puts find_all(rules, "shiny gold").count
