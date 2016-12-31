class PlayersGame < ApplicationRecord
  enum position: [:left, :right]
  belongs_to :player
  belongs_to :game
  validates :game_id, uniqueness: {scope: [:position]}
  validates :player_id, uniqueness: {scope: [:game_id]}

  after_commit :update_game

  private
 
  def update_game
    if game.waiting? && game.players_games.count == 2
      game.status = :playing
      game.save
    end
  end
end