module Sliding
  
  DIAGONAL = [:left_up, :right_up, :left_down, :right_down]
  HORIZONTAL = [:left, :right, :up, :down]
  
  def moves
    
  end
  
end

module Stepping 
  
  DIAGONAL = [:left_up, :right_up, :left_down, :right_down]
  HORIZONTAL = [:left, :right, :up, :down]
  
  def moves
    
  end
  
end 

class Piece
  def initialize(type, start_pos, board)
    @type = type
    @start_pos = start_pos
    @board = board
  end
  
  def moves 
    #will return an array of all the places you could move  
  end 
  
end

class NullPiece < Piece
  
end