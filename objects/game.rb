require 'io/console'
require './game_objects/board.rb'
require './modules/screen.rb'
class Game
  include BoardSettings
  attr_accessor :board, :player_array, :turns
  def initialize
    @board = Board.new
    @turns = -1
    set_target_array
  end
  def set_target_array
    
  end
  def next_state
    board.board_matrix[turns].generate_evaluation(@board.target_row)
    if @turns<BOARD_DIMENSIONS[1]-1
      @turns += 1
      current_row = board.board_matrix[turns]
      current_row.activate
      edit_board 
    else game_over board.board_matrix[turns] end
  end
  def edit_board
    cursor=BOARD_DIMENSIONS[0]**2
    @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
    Screen.clear
    @board.render(@turns)
    Screen.get_live_input do |state|
      case state
      when 'up'
        @board.color_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
      when 'down'
        @board.color_change_at(cursor%BOARD_DIMENSIONS[0], @turns)
      when 'right'
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
        cursor+=1
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns)
      when 'left'
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
        cursor-=1
        @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns, true)
      end
      Screen.clear
      @board.render(@turns)
    end
    @board.sprite_change_at(cursor%BOARD_DIMENSIONS[0], @turns)
    @board.reverse_row @turns
    next_state
  end
  def game_over final_row, won=false
    Screen.clear
    @board.render(@turns, true)
    if final_row.keys.all_black? then puts "WON" else puts "TRY AGAIN" end
  end
end

g=Game.new
g.board.render
g.next_state

# Screen.get_live_input do |val|
#       Screen.clear
#       @board.render