# encoding: utf-8

require_relative './board.rb'

class ChessGame
  attr_reader :board

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

  def play
    until won?
      render

    end
      # ask player for move
      # confirm valid move
        # possible set of coordinates for piece?
        # excluding moves that puts player in check
      # make move
      # confirm if board is in check / checkmate
      # change player
      # repeat

  end

  def request_input
    puts 'Enter your start and end position in the following format: "A2, A4"'
    begin
      user_input = gets.chomp.split(", ")
      start_coord = user_input[0]
      end_coord = user_input[1]
    rescue

    end
  end


  def render
    @board.render_grid
  end

  def move_piece(start, finish)
    start = start.split("")
    finish = finish.split("")


    start[0] = HORIZONTAL_POSITIONS[start[0].upcase.to_sym]
    start[1] = start[1].to_i - 1

    start[0], start[1] = start[1], start[0]

    finish[0] = HORIZONTAL_POSITIONS[finish[0].upcase.to_sym]
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
c.move_piece("f2", "f3")
c.move_piece("e7", "e5")

c.move_piece("g2", "g4")
p c.board.in_check?(:w)
p c.board.in_check_mate?(:w)

c.move_piece("d8", "h4")
c.render
p c.board.in_check?(:w)
p c.board.in_check_mate?(:w)
c.render

# p c.board.render_available_moves(c.board[1, 7])


