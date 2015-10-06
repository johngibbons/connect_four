class AdjacentSpace

  attr_accessor :val, :row, :col, :dir_r, :dir_c

  def initialize(row, col, move)
    @row = row
    @col = col
    @move = move
    @dir_r = @row - @move.row
    @dir_c = @col - @move.col
  end

end
