file = File.open("input")

class Passport
  REQUIRED_FIELDS = %w(byr iyr eyr hgt hcl ecl pid)
  VALID_EYE_COLORS = %w(amb blu brn gry grn hzl oth)

  def initialize(args)
    args.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def is_valid?
    REQUIRED_FIELDS.all? do |key|
      !instance_variable_get("@#{key}").nil? && send("validate_#{key}")
    end
  end

  private

  def validate_byr
    year = @byr.to_i
    year >= 1920 && year <= 2002
  end

  def validate_iyr
    year = @iyr.to_i
    year >= 2010 && year <= 2020
  end

  def validate_eyr
    year = @eyr.to_i
    year >= 2020 && year <= 2030 
  end

  def validate_hgt
    match = /^(\d+)(cm|in)$/.match(@hgt)
    return false if match.nil?
    height = match[1].to_i
    unit = match[2]
    if unit == "cm"
      height >= 150 && height <= 193
    else # unit == "in"
      height >= 59 && height <= 76
    end
  end

  def validate_hcl
    /^#[0-9a-f]{6}$/.match(@hcl)
  end

  def validate_ecl
    VALID_EYE_COLORS.include?(@ecl)
  end

  def validate_pid
    /^[0-9]{9}$/.match(@pid)
  end
end

passports = []
fields = Hash.new
map = file.readlines.map(&:chomp).map do |line|
  if line.length > 0
    fields.merge! Hash[line.split(' ').map do |f|
      key, value = f.split(':')
      [key.to_sym, value]
    end] unless line.length == 0
  else
    passports << Passport.new(fields)
    fields.clear
  end
end
passports << Passport.new(fields)

puts "Scanning #{passports.length} passports"

valid_passport_count = 0
passports.each do |passport|
  if passport.is_valid?
    valid_passport_count += 1
  end
end

puts "#{valid_passport_count} are valid"