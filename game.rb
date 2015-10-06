class Game
  require_relative "board"
  require_relative "player"

  attr_reader :num_to_win
  attr_accessor :board

  def initialize
    @board = Board.new
    @player1 = Player.new("player1")
    @player2 = Player.new("player2")
  end

  def generate_board
    set_rows
    set_cols
    @board.generate
  end

  def set_rows
    puts "how many rows? (enter number)"
    rows = gets.to_i

    begin
      @board.num_rows = rows
    rescue ArgumentError => e
      puts e.message
      set_rows
    end
  end

  def set_cols
    puts "how many columns? (enter number)"
    columns = gets.to_i

    begin
      @board.num_cols = columns
    rescue ArgumentError => e
      puts e.message
      set_cols
    end
  end

  def set_num_to_win
    puts "how many adjacent to win? (enter number)"
    to_win = gets.to_i

    begin
      self.num_to_win = to_win
    rescue ArgumentError => e
      puts e.message
      set_num_to_win
    end
  end

  def num_to_win=(num_to_win)
    if num_to_win < 2 || [@board.num_rows, @board.num_cols].min < num_to_win
      raise ArgumentError.new("Must be greater than 1 and less than or equal to lowest board dimension")
    end
    @num_to_win = num_to_win
  end

  def play
    until @move && @move.winning_move?
      if @player1.num_moves <= @player2.num_moves
        @move = @player1.play_move(@board, self)
      else
        @move = @player2.play_move(@board, self)
      end
    end

    puts winning_player + " wins!"

    @board.render
  end

  private

    def winning_player
      @move.player.name
    end

end

