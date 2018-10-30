require_relative "cursor"
require 'colorize'
require 'byebug'
class Display 

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board 
    @start_pos = nil
    @end_pos = nil
  end 
  
  def move_cursor(next_pos)
    @cursor.update_pos(next_pos) if @board.valid_pos?(next_pos)
  end 
  
  def render
    loop do 
      # debugger
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
      try = @cursor.get_input
      unless try.nil? 
        if @start_pos.nil?
          @start_pos = try
        else
          @end_pos = try
          @board.move_piece(@start_pos, @end_pos)
          @start_pos = nil
          @end_pos = nil
        end 
      end
    end
  end
end 


