class Player
  require_relative "move"

  attr_accessor :in_a_row
  attr_reader :num_moves, :name

  def initialize(name)
    @name = name
    @num_moves = 0
  end

  def play_move(board, game)
    selected_col = get_column

    if board.valid_move?(selected_col)
      @num_moves += 1
      move = Move.new(col: selected_col, board: board, player: self, game: game)
    else
      puts "sorry, that's not a valid column"
      play_move(board)
    end
  end

  private
    def get_column
      puts @name + ", which column would you like to place a piece in?"
      gets.to_i - 1 #convert to 0 indexed
    end

end
