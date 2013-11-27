# encoding: utf-8
require_relative './slidingpiece'
require_relative './steppingpiece'
require_relative './pawn'
require 'debugger'

class Board

  attr_accessor :grid

  def initialize(new_grid = true)
    if new_grid
      create_grid
      set_up_board
    end
  end

  def board_dup
    dup_grid = @grid.deep_dup

    dup_board = Board.new(false)

    dup_grid.each do |row|
      row.each_index do |index|
        piece = row[index]
        next if piece.nil?

        row[index] = piece.class.new(piece.position.dup, piece.color, dup_board)
      end
    end

    dup_board.grid = dup_grid
    dup_board
  end

  def in_check?(color)
    alternate_color = color == :w ? :b : :w
    king_loc = king_location(color)
    all_pieces(alternate_color).any? do |piece|
      piece.available_moves.include?( king_loc )
    end

  end

  def in_check_mate?(color)
    in_check?(color) && all_pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def king_location(color)
    king = all_pieces(color).select { |piece| piece.class == King }[0]
    king.position
  end

  def all_pieces(color)
    @grid.flatten.compact.select { |piece| piece.color == color }
  end

  def []=(posx, posy, piece)
    # raise "mark already placed there!" unless empty?(pos)
    row, col = posx, posy
    @grid[row][col] = piece
  end

  def remove(piece)
    row, col = piece.position
    self[row, col] = nil
    piece.remove
  end

  def move(start_pos, end_pos)
    render_grid

    piece  = self[start_pos[0], start_pos[1]]

    raise "You can't move your piece into Check" if in_check?(piece.color)
    raise "Position not in bounds" unless
      position_in_bounds?(start_pos) && position_in_bounds?(end_pos)
    raise "no piece at your start position" if piece.nil?
    raise "Not an available move" unless piece.available_moves.include?(end_pos)

    move!(start_pos, end_pos)


  end

  def move!(start_pos, end_pos)
    # puts "start position is #{start_pos}"
    # puts "end position is #{end_pos}"

    piece  = self[start_pos[0], start_pos[1]]
    piece.update_position(end_pos)
    self[end_pos[0], end_pos[1]] = piece
    self[start_pos[0], start_pos[1]] = nil
  end

  def [](posx, posy)
    row, col = posx, posy
    @grid[row][col]
  end

  def create_grid
    @grid = Array.new(8) {Array.new(8)}
  end

  def render_grid
    render_with_labels(@grid.deep_dup.reverse)
  end

  def render_available_moves(piece)
    flipped_grid = @grid.deep_dup

    piece.valid_moves.each do |valid_move|
      flipped_grid[valid_move[0]][valid_move[1]] = "[**]"
    end

    render_with_labels(flipped_grid.reverse!)
  end

  def render_with_labels(grid)
    puts
    print "     " + "A   B   C   D   E   F   G   H"
    puts puts
    grid.each_with_index do |row, r_index|
      print "#{8-r_index}   "
      row.each do |spot|
        print spot.nil? ? "[__]" : spot
      end
      print "   #{8-r_index}"
      puts
    end
    puts
    print "     " + "A   B   C   D   E   F   G   H"
    puts puts
  end

  def set_up_board

    8.times do |column|
      case column
      when 0, 7
        self[0, column] = Rook.new([0, column], :w, self)
        self[7, column] = Rook.new([7, column], :b, self)
      when 1, 6
        self[0, column] = Knight.new([0, column], :w, self)
        self[7, column] = Knight.new([7, column], :b, self)
      when 2, 5
        self[0, column] = Bishop.new([0, column], :w, self)
        self[7, column] = Bishop.new([7, column], :b, self)
      when 3
        self[0, column] = Queen.new([0, column], :w, self)
        self[7, column] = Queen.new([7, column], :b, self)
      when 4
        self[0, column] = King.new([0, column], :w, self)
        self[7, column] = King.new([7, column], :b, self)
      end
    end

    8.times do |column|
      self[1, column] = Pawn.new([1, column], :w, self)
      self[6, column] = Pawn.new([6, column], :b, self)
    end
  end

  def position_in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def won?
    return true if is_check_mate?(:b) || is_check_mate?(:w)
    false
  end

end

class Array
  def deep_dup

    [].tap do |new_array|
      self.each do |el|
        new_array << (el.is_a?(Array) ? el.deep_dup : el)
      end
    end

  end
end