def game
  numbers = [1,1,3,2,4]
  counting = []
  numbers.each do |num|
    counting << numbers.count(num)
  end
  min = counting.min
  puts min
end


def new_hash
  hash = Hash.new
  hash = { 1 => 'Dima', 2 => 'Misha' }
  puts hash.sort.to_h
end
game
new_hash

class Just
  attr_accessor :show_number
  def initialize(number)
   @@array ||= []
   @@array << number
  end

  def self.show_number
    @@array.each do |a|
      a
    end
  end
end

num = Just.new(2)
num_1 = Just.new(3)

puts Just.show_number
