require "singleton"
require "byebug"

module Sliding
  
  HORIZONTAL = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ]
  
  DIAGONAL = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  
  def horizontal 
    HORIZONTAL
  end
  
  def diagonal
    DIAGONAL
  end 
  
  def moves
    # debugger
    # [[ 0, 1], [0, 2]]
    # array of all possible positions in regards to which direction the piece can move
    # for each direction, generate a path with #grow_unblocked_moves_in_dir and concat to main array of possible positions
    debugger
    dir = self.move_dirs
    possible_moves = []
    
    dir.each do |direction|
      curr_pos = @start_pos
      while @board[curr_pos].is_a?(NullPiece)
        possibles_moves << [curr_pos[0] + direction[0], curr_pos[1] + direction[1]]
      end 
    end
    possible_moves
  end
      
  # def grow_unblocked_moves_in_dir(dx, dy)
  #   #grow_unblocked_moves_in_dir returns array of positions that are arrays per direction
  #   result = []
  # 
  # end
  
  
  def move_dirs
    raise NotImplementedError
  end
end

module Stepping 
  
  DIAGONAL = [:left_up, :right_up, :left_down, :right_down]
  HORIZONTAL = [:left, :right, :up, :down]
  
  # def moves
  # 
  # end
  
  # private
  # def move_diffs
  # 
  # end
  
end 

class Piece
  def initialize(start_pos, board, color)
    @start_pos = start_pos
    @board = board
    @color = color
  end
  
  # def moves 
  #   #will return an array of all the places you could move  
  # end 
  
end

class NullPiece < Piece
  include Singleton
  
  def initialize(color = "nil")
    @color = color
  end
  
  def symbol
    "   "
  end 
  
end

class Rook < Piece 
  include Sliding
  attr_reader :color, :start_pos

  def initialize(start_pos, board, color)
    @color = color
    @start_pos = start_pos
    @board = board
  end
     
  def move_dirs
    horizontal
  end 
  
  def symbol
    " ♜ "
  end
  
end 


