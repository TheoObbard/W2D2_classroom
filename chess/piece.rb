require "singleton"
require "byebug"

module Sliding
  
  # DIAGONAL = [
  #   [start_pos[0] + 1, start_pos[1] + 1],
  #   [start_pos[0] - 1, start_pos[1] - 1],
  #   [start_pos[0] - 1, start_pos[1] + 1],
  #   [start_pos[0] + 1, start_pos[1] - 1]
  # ]
  # 
  # HORIZONTAL = [
  #   [start_pos[0] + 1, start_pos[1]],
  #   [start_pos[0] - 1, start_pos[1]],
  #   [start_pos[0], start_pos[1] + 1],
  #   [start_pos[0], start_pos[1] - 1]
  # ]
  
  HORIZONTAL = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ]
  
  def horizontal 
    HORIZONTAL
  end 
  
  def moves
    # debugger
    # [[ 0, 1], [0, 2]]
    # array of all possible positions in regards to which direction the piece can move
    # for each direction, generate a path with #grow_unblocked_moves_in_dir and concat to main array of possible positions
    dir = self.move_dir
    possible_moves = []
    
    dir.each do |direction|
      direction.each do |pos|
        possible_moves << [@start_pos[0] + pos[0], @start_pos[1] + pos[1]]
      end
    end
    
    possible_moves.each do |pos|
      dx, dy = pos
      possible_moves += grow_unblocked_moves_in_dir(dx, dy) #grow_unblocked_moves_in_dir returns array of positions that are arrays per direction
    end
    possible_moves
  end
  
  def horizontal_dirs(dx, dy, direction)
    positions = []
    pos = [dx, dy]
    if direction == :right 
      pos[0] += 1      
      while @board[pos].is_a?(NullPiece) && pos[0].between?(0, 8)
        positions << pos 
        pos[0] += 1      
      end 
    else #left  
      pos[0] -= 1      
      while @board[pos].is_a?(NullPiece) && pos[0].between?(0, 8)
        positions << pos 
        pos[0] -= 1      
      end 
    end 
    positions
  end
  
  def vertical_dirs(dx, dy, direction)
    positions = []
    pos = [dx, dy]
    if direction == :up 
      pos[1] += 1      
      while @board[pos].is_a?(NullPiece) && pos[1].between?(0, 8)
        positions << pos 
        pos[1] += 1      
      end 
    else #down  
      pos[1] -= 1      
      while @board[pos].is_a?(NullPiece) && pos[1].between?(0, 8)
        positions << pos 
        pos[1] -= 1      
      end 
    end 
    positions
  end
      
  def grow_unblocked_moves_in_dir(dx, dy)
    # array of positions depending on the direction taken
    result = []
    dir = determine_dir(dx, dy)
    case dir 
    when :right 
      result += horizontal_dirs(dx, dy, :right)
    when :left 
      result += horizontal_dirs(dx, dy, :left)
    when :up
      result += vertical_dirs(dx, dy, :up)
    when :down 
      result += vertical_dirs(dx, dy, :down)
    end
  end
  
  private
  
  
  def determine_dir(dx, dy)
    x, y = @start_pos
    case x <=> dx 
    when -1
      :right
    when 1
      :left 
    when 0
      case y <=> dy
      when -1
        :up
      when 1
        :down 
      when 0
        raise "Same position!"
      end 
    end 
  end 
  
  def move_dirs
    raise NotImplementedError
  end
end

module Stepping 
  
  DIAGONAL = [:left_up, :right_up, :left_down, :right_down]
  HORIZONTAL = [:left, :right, :up, :down]
  
  def moves
    
  end
  
  private
  def move_diffs
    
  end
  
end 

class Piece
  def initialize(start_pos, board, color)
    @start_pos = start_pos
    @board = board
    @color = color
  end
  
  def moves 
    #will return an array of all the places you could move  
  end 
  
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
     
  def move_dir
    [HORIZONTAL]
  end 
  
  def symbol
    " ♜ "
  end
  
end 


