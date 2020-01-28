require './game_objects/pawn.rb'
require './modules/board_settings.rb'
class Row
  include BoardSettings
  attr_accessor :row_array, :acivated, :color_preference, :keys
  def initialize color_preference=[6, 6, 6, 6]
    @row_array = Array.new
    @color_preference = color_preference
    @acivated = false
    build
  end
  private
  def build
    BOARD_DIMENSIONS[0].times do |index|
      @row_array << Pawn.new((@color_preference[index]))
    end
  end
  public
  def activate
    @row_array.each do |pawn| pawn.activate end
    @acivated = true
  end
  def activated?
    @acivated
  end
  def render selected=false
    rendered_string = String.new
    @row_array.each do |pawn|
      rendered_string << pawn.render + PAWN_SPACING
    end
    if selected then return "├┤ " + rendered_string[0..-PAWN_SPACING.length] + "├┤" 
    else return "│  " + rendered_string[0..-PAWN_SPACING.length] + " │ -" end
  end
  def generate_evaluation target
    @keys = Keys.new(self, target)
  end
  def at x
    @row_array[x]
  end
  def reverse_sprite_all
    @row_array.each do |pawn|
      pawn.change_sprite
    end
  end
end
