class GamesController < ApplicationController
  def home
  end

  # Liste des scénarios
  def scenarios
    @scenarios = Scenario.all
  end

  # Liste des personnages
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
      redirect_to @game
    else
      redirect_to games_scenarios_path, alert: "Impossible de démarrer la partie."
    end
  end
  
  def show
    @game = Game.find(params[:id])
  end
end

end
