require 'set'

file = File.open("input")
groups = file.read.split("\n\n").map do |group|
  persons = group
    .split("\n")
    .map(&:chars)
  persons
    .drop(1)
    .reduce(persons[0]) { |set, chars| set & chars }
    .count
end

puts groups.sum