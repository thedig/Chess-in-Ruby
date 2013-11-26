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
    flipped_grid = @grid.dup.reverse
    flipped_grid.each do |row|
      row.each do |spot|
        if spot.nil?
          print "[__]"
        else
          print spot
        end
      end
      puts
    end
  end

end


# a = Board.new
#
# #a[4, 3] = b
#
# #p a.[]=(4,3, 2)
# a.render_grid