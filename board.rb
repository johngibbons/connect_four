class Board
  attr_reader :num_cols, :num_rows, :spaces
  attr_accessor :winning_player

  def initialize
  end

  def num_rows=(num_rows)
    unless num_rows > 0
      raise ArgumentError.new("Must be a valid number greater than 0")
    end
    @num_rows = num_rows
  end

  def num_cols=(num_cols)
    unless num_cols > 0
      raise ArgumentError.new("Must be a valid number greater than 0")
    end
    @num_cols = num_cols
  end

  def generate
    @spaces = Array.new(@num_rows) {Array.new(@num_cols, "o")}
    render
  end

  def winner?(row, col, player)
    player.in_a_row = 1

    enough_in_a_row?(player.in_a_row)
    check_adjacent(row, col, player)
  end

  def valid_move?(col)
    valid_col?(col) && open_space(col)
  end

  def contains?(row:, col:)
    valid_row?(row) && valid_col?(col)
  end

  def render
    @spaces.each do |rows|
      rows.each do |s|
        print s
      end
      puts ""
    end
  end

  def open_space(col)
    (1..num_rows).each do |row|
      #start from bottom
      lowest_row = num_rows - row
      if spaces[lowest_row][col] == "o"
        return lowest_row
      elsif lowest_row == 0
        puts "column full"
        return false
      end
    end
  end

  def valid_col?(col)
    col.between?(0, @num_cols - 1)
  end

  def valid_row?(row)
    row.between?(0, @num_rows - 1)
  end

end


