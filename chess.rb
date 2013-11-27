# encoding: utf-8

require_relative './board.rb'

class ChessGame

  HORIZONTAL_POSITIONS = {
    :A => 0,
    :B => 1,
    :C => 2,
    :D => 3,
    :E => 4,
    :F => 5,
    :G => 6,
    :H => 7
    }



  def initialize
    @board = Board.new
  end

  def render
    @board.render_grid
  end

  def move_piece(start, finish)
    start = start.split("")
    finish = finish.split("")


    start[0] = HORIZONTAL_POSITIONS[start[0].to_sym]
    start[1] = start[1].to_i - 1

    start[0], start[1] = start[1], start[0]

    finish[0] = HORIZONTAL_POSITIONS[finish[0].to_sym]
    finish[1] = finish[1].to_i - 1

    finish[0], finish[1] = finish[1], finish[0]

    p start
    p finish


    @board.move(start, finish)
  end

=begin
  def play

    #store white king / black king positions in game to confirm check each turn?

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
=end

end


c = ChessGame.new
c.render
c.move_piece("D2", "D4")
c.render


