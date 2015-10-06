require "spec_helper"

describe Move do

  before do
    @board = Board.new
    @board.num_rows = 8
    @board.num_cols = 10
    @game = Game.new
    @game.num_to_win = 4
    @player1 = Player.new("player1")
  end

  it "isn't a winning move" do
    @move = Move.new(col: 4, board: @board, player: @player1, game: @game)
  end

end
