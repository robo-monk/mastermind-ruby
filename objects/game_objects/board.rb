require './game_objects/row.rb'
require './modules/board_settings.rb'
class Board
  include BoardSettings
  attr_accessor :board_matrix, :target_row
  def initialize
    @board_matrix = Array.new
    @target_row = Row.new([1,2,3,4])
    build
  end
  private
  def build
    BOARD_DIMENSIONS[1].times do |index|
      @board_matrix << Row.new
    end
  end
  public
  def render select=-1, game_over=false
    puts "│"+SPACER
    puts (!game_over ? "   ?   ?   ?   ?" : @target_row.render )
    puts "│"+SPACER
    rendered_array = Array.new
    @board_matrix.reverse.each_with_index do |row, index|
      rendered_array << row.render
      if @board_matrix.length-index-1==select
        puts row.render(true) + (!game_over ? "  -#{index+1} attempts left" : "- FINAL COMP")
      else
        puts row.render + row.keys.render if row.activated?
      end
      puts "│"+SPACER+"│"
    end
    rendered_array
  end
  def color_change_at x, y, reverse = false
    @board_matrix[y].at(x).change_color reverse
  end
  def sprite_change_at x, y, reverse = false
    @board_matrix[y].at(x).change_sprite reverse
  end
  def reverse_row y
    @board_matrix[y].reverse_sprite_all
  end
end
