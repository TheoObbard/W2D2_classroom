require_relative "cursor"
require 'colorize'

class Display 

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board 
  end 
  
  def move_cursor(next_pos)
    @cursor.update_pos(next_pos) if @board.valid_pos?(next_pos)
  end 
  
  def render
    system("clear")
    @board.grid.each_with_index do |row, ri| 
      print "\n"
      row.each_with_index do |cell, ci|
        if [ri,ci] == @cursor.cursor_pos
          print row[ci].symbol.red
        else
          print row[ci].symbol
        end
      end
    end
    @cursor.get_input
  end
  
end 


