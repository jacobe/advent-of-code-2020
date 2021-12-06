file = File.open("input")

Instruction = Struct.new(:instruction, :argument, :visited)
instructions = file.readlines.map do |line|
  instruction, argument = line.strip.split(" ")
  Instruction.new(instruction, argument.to_i, false)
end

def run(acc, instructions, cursor, changed)
  while true
    if cursor >= instructions.size
      puts "End of instructions. Value is #{acc}"
      break
    end
    inst = instructions[cursor]
    if inst.visited
      return nil
    end
    inst.visited = true

    if inst.instruction == 'acc'
      acc += inst.argument
      cursor += 1
    elsif inst.instruction == 'nop'
      run(acc, instructions, cursor + 1, changed)
      if !changed
        run(acc, instructions, cursor + inst.argument, true)
      end
      break
    elsif inst.instruction == 'jmp'
      run(acc, instructions, cursor + inst.argument, changed)
      if !changed
        run(acc, instructions, cursor + 1, true)
      end
      break
    end
  end
end
run(0, instructions, 0, false)
