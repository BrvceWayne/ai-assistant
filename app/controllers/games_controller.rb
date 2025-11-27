class GamesController < ApplicationController
  def index
    @games = Game.all.order(created_at: :desc)
  end

  def scenarios
    @scenarios = Scenario.all
  end

  def characters
    @scenario = Scenario.find(params[:scenario_id])
    @characters = Character.all
  end

  def create
    @scenario  = Scenario.find(params[:scenario_id])
    @character = Character.find(params[:character_id])

    @game = Game.new(
      scenario: @scenario,
      character: @character
    )

    if @game.save
      intro = "Bienvenue #{@game.character.name} ! #{@game.scenario.description}"
      @game.messages.create!(role: "assistant", content: intro)
      redirect_to game_path(@game)
    else
      redirect_to games_scenarios_path, alert: "Impossible de démarrer la partie."
    end
  end

  def show
    @game = Game.find(params[:id])
    @character = @game.character
    @scenario = @game.scenario
    @messages = @game.messages.order(created_at: :asc)
  end

  def player_action
    @game = Game.find(params[:id])
    player_input = params[:action_text]
    @game.messages.create!(role: "user", content: player_input)

    # Message test (on mettra l'API après)
    @game.messages.create!(role: "assistant", content: "Test réponse IA")

    redirect_to game_path(@game)
  end
end
