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
end

class Array
  def deep_dup
    # Argh! Mario and Kriti beat me with a one line version?? Must
    # have used `inject`...

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