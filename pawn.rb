# encoding: utf-8

require_relative './piece.rb'

class Pawn < Piece

  def initialize(position, color, board)
    super(position, color, board)
    determine_direction
  end

  def determine_direction
    @direction = @color == :b ? -1 : 1
  end

  def on_beginning_line?
    return true if @color == :b && @position[0] == 6
    return true if @color == :w && @position[0] == 1
    false
  end

  def valid_moves
    offsets = [[1,0], [1, -1], [1,1], [2,0]]

    potential_moves = offsets.map! do |coord|
      [(coord[0] * @direction) + @position[0], (coord[1] + @position[1])]
    end
    potential_moves.select! { |coord| position_in_bounds?(coord) }

    all_valid_moves = []
    next_move_open = false

    potential_moves.each_with_index do |move, index|
      current_piece = @board[move[0], move[1]]
      case index
      when 0
        if current_piece.nil?
          all_valid_moves << move
          next_move_open = true
        end
      when 3
        all_valid_moves << move if
          (current_piece.nil? && on_beginning_line?) && next_move_open
      else
        all_valid_moves << move if !current_piece.nil? && current_piece.color != @color
      end
    end
    all_valid_moves
  end

  def to_s
    #"[P#{color}]"
     @color == :b ? "[♟ ]" : "[♙ ]"
  end
end
