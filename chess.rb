# encoding: utf-8

require_relative './pawn.rb'
require_relative './steppingpiece.rb'
require_relative './slidingpiece.rb'
require_relative './board.rb'

class ChessGame

  def initialize
    @board = Board.new
  end

  def play

    loop do
      # ask player for move
      # confirm valid move
        # possible set of coordinates for piece?
        # excluding moves that puts player in check
      # make move
      # confirm if board is in check / checkmate
      # change player
      # repeat

    end

  end

end


b = Board.new
b.set_up_board
b.render_grid
# rook = Rook.new([4,3], :b, b)
# b[4, 3] = rook
#
# rook2 = Rook.new([6, 4], :b, b)
# b[6,4] = rook2
#
# bishop = Bishop.new([2, 4], :b, b)
# b[2, 4] = bishop
#
# knight = Knight.new([0,0], :b, b)
# b[0, 0] = knight
#
#
# b.render_grid
#
# piece = Pawn.new([1, 5], :w, b)
# b[1, 5] = piece
#
# puts
# puts
# b.render_available_moves(piece)
