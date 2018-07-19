class PiecesController < ApplicationController
  def update
    @piece = current_piece
    @game = @piece.game
    # stops opponent from moving current players pieces, keep commented for local testing.
      # unless current_player == @piece.player
      #   return redirect_to game_path(@game)
      # end
    update_state(@game) if @piece.move_to!(new_square_params)
    redirect_to game_path(@game)
  end

  private

  def new_square_params
    @params = params.permit(:row, :column, :id)
    @params.each { |k, v| @params[k] = v.to_i }
  end

  def current_piece
    @piece || Piece.find(params[:id])
  end

  def update_state(game)
    return game.update(state: 2) if game.state == "White's Turn"
    return game.update(state: 1) if game.state == "Black's Turn"
  end
end
