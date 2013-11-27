# encoding: utf-8

require_relative './piece.rb'

class SteppingPiece < Piece

  def available_moves
    all_available_moves = []

    offsets.each do |offset|

      prior_position = @position
      new_pos = [(prior_position[0] + offset[0]), (prior_position[1] + offset[1])]

      next unless position_in_bounds?(new_pos)

      current_piece = @board[new_pos[0], new_pos[1]]
      all_available_moves << new_pos if current_piece.nil? || current_piece.color != self.color
    end
    all_available_moves

  end

  def offsets
    raise "Not Yet Implemented"
  end

end

class King < SteppingPiece
  def offsets
    [ [1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1],  [0, -1] ]
  end

  def to_s
    #"[K#{color}]"
    @color == :b ? "[♚ ]" : "[♔ ]"
  end

end

class Knight < SteppingPiece
  def offsets
    [ [1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1] ]
  end

  def to_s
    #"[N#{color}]"
    @color == :b ? "[♞ ]" : "[♘ ]"
  end
end
