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
    @game = Game.new(
      scenario_id: params[:scenario_id],
      character_id: params[:character_id],
      state: 'in_progress'
    )

    if @game.save
      begin
        # Créer une session de chat
        chat = RubyLLM.chat

        # Construire un prompt texte (pas array)
        intro_prompt = <<~PROMPT
          #{@game.scenario.scenario_prompt}

          #{build_character_context}

          Commence l'aventure maintenant. Plonge-moi directement dans l'action.
        PROMPT

        # Appeler l'API
        response = chat.ask(intro_prompt)
        intro = response.content

      rescue => e
        Rails.logger.error("Erreur intro: #{e.message}")
        intro = "Bienvenue #{@game.character.name} dans #{@game.scenario.title}..."
      end

      @game.messages.create!(role: "assistant", content: intro)
      redirect_to game_path(@game)
    else
      redirect_to characters_games_path, alert: "Erreur"
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

    # Sauvegarder message joueur
    @game.messages.create!(role: "user", content: player_input)

    begin
      # Créer une session de chat
      chat = RubyLLM.chat

      # Construire un prompt texte complet avec historique
      full_prompt = <<~PROMPT
        #{@game.scenario.scenario_prompt}

        #{build_character_context}

        HISTORIQUE DE LA PARTIE :
        #{build_history}

        Action du joueur : #{player_input}

        Réponds en tant que maître du jeu :
      PROMPT

      # Appeler l'API
      response = chat.ask(full_prompt)
      ai_response = response.content

    rescue => e
      Rails.logger.error("Erreur LLM: #{e.message}")
      ai_response = "Le maître du jeu réfléchit... Réessayez dans quelques instants."
    end

    # Sauvegarder réponse IA
    @game.messages.create!(role: "assistant", content: ai_response)

    redirect_to game_path(@game)
 end

private

  def build_character_context
    <<~CONTEXT
      PERSONNAGE DU JOUEUR :
      - Nom : #{@game.character.name}
      - Classe : #{@game.character.class_type}
      - Points de Vie : #{@game.character.health}
      - Mana : #{@game.character.mana}
      - Force : #{@game.character.strength}
      - Particularités : #{@game.character.quirks}

      Adapte ta narration en fonction de ces caractéristiques.
    CONTEXT
  end

  def build_history
  history = ""

  @game.messages.last(10).each do |msg|
    author = msg.role == "user" ? "Joueur" : "Maître du Jeu"
    history += "#{author}: #{msg.content}\n\n"
  end

  history
 end
end
