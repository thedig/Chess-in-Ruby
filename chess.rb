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
    @player = :w
  end

  def switch_player
    @player = @player == :w ? :b : :w
  end

  def player_name
    return "White Player" if @player == :w
    return "Black Player" if @player == :b
  end

  def play
    until @board.won?
      render

      puts "Current player: #{player_name}\n\n"

      begin
        puts "Check!" if @board.in_check?(@player)

        user_input = request_input
        break if user_input == "exit"
        move_piece(user_input[0], user_input[1])
      rescue Exception => e
        puts e.message
        retry
      end

      switch_player
    end

    render

    winning_player = @board.in_check_mate?(:w) ? "Black" : "White"
    puts "#{winning_player} won the game!"



    if user_input == "exit"
      puts "\nGoodbye, quitter!"
    end
  end

  def request_input
    puts 'Enter your start and end position in the following format: "A2, A4"'

    begin
      user_input = gets.chomp

      return user_input if user_input == "exit"

      unless user_input =~ /^[a-h][1-8],\s* [a-h][1-8]$/
        raise 'Must enter both a start and end coordinate in the format "A2, A4"'
      end

      user_input = user_input.split(/,\s*/)
      start_coord = user_input[0]
      end_coord = user_input[1]

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

    if piece_matches_player_color?(start)
      @board.move(start, finish)
    else
      raise "#{player_name} doesn't have a piece at that coordinate\n"
    end
  end

  def piece_matches_player_color?(start)
    piece = @board[start[0], start[1]]
    return false if piece.nil?
    piece.color == @player
  end

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


