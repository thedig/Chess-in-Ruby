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
    until @board.won?
      render

      begin
        user_input = request_input
        break if user_input == "exit"
        move_piece(user_input[0], user_input[1])
      rescue Exception => e
        puts e.message
        retry
      end

    end

    if user_input == "exit"
      puts "Goodbye, quitter!"
    end
  end

  def request_input
    puts 'Enter your start and end position in the following format: "A2, A4"'
    begin
      user_input = gets.chomp

      return user_input if user_input == "exit" #otherwise shit gets annoying

      raise 'Must enter both a start and end coordinate in the format "A2, A4"' unless user_input =~ /[a-h][1-8],\s* [a-h][1-8]/

      user_input = user_input.split(/,\s*/)
      start_coord = user_input[0]
      end_coord = user_input[1]

      # raise "Invalid input, each coordinate must begin with a letter, A - H" unless
      #   start_coord[0] =~ /[a-h]{1}/i && end_coord[0] =~ /[a-h]{1}/i
      # raise "Invalid input, each coordinate must end with an integer, 1 - 8" unless
      #   start_coord[1] =~ /[1-8]{1}/ && end_coord[1] =~ /[1-8]{1}/
    rescue Exception => e
      puts e.message
      retry
    end
    [start_coord, end_coord]
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
c.play

=begin
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
=end
# p c.board.render_available_moves(c.board[1, 7])


