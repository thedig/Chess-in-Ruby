# encoding: utf-8

class MethodUndefinedError < StandardError
end

class Piece
  attr_accessor :position, :color, :board

  def initialize(position, color, board)
    @position, @color, @board = position, color, board
  end

  def remove
    @position = nil
  end

  def update_position(new_position)
    @position = new_position
  end

  def available_moves
    raise MethodUndefinedError.new("available_moves method not yet implemented")
  end

  def valid_moves
    # available_moves
    available_moves.delete_if do |move|
      dup_board = board.board_dup
      dup_board.move!(@position, move)
      dup_board.in_check?(@color)

    end
  end

  def to_s
    raise MethodUndefinedError.new("to_s method not yet implemented")
  end

  def position_in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end
end



