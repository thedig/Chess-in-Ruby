# encoding: utf-8

class Board

  def initialize
    create_grid
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
    print "     " + "0   1   2   3   4   5   6   7"
    puts
    puts
    grid.each_with_index do |row, r_index|
      print "#{7-r_index}   "
      row.each do |spot|
        print spot.nil? ? "[__]" : spot
      end
      puts
    end
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


# a = Board.new
#
# #a[4, 3] = b
#
# #p a.[]=(4,3, 2)
# a.render_grid