file = File.open("input")
Instruction = Struct.new(:instruction, :argument, :visited)
instructions = file.readlines.map do |line|
  instruction, argument = line.strip.split(" ")
  Instruction.new(instruction, argument.to_i, false)
end

def run_program(instructions)
  acc = 0
  cursor = 0
  while true
    inst = instructions[cursor]
    if inst.visited
      puts "Inifinite loop detected"
      return acc
    end
    inst.visited = true
    case inst.instruction
    when 'nop'
      cursor += 1
    when 'acc'
      acc += inst.argument
      cursor += 1
    when 'jmp'
      cursor += inst.argument
    else
      raise "Unknown instruction #{inst.instruction}"
    end
  end
  return acc
end

puts run_program(instructions)