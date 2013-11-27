# encoding: utf-8

require_relative './piece.rb'

class SlidingPiece < Piece
  DIAGONAL_OFFSETS  = [[1, 1], [-1, 1], [1, -1], [-1, -1] ]
  HORIZVERT_OFFSETS = [[1, 0], [-1, 0], [0, 1],  [0, -1]  ]

  def offsets
    raise "Not Yet Implemented"
  end

  #this is all moves, regardless of other pieces on the board
  def available_moves
    all_available_moves = []

    offsets.each do |offset|
      prior_position = @position

      while true
        new_pos = [(prior_position[0] + offset[0]), (prior_position[1] + offset[1])]
        break unless position_in_bounds?(new_pos)
        current_piece = @board[new_pos[0], new_pos[1]]
        all_available_moves << new_pos if current_piece.nil? || current_piece.color != self.color
        break if !current_piece.nil?
        prior_position = new_pos
      end
    end
    all_available_moves
  end
end

class Rook < SlidingPiece

  def offsets
    HORIZVERT_OFFSETS
  end

  def to_s
    #"[R#{color}]"
    @color == :b ? "[♜ ]" : "[♖ ]"
  end

end

class Queen < SlidingPiece

  def offsets
    HORIZVERT_OFFSETS + DIAGONAL_OFFSETS
  end

  def to_s
    #"[Q#{color}]"
    @color == :b ? "[♛ ]" : "[♕ ]"
  end

end

class Bishop < SlidingPiece

  def offsets
    DIAGONAL_OFFSETS
  end

  def to_s
    #"[B#{color}]"
    @color == :b ? "[♝ ]" : "[♗ ]"
  end

end