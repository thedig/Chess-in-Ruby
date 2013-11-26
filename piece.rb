
require_relative './board.rb'

class MethodUndefinedError < StandardError
end

class Piece
  attr_accessor :position, :color

  def initialize(position, color, board)
    @position, @color, @board = position, color, board
  end

  # SG SUGGESTION: SHOULD ADD A "REMOVE" METHOD THAT SETS THE PIECE COORDINATES TO ZERO. THIS NEEDS TO BE PAIRED WITH A "REMOVE" METHOD FROM THE BOARD THAT UPDATES THE BOARD GRID


  def move
    raise MethodUndefinedError.new("move method not yet implemented")
  end

  def all_valid_moves
    raise MethodUndefinedError.new("valid_moves method not yet implemented")
  end

  def to_s
    "P"
  end


end

class SlidingPiece < Piece
  def move(new_position)
    @position = new_position
  end

  #this is all moves, regardless of other pieces on the board
  def valid_moves
    #assuming rook
    offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]
    all_valid_moves = []

    offsets.each do |offset|
      prior_position = @position
      position_valid = true

      while position_valid
        new_pos = [(prior_position[0] + offset[0]), (prior_position[1] + offset[1])]
        unless position_in_bounds?(new_pos)
          position_valid = false
        else
          current_piece = @board[new_pos[0], new_pos[1]]
          if current_piece.nil?
            all_valid_moves << new_pos
          elsif current_piece.color == self.color # helper method?
            position_valid = false
          else    #therefore, opposite color
            all_valid_moves << new_pos
            position_valid = false
          end
          prior_position = new_pos
        end
      end
    end
    all_valid_moves
  end

  def print_valid_moves

  end

  def position_in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

end



class SteppingPiece < Piece
end

class Pawn < Piece
end

b = Board.new
rook = SlidingPiece.new([4,3], "w", b)
b[4, 3] = rook

#
b.render_grid
#
p = SlidingPiece.new([3, 3], "w", b)
b[3, 3] = p

puts
puts
b.render_grid

p rook.valid_moves
#
# p p.valid_moves