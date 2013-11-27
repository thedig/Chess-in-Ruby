# encoding: utf-8

class MethodUndefinedError < StandardError
end

class Piece
  attr_accessor :position, :color

  def initialize(position, color, board)
    @position, @color, @board = position, color, board
  end

  def remove
    @position = nil
  end

  def move(new_position)
    @position = new_position
  end

  def valid_moves
    raise MethodUndefinedError.new("valid_moves method not yet implemented")
  end

  def to_s
    raise MethodUndefinedError.new("to_s method not yet implemented")
  end

  def position_in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end
end




=begin

b = Board.new
rook = Rook.new([4,3], :b, b)
b[4, 3] = rook

rook2 = Rook.new([6, 4], :b, b)
b[6,4] = rook2

bishop = Bishop.new([2, 4], :b, b)
b[2, 4] = bishop

knight = Knight.new([0,0], :b, b)
b[0, 0] = knight


b.render_grid

piece = Pawn.new([1, 5], :w, b)
b[1, 5] = piece

puts
puts
b.render_available_moves(piece)

=end