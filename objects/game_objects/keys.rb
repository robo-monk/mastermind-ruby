require './game_objects/pawn.rb'
class Keys
  attr_accessor :this, :that, :keys_array
  def initialize this, target_array
    @this = this.row_array
    @that = target_array
  end
  def find_difference
    black_pins = Array.new()
    potential_white_pins = Array.new()
    actual_white_pins = Array.new()
    that.row_array.each_with_index do |tpawn, index|
      if tpawn.color == @this[index].color
        black_pins<<tpawn
      else potential_white_pins<<tpawn
      end
    end
    potential_white_pins.each_with_index do |ppawn, index|
      @this.each do |pawn| 
        if pawn.color == ppawn.color then actual_white_pins<<ppawn end
      end
    end
    return [black_pins.length, actual_white_pins.uniq.length]
  end
  def render
    bw = find_difference
    return "BLACK: #{bw[0]} , WHITE: #{bw[1]}"
  end
  def all_black?
    find_difference[0] >= 3
  end
end
